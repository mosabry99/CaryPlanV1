import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:share_plus/share_plus.dart'; // Add to pubspec.yaml if share functionality is desired

import '../../../core/router/app_router.dart';
import '../../../models/care_plan_model.dart';
import '../../../repositories/care_plan_repository.dart';
import '../../../theme/app_theme.dart';

class CarePlanDetailScreen extends HookConsumerWidget {
  final String id;

  const CarePlanDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carePlanAsync = ref.watch(carePlanByIdProvider(id));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Local state for favorite button, initialized by the care plan's status
    final isFavoriteState = useState(false);

    // Update local favorite state when carePlanAsync loads or changes
    useEffect(() {
      if (carePlanAsync is AsyncData && carePlanAsync.value != null) {
        isFavoriteState.value = carePlanAsync.value!.isFavorite;
      }
      return null;
    }, [carePlanAsync]);

    Future<void> toggleFavorite(String carePlanId) async {
      final repository = ref.read(carePlanRepositoryProvider);
      final newFavoriteStatus = await repository.toggleFavorite(carePlanId);
      isFavoriteState.value = newFavoriteStatus;
      // Invalidate providers to reflect changes elsewhere
      ref.invalidate(allCarePlansProvider);
      ref.invalidate(favoriteCarePlansProvider);
      ref.invalidate(featuredCarePlansProvider);
      // If the care plan detail itself needs to show the updated favorite status
      // from the provider after this action, you might need to invalidate
      // carePlanByIdProvider(id) as well, or ensure the local state is sufficient.
      // For this screen, local state `isFavoriteState` handles immediate UI update.
    }

    // Future<void> shareCarePlan(CarePlanModel plan) async {
    //   final subject = 'Check out this Care Plan: ${plan.title}';
    //   final text = '''
    //   ${plan.title}\n
    //   Category: ${plan.category}\n
    //   Description: ${plan.description}\n
    //   Find more in the CarePlan Library app!
    //   ''';
    //   // Consider adding a link to the app or a specific deep link if available
    //   await Share.share(text, subject: subject);
    // }

    return Scaffold(
      body: carePlanAsync.when(
        data: (plan) {
          if (plan == null) {
            return _buildErrorUI(context, 'Care plan not found.');
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: plan.imageUrl != null ? 250.h : kToolbarHeight,
                floating: false,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    plan.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: plan.imageUrl != null ? Colors.white : colorScheme.onSurface,
                      shadows: plan.imageUrl != null ? [
                        const Shadow(blurRadius: 8.0, color: Colors.black54)
                      ] : null,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  centerTitle: true,
                  titlePadding: EdgeInsetsDirectional.only(
                    start: plan.imageUrl != null ? 72.w : 16.w, // Adjust padding based on image
                    bottom: 16.h,
                    end: 72.w, // Space for actions
                  ),
                  background: plan.imageUrl != null && plan.imageUrl!.startsWith('assets/')
                      ? Image.asset(
                          plan.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: colorScheme.surfaceVariant),
                        )
                      : plan.imageUrl != null
                          ? Image.network( // For network images
                              plan.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: colorScheme.surfaceVariant),
                            )
                          : Container(color: colorScheme.surface), // Fallback for appbar background
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      isFavoriteState.value
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFavoriteState.value ? colorScheme.primary : (plan.imageUrl != null ? Colors.white : colorScheme.onSurfaceVariant),
                    ),
                    tooltip: 'Favorite',
                    onPressed: () => toggleFavorite(plan.id),
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.share_rounded, color: plan.imageUrl != null ? Colors.white : colorScheme.onSurfaceVariant),
                  //   tooltip: 'Share',
                  //   onPressed: () => shareCarePlan(plan),
                  // ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.all(AppTheme.spacing16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildMetaInfo(context, plan),
                    SizedBox(height: AppTheme.spacing16),
                    Text(plan.description, style: theme.textTheme.bodyLarge),
                    SizedBox(height: AppTheme.spacing24),
                    _buildSection<AssessmentSection>(
                      context,
                      title: 'Assessments',
                      items: plan.assessments,
                      itemBuilder: (item) => _buildAssessmentItem(context, item),
                      icon: Icons.fact_check_outlined,
                    ),
                    _buildSection<NursingDiagnosis>(
                      context,
                      title: 'Nursing Diagnoses',
                      items: plan.nursingDiagnoses,
                      itemBuilder: (item) => _buildDiagnosisItem(context, item),
                      icon: Icons.assignment_ind_outlined,
                    ),
                    _buildSection<Goal>(
                      context,
                      title: 'Goals',
                      items: plan.goals,
                      itemBuilder: (item) => _buildGoalItem(context, item),
                      icon: Icons.flag_outlined,
                    ),
                    _buildSection<Intervention>(
                      context,
                      title: 'Interventions',
                      items: plan.interventions,
                      itemBuilder: (item) => _buildInterventionItem(context, item),
                      icon: Icons.medical_services_outlined,
                    ),
                    _buildSection<Evaluation>(
                      context,
                      title: 'Evaluations',
                      items: plan.evaluations,
                      itemBuilder: (item) => _buildEvaluationItem(context, item),
                      icon: Icons.rule_outlined,
                    ),
                    _buildSection<Reference>(
                      context,
                      title: 'References',
                      items: plan.references,
                      itemBuilder: (item) => _buildReferenceItem(context, item),
                      icon: Icons.menu_book_outlined,
                    ),
                    if (plan.notes != null && plan.notes!.isNotEmpty) ...[
                      SizedBox(height: AppTheme.spacing16),
                      _buildSectionHeader(context, 'Notes', Icons.notes_outlined),
                      SizedBox(height: AppTheme.spacing8),
                      Text(plan.notes!, style: theme.textTheme.bodyMedium),
                    ],
                    SizedBox(height: AppTheme.spacing64), // For bottom padding
                  ]),
                ),
              ),
            ],
          );
        },
        loading: () => _buildLoadingUI(context),
        error: (err, stack) => _buildErrorUI(context, err.toString()),
      ),
    );
  }

  Widget _buildMetaInfo(BuildContext context, CarePlanModel plan) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppTheme.spacing8,
          runSpacing: AppTheme.spacing4,
          children: [
            _MetaChip(icon: Icons.category_outlined, label: plan.category, color: colorScheme.secondary),
            if (plan.difficultyLevel.isNotEmpty)
              _MetaChip(icon: Icons.leaderboard_outlined, label: plan.difficultyLevel, color: colorScheme.tertiary),
            if (plan.timeFrame != null && plan.timeFrame!.isNotEmpty)
              _MetaChip(icon: Icons.timer_outlined, label: plan.timeFrame!, color: Colors.orange.shade700),
          ],
        ),
        SizedBox(height: AppTheme.spacing8),
        Text(
          'Last Updated: ${DateFormat.yMMMd().add_jm().format(plan.lastUpdated)}',
          style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant.withOpacity(0.7)),
        ),
        if (plan.tags.isNotEmpty) ...[
          SizedBox(height: AppTheme.spacing12),
          Wrap(
            spacing: AppTheme.spacing8,
            runSpacing: AppTheme.spacing4,
            children: plan.tags.map((tag) {
              return Chip(
                label: Text(tag),
                backgroundColor: colorScheme.surfaceVariant,
                labelStyle: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing8, vertical: AppTheme.spacing2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              );
            }).toList(),
          ),
        ],
        SizedBox(height: AppTheme.spacing16),
        Divider(color: colorScheme.outline.withOpacity(0.5)),
      ],
    );
  }

  Widget _buildSection<T>(
    BuildContext context, {
    required String title,
    required List<T> items,
    required Widget Function(T item) itemBuilder,
    required IconData icon,
    bool initiallyExpanded = false,
  }) {
    if (items.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppTheme.spacing8),
      child: ExpansionTile(
        key: PageStorageKey<String>(title), // Preserve expansion state
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        initiallyExpanded: initiallyExpanded,
        childrenPadding: EdgeInsets.only(left: AppTheme.spacing16, top: AppTheme.spacing8, bottom: AppTheme.spacing16),
        tilePadding: EdgeInsets.symmetric(horizontal: AppTheme.spacing8),
        children: items.map((item) => Padding(
          padding: EdgeInsets.only(bottom: AppTheme.spacing12),
          child: itemBuilder(item),
        )).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.primary, size: 24.sp),
        SizedBox(width: AppTheme.spacing8),
        Text(title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildAssessmentItem(BuildContext context, AssessmentSection item) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
        if (item.description != null && item.description!.isNotEmpty) ...[
          SizedBox(height: AppTheme.spacing4),
          Text(item.description!, style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
        ],
        SizedBox(height: AppTheme.spacing8),
        ...item.points.map((point) => _buildBulletPoint(context, point)),
      ],
    );
  }

  Widget _buildDiagnosisItem(BuildContext context, NursingDiagnosis item) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.statement, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
        if (item.nandaCode != null)
          Text('NANDA: ${item.nandaCode}', style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
        SizedBox(height: AppTheme.spacing8),
        if (item.relatedFactors.isNotEmpty) ...[
          Text('Related Factors:', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ...item.relatedFactors.map((factor) => _buildBulletPoint(context, factor)),
          SizedBox(height: AppTheme.spacing8),
        ],
        if (item.definingCharacteristics.isNotEmpty) ...[
          Text('Defining Characteristics:', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ...item.definingCharacteristics.map((char) => _buildBulletPoint(context, char)),
        ],
      ],
    );
  }

  Widget _buildGoalItem(BuildContext context, Goal item) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.statement, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
        Text('Type: ${item.type} ${item.timeframe != null ? "(${item.timeframe})" : ""}', style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
        SizedBox(height: AppTheme.spacing8),
        if (item.indicators.isNotEmpty) ...[
          Text('Indicators:', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ...item.indicators.map((indicator) => _buildBulletPoint(context, indicator)),
        ],
      ],
    );
  }

  Widget _buildInterventionItem(BuildContext context, Intervention item) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
        if (item.frequency != null)
          Text('Frequency: ${item.frequency}', style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic)),
        SizedBox(height: AppTheme.spacing8),
        if (item.actions.isNotEmpty) ...[
          Text('Actions:', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ...item.actions.map((action) => _buildBulletPoint(context, action)),
          SizedBox(height: AppTheme.spacing8),
        ],
        if (item.rationales.isNotEmpty) ...[
          Text('Rationales:', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ...item.rationales.map((rationale) => _buildBulletPoint(context, rationale, icon: Icons.lightbulb_outline_rounded, iconColor: Colors.amber.shade700)),
          SizedBox(height: AppTheme.spacing8),
        ],
        if (item.specialConsiderations != null && item.specialConsiderations!.isNotEmpty) ...[
          Text('Special Considerations:', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ...item.specialConsiderations!.map((sc) => _buildBulletPoint(context, sc, icon: Icons.warning_amber_rounded, iconColor: Colors.red.shade600)),
        ],
      ],
    );
  }

  Widget _buildEvaluationItem(BuildContext context, Evaluation item) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.statement, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
        SizedBox(height: AppTheme.spacing8),
        if (item.expectedOutcomes.isNotEmpty) ...[
          Text('Expected Outcomes:', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ...item.expectedOutcomes.map((outcome) => _buildBulletPoint(context, outcome)),
          SizedBox(height: AppTheme.spacing8),
        ],
        if (item.evaluationMethods != null && item.evaluationMethods!.isNotEmpty) ...[
          Text('Evaluation Methods:', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          ...item.evaluationMethods!.map((method) => _buildBulletPoint(context, method)),
        ],
      ],
    );
  }

  Widget _buildReferenceItem(BuildContext context, Reference item) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.spacing4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '${item.author} (${item.year}). ', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
            TextSpan(text: '${item.title}. ', style: theme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic)),
            TextSpan(text: '${item.source}.', style: theme.textTheme.bodyMedium),
            if (item.doi != null) TextSpan(text: ' DOI: ${item.doi}', style: theme.textTheme.bodyMedium),
            // if (item.url != null) // Could add a launch URL button here
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text, {IconData icon = Icons.arrow_right_rounded, Color? iconColor}) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: AppTheme.spacing8, top: AppTheme.spacing2, bottom: AppTheme.spacing2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.sp, color: iconColor ?? theme.colorScheme.onSurfaceVariant.withOpacity(0.8)),
          SizedBox(width: AppTheme.spacing8),
          Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }

  Widget _buildLoadingUI(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200.h,
          flexibleSpace: FlexibleSpaceBar(
            background: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(color: Colors.white),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(AppTheme.spacing16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: double.infinity, height: 24.h, color: Colors.white),
                    SizedBox(height: AppTheme.spacing8),
                    Container(width: 150.w, height: 16.h, color: Colors.white),
                    SizedBox(height: AppTheme.spacing16),
                    Container(width: double.infinity, height: 60.h, color: Colors.white),
                    SizedBox(height: AppTheme.spacing24),
                    ...List.generate(5, (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 200.w, height: 20.h, color: Colors.white),
                        SizedBox(height: AppTheme.spacing8),
                        Container(width: double.infinity, height: 40.h, color: Colors.white),
                        SizedBox(height: AppTheme.spacing16),
                      ],
                    ))
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorUI(BuildContext context, String message) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacing16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: theme.colorScheme.error, size: 60.sp),
              SizedBox(height: AppTheme.spacing16),
              Text('Failed to load Care Plan', style: theme.textTheme.headlineSmall),
              SizedBox(height: AppTheme.spacing8),
              Text(message, style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
              SizedBox(height: AppTheme.spacing24),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing8, vertical: AppTheme.spacing4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: color),
          SizedBox(width: AppTheme.spacing4),
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

