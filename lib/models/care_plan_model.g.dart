// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'care_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CarePlanModelImpl _$$CarePlanModelImplFromJson(Map<String, dynamic> json) =>
    _$CarePlanModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      assessments: (json['assessments'] as List<dynamic>)
          .map((e) => AssessmentSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      nursingDiagnoses: (json['nursingDiagnoses'] as List<dynamic>)
          .map((e) => NursingDiagnosis.fromJson(e as Map<String, dynamic>))
          .toList(),
      goals: (json['goals'] as List<dynamic>)
          .map((e) => Goal.fromJson(e as Map<String, dynamic>))
          .toList(),
      interventions: (json['interventions'] as List<dynamic>)
          .map((e) => Intervention.fromJson(e as Map<String, dynamic>))
          .toList(),
      evaluations: (json['evaluations'] as List<dynamic>)
          .map((e) => Evaluation.fromJson(e as Map<String, dynamic>))
          .toList(),
      references: (json['references'] as List<dynamic>)
          .map((e) => Reference.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
      difficultyLevel: json['difficultyLevel'] as String? ?? "Intermediate",
      timeFrame: json['timeFrame'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$CarePlanModelImplToJson(_$CarePlanModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'tags': instance.tags,
      'description': instance.description,
      'assessments': instance.assessments.map((e) => e.toJson()).toList(),
      'nursingDiagnoses':
          instance.nursingDiagnoses.map((e) => e.toJson()).toList(),
      'goals': instance.goals.map((e) => e.toJson()).toList(),
      'interventions': instance.interventions.map((e) => e.toJson()).toList(),
      'evaluations': instance.evaluations.map((e) => e.toJson()).toList(),
      'references': instance.references.map((e) => e.toJson()).toList(),
      'notes': instance.notes,
      'difficultyLevel': instance.difficultyLevel,
      'timeFrame': instance.timeFrame,
      'imageUrl': instance.imageUrl,
      'isFeatured': instance.isFeatured,
      'isFavorite': instance.isFavorite,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

_$AssessmentSectionImpl _$$AssessmentSectionImplFromJson(
        Map<String, dynamic> json) =>
    _$AssessmentSectionImpl(
      title: json['title'] as String,
      points:
          (json['points'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$AssessmentSectionImplToJson(
        _$AssessmentSectionImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'points': instance.points,
      'description': instance.description,
    };

_$NursingDiagnosisImpl _$$NursingDiagnosisImplFromJson(
        Map<String, dynamic> json) =>
    _$NursingDiagnosisImpl(
      statement: json['statement'] as String,
      relatedFactors: (json['relatedFactors'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      definingCharacteristics:
          (json['definingCharacteristics'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      nandaCode: json['nandaCode'] as String?,
    );

Map<String, dynamic> _$$NursingDiagnosisImplToJson(
        _$NursingDiagnosisImpl instance) =>
    <String, dynamic>{
      'statement': instance.statement,
      'relatedFactors': instance.relatedFactors,
      'definingCharacteristics': instance.definingCharacteristics,
      'nandaCode': instance.nandaCode,
    };

_$GoalImpl _$$GoalImplFromJson(Map<String, dynamic> json) => _$GoalImpl(
      statement: json['statement'] as String,
      indicators: (json['indicators'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      timeframe: json['timeframe'] as String?,
      type: json['type'] as String? ?? "Short-term",
    );

Map<String, dynamic> _$$GoalImplToJson(_$GoalImpl instance) =>
    <String, dynamic>{
      'statement': instance.statement,
      'indicators': instance.indicators,
      'timeframe': instance.timeframe,
      'type': instance.type,
    };

_$InterventionImpl _$$InterventionImplFromJson(Map<String, dynamic> json) =>
    _$InterventionImpl(
      title: json['title'] as String,
      actions:
          (json['actions'] as List<dynamic>).map((e) => e as String).toList(),
      rationales: (json['rationales'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      frequency: json['frequency'] as String?,
      specialConsiderations:
          (json['specialConsiderations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$$InterventionImplToJson(_$InterventionImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'actions': instance.actions,
      'rationales': instance.rationales,
      'frequency': instance.frequency,
      'specialConsiderations': instance.specialConsiderations,
    };

_$EvaluationImpl _$$EvaluationImplFromJson(Map<String, dynamic> json) =>
    _$EvaluationImpl(
      statement: json['statement'] as String,
      expectedOutcomes: (json['expectedOutcomes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      evaluationMethods: (json['evaluationMethods'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$EvaluationImplToJson(_$EvaluationImpl instance) =>
    <String, dynamic>{
      'statement': instance.statement,
      'expectedOutcomes': instance.expectedOutcomes,
      'evaluationMethods': instance.evaluationMethods,
    };

_$ReferenceImpl _$$ReferenceImplFromJson(Map<String, dynamic> json) =>
    _$ReferenceImpl(
      author: json['author'] as String,
      title: json['title'] as String,
      year: json['year'] as String,
      source: json['source'] as String,
      url: json['url'] as String?,
      doi: json['doi'] as String?,
    );

Map<String, dynamic> _$$ReferenceImplToJson(_$ReferenceImpl instance) =>
    <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'year': instance.year,
      'source': instance.source,
      'url': instance.url,
      'doi': instance.doi,
    };
