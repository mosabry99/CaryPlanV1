// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'care_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CarePlanModel _$CarePlanModelFromJson(Map<String, dynamic> json) {
  return _CarePlanModel.fromJson(json);
}

/// @nodoc
mixin _$CarePlanModel {
  /// Unique identifier for the care plan
  String get id => throw _privateConstructorUsedError;

  /// Title of the care plan
  String get title => throw _privateConstructorUsedError;

  /// Primary category of the care plan (e.g., "Cardiovascular", "Respiratory")
  String get category => throw _privateConstructorUsedError;

  /// List of subcategories or tags for more specific classification
  List<String> get tags => throw _privateConstructorUsedError;

  /// Brief description or overview of the care plan
  String get description => throw _privateConstructorUsedError;

  /// Detailed assessment findings and data collection
  List<AssessmentSection> get assessments => throw _privateConstructorUsedError;

  /// Nursing diagnoses identified based on the assessments
  List<NursingDiagnosis> get nursingDiagnoses =>
      throw _privateConstructorUsedError;

  /// Expected outcomes and goals for the patient
  List<Goal> get goals => throw _privateConstructorUsedError;

  /// Nursing interventions to address the diagnoses and achieve goals
  List<Intervention> get interventions => throw _privateConstructorUsedError;

  /// Evaluation criteria and methods to determine effectiveness
  List<Evaluation> get evaluations => throw _privateConstructorUsedError;

  /// Scientific references and evidence supporting the care plan
  List<Reference> get references => throw _privateConstructorUsedError;

  /// Optional notes or additional information
  String? get notes => throw _privateConstructorUsedError;

  /// Difficulty or complexity level (e.g., "Basic", "Intermediate", "Advanced")
  String get difficultyLevel => throw _privateConstructorUsedError;

  /// Estimated time frame for the care plan
  String? get timeFrame => throw _privateConstructorUsedError;

  /// URL to an image or icon representing the care plan
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Whether this care plan is featured
  bool get isFeatured => throw _privateConstructorUsedError;

  /// Whether this care plan is marked as favorite by the user
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Date when the care plan was created or last updated
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CarePlanModelCopyWith<CarePlanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarePlanModelCopyWith<$Res> {
  factory $CarePlanModelCopyWith(
          CarePlanModel value, $Res Function(CarePlanModel) then) =
      _$CarePlanModelCopyWithImpl<$Res, CarePlanModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String category,
      List<String> tags,
      String description,
      List<AssessmentSection> assessments,
      List<NursingDiagnosis> nursingDiagnoses,
      List<Goal> goals,
      List<Intervention> interventions,
      List<Evaluation> evaluations,
      List<Reference> references,
      String? notes,
      String difficultyLevel,
      String? timeFrame,
      String? imageUrl,
      bool isFeatured,
      bool isFavorite,
      DateTime lastUpdated});
}

/// @nodoc
class _$CarePlanModelCopyWithImpl<$Res, $Val extends CarePlanModel>
    implements $CarePlanModelCopyWith<$Res> {
  _$CarePlanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? category = null,
    Object? tags = null,
    Object? description = null,
    Object? assessments = null,
    Object? nursingDiagnoses = null,
    Object? goals = null,
    Object? interventions = null,
    Object? evaluations = null,
    Object? references = null,
    Object? notes = freezed,
    Object? difficultyLevel = null,
    Object? timeFrame = freezed,
    Object? imageUrl = freezed,
    Object? isFeatured = null,
    Object? isFavorite = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      assessments: null == assessments
          ? _value.assessments
          : assessments // ignore: cast_nullable_to_non_nullable
              as List<AssessmentSection>,
      nursingDiagnoses: null == nursingDiagnoses
          ? _value.nursingDiagnoses
          : nursingDiagnoses // ignore: cast_nullable_to_non_nullable
              as List<NursingDiagnosis>,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<Goal>,
      interventions: null == interventions
          ? _value.interventions
          : interventions // ignore: cast_nullable_to_non_nullable
              as List<Intervention>,
      evaluations: null == evaluations
          ? _value.evaluations
          : evaluations // ignore: cast_nullable_to_non_nullable
              as List<Evaluation>,
      references: null == references
          ? _value.references
          : references // ignore: cast_nullable_to_non_nullable
              as List<Reference>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as String,
      timeFrame: freezed == timeFrame
          ? _value.timeFrame
          : timeFrame // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CarePlanModelImplCopyWith<$Res>
    implements $CarePlanModelCopyWith<$Res> {
  factory _$$CarePlanModelImplCopyWith(_$CarePlanModelImpl value,
          $Res Function(_$CarePlanModelImpl) then) =
      __$$CarePlanModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String category,
      List<String> tags,
      String description,
      List<AssessmentSection> assessments,
      List<NursingDiagnosis> nursingDiagnoses,
      List<Goal> goals,
      List<Intervention> interventions,
      List<Evaluation> evaluations,
      List<Reference> references,
      String? notes,
      String difficultyLevel,
      String? timeFrame,
      String? imageUrl,
      bool isFeatured,
      bool isFavorite,
      DateTime lastUpdated});
}

/// @nodoc
class __$$CarePlanModelImplCopyWithImpl<$Res>
    extends _$CarePlanModelCopyWithImpl<$Res, _$CarePlanModelImpl>
    implements _$$CarePlanModelImplCopyWith<$Res> {
  __$$CarePlanModelImplCopyWithImpl(
      _$CarePlanModelImpl _value, $Res Function(_$CarePlanModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? category = null,
    Object? tags = null,
    Object? description = null,
    Object? assessments = null,
    Object? nursingDiagnoses = null,
    Object? goals = null,
    Object? interventions = null,
    Object? evaluations = null,
    Object? references = null,
    Object? notes = freezed,
    Object? difficultyLevel = null,
    Object? timeFrame = freezed,
    Object? imageUrl = freezed,
    Object? isFeatured = null,
    Object? isFavorite = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$CarePlanModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      assessments: null == assessments
          ? _value._assessments
          : assessments // ignore: cast_nullable_to_non_nullable
              as List<AssessmentSection>,
      nursingDiagnoses: null == nursingDiagnoses
          ? _value._nursingDiagnoses
          : nursingDiagnoses // ignore: cast_nullable_to_non_nullable
              as List<NursingDiagnosis>,
      goals: null == goals
          ? _value._goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<Goal>,
      interventions: null == interventions
          ? _value._interventions
          : interventions // ignore: cast_nullable_to_non_nullable
              as List<Intervention>,
      evaluations: null == evaluations
          ? _value._evaluations
          : evaluations // ignore: cast_nullable_to_non_nullable
              as List<Evaluation>,
      references: null == references
          ? _value._references
          : references // ignore: cast_nullable_to_non_nullable
              as List<Reference>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyLevel: null == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as String,
      timeFrame: freezed == timeFrame
          ? _value.timeFrame
          : timeFrame // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CarePlanModelImpl
    with DiagnosticableTreeMixin
    implements _CarePlanModel {
  const _$CarePlanModelImpl(
      {required this.id,
      required this.title,
      required this.category,
      required final List<String> tags,
      required this.description,
      required final List<AssessmentSection> assessments,
      required final List<NursingDiagnosis> nursingDiagnoses,
      required final List<Goal> goals,
      required final List<Intervention> interventions,
      required final List<Evaluation> evaluations,
      required final List<Reference> references,
      this.notes,
      this.difficultyLevel = "Intermediate",
      this.timeFrame,
      this.imageUrl,
      this.isFeatured = false,
      this.isFavorite = false,
      required this.lastUpdated})
      : _tags = tags,
        _assessments = assessments,
        _nursingDiagnoses = nursingDiagnoses,
        _goals = goals,
        _interventions = interventions,
        _evaluations = evaluations,
        _references = references;

  factory _$CarePlanModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CarePlanModelImplFromJson(json);

  /// Unique identifier for the care plan
  @override
  final String id;

  /// Title of the care plan
  @override
  final String title;

  /// Primary category of the care plan (e.g., "Cardiovascular", "Respiratory")
  @override
  final String category;

  /// List of subcategories or tags for more specific classification
  final List<String> _tags;

  /// List of subcategories or tags for more specific classification
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// Brief description or overview of the care plan
  @override
  final String description;

  /// Detailed assessment findings and data collection
  final List<AssessmentSection> _assessments;

  /// Detailed assessment findings and data collection
  @override
  List<AssessmentSection> get assessments {
    if (_assessments is EqualUnmodifiableListView) return _assessments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assessments);
  }

  /// Nursing diagnoses identified based on the assessments
  final List<NursingDiagnosis> _nursingDiagnoses;

  /// Nursing diagnoses identified based on the assessments
  @override
  List<NursingDiagnosis> get nursingDiagnoses {
    if (_nursingDiagnoses is EqualUnmodifiableListView)
      return _nursingDiagnoses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nursingDiagnoses);
  }

  /// Expected outcomes and goals for the patient
  final List<Goal> _goals;

  /// Expected outcomes and goals for the patient
  @override
  List<Goal> get goals {
    if (_goals is EqualUnmodifiableListView) return _goals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goals);
  }

  /// Nursing interventions to address the diagnoses and achieve goals
  final List<Intervention> _interventions;

  /// Nursing interventions to address the diagnoses and achieve goals
  @override
  List<Intervention> get interventions {
    if (_interventions is EqualUnmodifiableListView) return _interventions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interventions);
  }

  /// Evaluation criteria and methods to determine effectiveness
  final List<Evaluation> _evaluations;

  /// Evaluation criteria and methods to determine effectiveness
  @override
  List<Evaluation> get evaluations {
    if (_evaluations is EqualUnmodifiableListView) return _evaluations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_evaluations);
  }

  /// Scientific references and evidence supporting the care plan
  final List<Reference> _references;

  /// Scientific references and evidence supporting the care plan
  @override
  List<Reference> get references {
    if (_references is EqualUnmodifiableListView) return _references;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_references);
  }

  /// Optional notes or additional information
  @override
  final String? notes;

  /// Difficulty or complexity level (e.g., "Basic", "Intermediate", "Advanced")
  @override
  @JsonKey()
  final String difficultyLevel;

  /// Estimated time frame for the care plan
  @override
  final String? timeFrame;

  /// URL to an image or icon representing the care plan
  @override
  final String? imageUrl;

  /// Whether this care plan is featured
  @override
  @JsonKey()
  final bool isFeatured;

  /// Whether this care plan is marked as favorite by the user
  @override
  @JsonKey()
  final bool isFavorite;

  /// Date when the care plan was created or last updated
  @override
  final DateTime lastUpdated;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CarePlanModel(id: $id, title: $title, category: $category, tags: $tags, description: $description, assessments: $assessments, nursingDiagnoses: $nursingDiagnoses, goals: $goals, interventions: $interventions, evaluations: $evaluations, references: $references, notes: $notes, difficultyLevel: $difficultyLevel, timeFrame: $timeFrame, imageUrl: $imageUrl, isFeatured: $isFeatured, isFavorite: $isFavorite, lastUpdated: $lastUpdated)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CarePlanModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('assessments', assessments))
      ..add(DiagnosticsProperty('nursingDiagnoses', nursingDiagnoses))
      ..add(DiagnosticsProperty('goals', goals))
      ..add(DiagnosticsProperty('interventions', interventions))
      ..add(DiagnosticsProperty('evaluations', evaluations))
      ..add(DiagnosticsProperty('references', references))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('difficultyLevel', difficultyLevel))
      ..add(DiagnosticsProperty('timeFrame', timeFrame))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('isFeatured', isFeatured))
      ..add(DiagnosticsProperty('isFavorite', isFavorite))
      ..add(DiagnosticsProperty('lastUpdated', lastUpdated));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarePlanModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._assessments, _assessments) &&
            const DeepCollectionEquality()
                .equals(other._nursingDiagnoses, _nursingDiagnoses) &&
            const DeepCollectionEquality().equals(other._goals, _goals) &&
            const DeepCollectionEquality()
                .equals(other._interventions, _interventions) &&
            const DeepCollectionEquality()
                .equals(other._evaluations, _evaluations) &&
            const DeepCollectionEquality()
                .equals(other._references, _references) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.timeFrame, timeFrame) ||
                other.timeFrame == timeFrame) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      category,
      const DeepCollectionEquality().hash(_tags),
      description,
      const DeepCollectionEquality().hash(_assessments),
      const DeepCollectionEquality().hash(_nursingDiagnoses),
      const DeepCollectionEquality().hash(_goals),
      const DeepCollectionEquality().hash(_interventions),
      const DeepCollectionEquality().hash(_evaluations),
      const DeepCollectionEquality().hash(_references),
      notes,
      difficultyLevel,
      timeFrame,
      imageUrl,
      isFeatured,
      isFavorite,
      lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CarePlanModelImplCopyWith<_$CarePlanModelImpl> get copyWith =>
      __$$CarePlanModelImplCopyWithImpl<_$CarePlanModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CarePlanModelImplToJson(
      this,
    );
  }
}

abstract class _CarePlanModel implements CarePlanModel {
  const factory _CarePlanModel(
      {required final String id,
      required final String title,
      required final String category,
      required final List<String> tags,
      required final String description,
      required final List<AssessmentSection> assessments,
      required final List<NursingDiagnosis> nursingDiagnoses,
      required final List<Goal> goals,
      required final List<Intervention> interventions,
      required final List<Evaluation> evaluations,
      required final List<Reference> references,
      final String? notes,
      final String difficultyLevel,
      final String? timeFrame,
      final String? imageUrl,
      final bool isFeatured,
      final bool isFavorite,
      required final DateTime lastUpdated}) = _$CarePlanModelImpl;

  factory _CarePlanModel.fromJson(Map<String, dynamic> json) =
      _$CarePlanModelImpl.fromJson;

  @override

  /// Unique identifier for the care plan
  String get id;
  @override

  /// Title of the care plan
  String get title;
  @override

  /// Primary category of the care plan (e.g., "Cardiovascular", "Respiratory")
  String get category;
  @override

  /// List of subcategories or tags for more specific classification
  List<String> get tags;
  @override

  /// Brief description or overview of the care plan
  String get description;
  @override

  /// Detailed assessment findings and data collection
  List<AssessmentSection> get assessments;
  @override

  /// Nursing diagnoses identified based on the assessments
  List<NursingDiagnosis> get nursingDiagnoses;
  @override

  /// Expected outcomes and goals for the patient
  List<Goal> get goals;
  @override

  /// Nursing interventions to address the diagnoses and achieve goals
  List<Intervention> get interventions;
  @override

  /// Evaluation criteria and methods to determine effectiveness
  List<Evaluation> get evaluations;
  @override

  /// Scientific references and evidence supporting the care plan
  List<Reference> get references;
  @override

  /// Optional notes or additional information
  String? get notes;
  @override

  /// Difficulty or complexity level (e.g., "Basic", "Intermediate", "Advanced")
  String get difficultyLevel;
  @override

  /// Estimated time frame for the care plan
  String? get timeFrame;
  @override

  /// URL to an image or icon representing the care plan
  String? get imageUrl;
  @override

  /// Whether this care plan is featured
  bool get isFeatured;
  @override

  /// Whether this care plan is marked as favorite by the user
  bool get isFavorite;
  @override

  /// Date when the care plan was created or last updated
  DateTime get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$CarePlanModelImplCopyWith<_$CarePlanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssessmentSection _$AssessmentSectionFromJson(Map<String, dynamic> json) {
  return _AssessmentSection.fromJson(json);
}

/// @nodoc
mixin _$AssessmentSection {
  /// Title of the assessment section (e.g., "Vital Signs", "Physical Examination")
  String get title => throw _privateConstructorUsedError;

  /// List of specific assessment points or findings
  List<String> get points => throw _privateConstructorUsedError;

  /// Optional additional information about the assessment section
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssessmentSectionCopyWith<AssessmentSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentSectionCopyWith<$Res> {
  factory $AssessmentSectionCopyWith(
          AssessmentSection value, $Res Function(AssessmentSection) then) =
      _$AssessmentSectionCopyWithImpl<$Res, AssessmentSection>;
  @useResult
  $Res call({String title, List<String> points, String? description});
}

/// @nodoc
class _$AssessmentSectionCopyWithImpl<$Res, $Val extends AssessmentSection>
    implements $AssessmentSectionCopyWith<$Res> {
  _$AssessmentSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? points = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssessmentSectionImplCopyWith<$Res>
    implements $AssessmentSectionCopyWith<$Res> {
  factory _$$AssessmentSectionImplCopyWith(_$AssessmentSectionImpl value,
          $Res Function(_$AssessmentSectionImpl) then) =
      __$$AssessmentSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<String> points, String? description});
}

/// @nodoc
class __$$AssessmentSectionImplCopyWithImpl<$Res>
    extends _$AssessmentSectionCopyWithImpl<$Res, _$AssessmentSectionImpl>
    implements _$$AssessmentSectionImplCopyWith<$Res> {
  __$$AssessmentSectionImplCopyWithImpl(_$AssessmentSectionImpl _value,
      $Res Function(_$AssessmentSectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? points = null,
    Object? description = freezed,
  }) {
    return _then(_$AssessmentSectionImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssessmentSectionImpl
    with DiagnosticableTreeMixin
    implements _AssessmentSection {
  const _$AssessmentSectionImpl(
      {required this.title,
      required final List<String> points,
      this.description})
      : _points = points;

  factory _$AssessmentSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssessmentSectionImplFromJson(json);

  /// Title of the assessment section (e.g., "Vital Signs", "Physical Examination")
  @override
  final String title;

  /// List of specific assessment points or findings
  final List<String> _points;

  /// List of specific assessment points or findings
  @override
  List<String> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  /// Optional additional information about the assessment section
  @override
  final String? description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AssessmentSection(title: $title, points: $points, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AssessmentSection'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentSectionImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title,
      const DeepCollectionEquality().hash(_points), description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentSectionImplCopyWith<_$AssessmentSectionImpl> get copyWith =>
      __$$AssessmentSectionImplCopyWithImpl<_$AssessmentSectionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssessmentSectionImplToJson(
      this,
    );
  }
}

abstract class _AssessmentSection implements AssessmentSection {
  const factory _AssessmentSection(
      {required final String title,
      required final List<String> points,
      final String? description}) = _$AssessmentSectionImpl;

  factory _AssessmentSection.fromJson(Map<String, dynamic> json) =
      _$AssessmentSectionImpl.fromJson;

  @override

  /// Title of the assessment section (e.g., "Vital Signs", "Physical Examination")
  String get title;
  @override

  /// List of specific assessment points or findings
  List<String> get points;
  @override

  /// Optional additional information about the assessment section
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$AssessmentSectionImplCopyWith<_$AssessmentSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NursingDiagnosis _$NursingDiagnosisFromJson(Map<String, dynamic> json) {
  return _NursingDiagnosis.fromJson(json);
}

/// @nodoc
mixin _$NursingDiagnosis {
  /// The formal nursing diagnosis statement
  String get statement => throw _privateConstructorUsedError;

  /// Related factors contributing to the diagnosis
  List<String> get relatedFactors => throw _privateConstructorUsedError;

  /// Defining characteristics or symptoms supporting the diagnosis
  List<String> get definingCharacteristics => throw _privateConstructorUsedError;

  /// Optional NANDA-I code for standardized diagnosis
  String? get nandaCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NursingDiagnosisCopyWith<NursingDiagnosis> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NursingDiagnosisCopyWith<$Res> {
  factory $NursingDiagnosisCopyWith(
          NursingDiagnosis value, $Res Function(NursingDiagnosis) then) =
      _$NursingDiagnosisCopyWithImpl<$Res, NursingDiagnosis>;
  @useResult
  $Res call(
      {String statement,
      List<String> relatedFactors,
      List<String> definingCharacteristics,
      String? nandaCode});
}

/// @nodoc
class _$NursingDiagnosisCopyWithImpl<$Res, $Val extends NursingDiagnosis>
    implements $NursingDiagnosisCopyWith<$Res> {
  _$NursingDiagnosisCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statement = null,
    Object? relatedFactors = null,
    Object? definingCharacteristics = null,
    Object? nandaCode = freezed,
  }) {
    return _then(_value.copyWith(
      statement: null == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String,
      relatedFactors: null == relatedFactors
          ? _value.relatedFactors
          : relatedFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      definingCharacteristics: null == definingCharacteristics
          ? _value.definingCharacteristics
          : definingCharacteristics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nandaCode: freezed == nandaCode
          ? _value.nandaCode
          : nandaCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NursingDiagnosisImplCopyWith<$Res>
    implements $NursingDiagnosisCopyWith<$Res> {
  factory _$$NursingDiagnosisImplCopyWith(_$NursingDiagnosisImpl value,
          $Res Function(_$NursingDiagnosisImpl) then) =
      __$$NursingDiagnosisImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String statement,
      List<String> relatedFactors,
      List<String> definingCharacteristics,
      String? nandaCode});
}

/// @nodoc
class __$$NursingDiagnosisImplCopyWithImpl<$Res>
    extends _$NursingDiagnosisCopyWithImpl<$Res, _$NursingDiagnosisImpl>
    implements _$$NursingDiagnosisImplCopyWith<$Res> {
  __$$NursingDiagnosisImplCopyWithImpl(_$NursingDiagnosisImpl _value,
      $Res Function(_$NursingDiagnosisImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statement = null,
    Object? relatedFactors = null,
    Object? definingCharacteristics = null,
    Object? nandaCode = freezed,
  }) {
    return _then(_$NursingDiagnosisImpl(
      statement: null == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String,
      relatedFactors: null == relatedFactors
          ? _value._relatedFactors
          : relatedFactors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      definingCharacteristics: null == definingCharacteristics
          ? _value._definingCharacteristics
          : definingCharacteristics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nandaCode: freezed == nandaCode
          ? _value.nandaCode
          : nandaCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NursingDiagnosisImpl
    with DiagnosticableTreeMixin
    implements _NursingDiagnosis {
  const _$NursingDiagnosisImpl(
      {required this.statement,
      required final List<String> relatedFactors,
      required final List<String> definingCharacteristics,
      this.nandaCode})
      : _relatedFactors = relatedFactors,
        _definingCharacteristics = definingCharacteristics;

  factory _$NursingDiagnosisImpl.fromJson(Map<String, dynamic> json) =>
      _$$NursingDiagnosisImplFromJson(json);

  /// The formal nursing diagnosis statement
  @override
  final String statement;

  /// Related factors contributing to the diagnosis
  final List<String> _relatedFactors;

  /// Related factors contributing to the diagnosis
  @override
  List<String> get relatedFactors {
    if (_relatedFactors is EqualUnmodifiableListView) return _relatedFactors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedFactors);
  }

  /// Defining characteristics or symptoms supporting the diagnosis
  final List<String> _definingCharacteristics;

  /// Defining characteristics or symptoms supporting the diagnosis
  @override
  List<String> get definingCharacteristics {
    if (_definingCharacteristics is EqualUnmodifiableListView)
      return _definingCharacteristics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_definingCharacteristics);
  }

  /// Optional NANDA-I code for standardized diagnosis
  @override
  final String? nandaCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NursingDiagnosis(statement: $statement, relatedFactors: $relatedFactors, definingCharacteristics: $definingCharacteristics, nandaCode: $nandaCode)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NursingDiagnosis'))
      ..add(DiagnosticsProperty('statement', statement))
      ..add(DiagnosticsProperty('relatedFactors', relatedFactors))
      ..add(DiagnosticsProperty(
          'definingCharacteristics', definingCharacteristics))
      ..add(DiagnosticsProperty('nandaCode', nandaCode));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NursingDiagnosisImpl &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            const DeepCollectionEquality()
                .equals(other._relatedFactors, _relatedFactors) &&
            const DeepCollectionEquality().equals(
                other._definingCharacteristics, _definingCharacteristics) &&
            (identical(other.nandaCode, nandaCode) ||
                other.nandaCode == nandaCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      statement,
      const DeepCollectionEquality().hash(_relatedFactors),
      const DeepCollectionEquality().hash(_definingCharacteristics),
      nandaCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NursingDiagnosisImplCopyWith<_$NursingDiagnosisImpl> get copyWith =>
      __$$NursingDiagnosisImplCopyWithImpl<_$NursingDiagnosisImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NursingDiagnosisImplToJson(
      this,
    );
  }
}

abstract class _NursingDiagnosis implements NursingDiagnosis {
  const factory _NursingDiagnosis(
      {required final String statement,
      required final List<String> relatedFactors,
      required final List<String> definingCharacteristics,
      final String? nandaCode}) = _$NursingDiagnosisImpl;

  factory _NursingDiagnosis.fromJson(Map<String, dynamic> json) =
      _$NursingDiagnosisImpl.fromJson;

  @override

  /// The formal nursing diagnosis statement
  String get statement;
  @override

  /// Related factors contributing to the diagnosis
  List<String> get relatedFactors;
  @override

  /// Defining characteristics or symptoms supporting the diagnosis
  List<String> get definingCharacteristics;
  @override

  /// Optional NANDA-I code for standardized diagnosis
  String? get nandaCode;
  @override
  @JsonKey(ignore: true)
  _$$NursingDiagnosisImplCopyWith<_$NursingDiagnosisImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
mixin _$Goal {
  /// The goal statement describing the expected outcome
  String get statement => throw _privateConstructorUsedError;

  /// Indicators to measure progress toward the goal
  List<String> get indicators => throw _privateConstructorUsedError;

  /// Target timeframe for achieving the goal
  String? get timeframe => throw _privateConstructorUsedError;

  /// Whether this is a short-term or long-term goal
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalCopyWith<Goal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res, Goal>;
  @useResult
  $Res call(
      {String statement,
      List<String> indicators,
      String? timeframe,
      String type});
}

/// @nodoc
class _$GoalCopyWithImpl<$Res, $Val extends Goal>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statement = null,
    Object? indicators = null,
    Object? timeframe = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      statement: null == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String,
      indicators: null == indicators
          ? _value.indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timeframe: freezed == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalImplCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$$GoalImplCopyWith(
          _$GoalImpl value, $Res Function(_$GoalImpl) then) =
      __$$GoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String statement,
      List<String> indicators,
      String? timeframe,
      String type});
}

/// @nodoc
class __$$GoalImplCopyWithImpl<$Res>
    extends _$GoalCopyWithImpl<$Res, _$GoalImpl>
    implements _$$GoalImplCopyWith<$Res> {
  __$$GoalImplCopyWithImpl(_$GoalImpl _value, $Res Function(_$GoalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statement = null,
    Object? indicators = null,
    Object? timeframe = freezed,
    Object? type = null,
  }) {
    return _then(_$GoalImpl(
      statement: null == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String,
      indicators: null == indicators
          ? _value._indicators
          : indicators // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timeframe: freezed == timeframe
          ? _value.timeframe
          : timeframe // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalImpl with DiagnosticableTreeMixin implements _Goal {
  const _$GoalImpl(
      {required this.statement,
      required final List<String> indicators,
      this.timeframe,
      this.type = "Short-term"})
      : _indicators = indicators;

  factory _$GoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalImplFromJson(json);

  /// The goal statement describing the expected outcome
  @override
  final String statement;

  /// Indicators to measure progress toward the goal
  final List<String> _indicators;

  /// Indicators to measure progress toward the goal
  @override
  List<String> get indicators {
    if (_indicators is EqualUnmodifiableListView) return _indicators;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_indicators);
  }

  /// Target timeframe for achieving the goal
  @override
  final String? timeframe;

  /// Whether this is a short-term or long-term goal
  @override
  @JsonKey()
  final String type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Goal(statement: $statement, indicators: $indicators, timeframe: $timeframe, type: $type)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Goal'))
      ..add(DiagnosticsProperty('statement', statement))
      ..add(DiagnosticsProperty('indicators', indicators))
      ..add(DiagnosticsProperty('timeframe', timeframe))
      ..add(DiagnosticsProperty('type', type));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalImpl &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            const DeepCollectionEquality()
                .equals(other._indicators, _indicators) &&
            (identical(other.timeframe, timeframe) ||
                other.timeframe == timeframe) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, statement,
      const DeepCollectionEquality().hash(_indicators), timeframe, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      __$$GoalImplCopyWithImpl<_$GoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalImplToJson(
      this,
    );
  }
}

abstract class _Goal implements Goal {
  const factory _Goal(
      {required final String statement,
      required final List<String> indicators,
      final String? timeframe,
      final String type}) = _$GoalImpl;

  factory _Goal.fromJson(Map<String, dynamic> json) = _$GoalImpl.fromJson;

  @override

  /// The goal statement describing the expected outcome
  String get statement;
  @override

  /// Indicators to measure progress toward the goal
  List<String> get indicators;
  @override

  /// Target timeframe for achieving the goal
  String? get timeframe;
  @override

  /// Whether this is a short-term or long-term goal
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Intervention _$InterventionFromJson(Map<String, dynamic> json) {
  return _Intervention.fromJson(json);
}

/// @nodoc
mixin _$Intervention {
  /// Title or category of the intervention
  String get title => throw _privateConstructorUsedError;

  /// List of specific nursing actions
  List<String> get actions => throw _privateConstructorUsedError;

  /// Rationale explaining why each intervention is effective
  List<String> get rationales => throw _privateConstructorUsedError;

  /// Optional frequency or timing of the intervention
  String? get frequency => throw _privateConstructorUsedError;

  /// Optional special considerations or precautions
  List<String>? get specialConsiderations => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InterventionCopyWith<Intervention> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterventionCopyWith<$Res> {
  factory $InterventionCopyWith(
          Intervention value, $Res Function(Intervention) then) =
      _$InterventionCopyWithImpl<$Res, Intervention>;
  @useResult
  $Res call(
      {String title,
      List<String> actions,
      List<String> rationales,
      String? frequency,
      List<String>? specialConsiderations});
}

/// @nodoc
class _$InterventionCopyWithImpl<$Res, $Val extends Intervention>
    implements $InterventionCopyWith<$Res> {
  _$InterventionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? actions = null,
    Object? rationales = null,
    Object? frequency = freezed,
    Object? specialConsiderations = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      actions: null == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rationales: null == rationales
          ? _value.rationales
          : rationales // ignore: cast_nullable_to_non_nullable
              as List<String>,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String?,
      specialConsiderations: freezed == specialConsiderations
          ? _value.specialConsiderations
          : specialConsiderations // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterventionImplCopyWith<$Res>
    implements $InterventionCopyWith<$Res> {
  factory _$$InterventionImplCopyWith(_$InterventionImpl value,
          $Res Function(_$InterventionImpl) then) =
      __$$InterventionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      List<String> actions,
      List<String> rationales,
      String? frequency,
      List<String>? specialConsiderations});
}

/// @nodoc
class __$$InterventionImplCopyWithImpl<$Res>
    extends _$InterventionCopyWithImpl<$Res, _$InterventionImpl>
    implements _$$InterventionImplCopyWith<$Res> {
  __$$InterventionImplCopyWithImpl(
      _$InterventionImpl _value, $Res Function(_$InterventionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? actions = null,
    Object? rationales = null,
    Object? frequency = freezed,
    Object? specialConsiderations = freezed,
  }) {
    return _then(_$InterventionImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      actions: null == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rationales: null == rationales
          ? _value._rationales
          : rationales // ignore: cast_nullable_to_non_nullable
              as List<String>,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as String?,
      specialConsiderations: freezed == specialConsiderations
          ? _value._specialConsiderations
          : specialConsiderations // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InterventionImpl with DiagnosticableTreeMixin implements _Intervention {
  const _$InterventionImpl(
      {required this.title,
      required final List<String> actions,
      required final List<String> rationales,
      this.frequency,
      final List<String>? specialConsiderations})
      : _actions = actions,
        _rationales = rationales,
        _specialConsiderations = specialConsiderations;

  factory _$InterventionImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterventionImplFromJson(json);

  /// Title or category of the intervention
  @override
  final String title;

  /// List of specific nursing actions
  final List<String> _actions;

  /// List of specific nursing actions
  @override
  List<String> get actions {
    if (_actions is EqualUnmodifiableListView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actions);
  }

  /// Rationale explaining why each intervention is effective
  final List<String> _rationales;

  /// Rationale explaining why each intervention is effective
  @override
  List<String> get rationales {
    if (_rationales is EqualUnmodifiableListView) return _rationales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rationales);
  }

  /// Optional frequency or timing of the intervention
  @override
  final String? frequency;

  /// Optional special considerations or precautions
  final List<String>? _specialConsiderations;

  /// Optional special considerations or precautions
  @override
  List<String>? get specialConsiderations {
    final value = _specialConsiderations;
    if (value == null) return null;
    if (_specialConsiderations is EqualUnmodifiableListView)
      return _specialConsiderations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Intervention(title: $title, actions: $actions, rationales: $rationales, frequency: $frequency, specialConsiderations: $specialConsiderations)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Intervention'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('actions', actions))
      ..add(DiagnosticsProperty('rationales', rationales))
      ..add(DiagnosticsProperty('frequency', frequency))
      ..add(
          DiagnosticsProperty('specialConsiderations', specialConsiderations));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            const DeepCollectionEquality()
                .equals(other._rationales, _rationales) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            const DeepCollectionEquality().equals(
                other._specialConsiderations, _specialConsiderations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_actions),
      const DeepCollectionEquality().hash(_rationales),
      frequency,
      const DeepCollectionEquality().hash(_specialConsiderations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InterventionImplCopyWith<_$InterventionImpl> get copyWith =>
      __$$InterventionImplCopyWithImpl<_$InterventionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterventionImplToJson(
      this,
    );
  }
}

abstract class _Intervention implements Intervention {
  const factory _Intervention(
      {required final String title,
      required final List<String> actions,
      required final List<String> rationales,
      final String? frequency,
      final List<String>? specialConsiderations}) = _$InterventionImpl;

  factory _Intervention.fromJson(Map<String, dynamic> json) =
      _$InterventionImpl.fromJson;

  @override

  /// Title or category of the intervention
  String get title;
  @override

  /// List of specific nursing actions
  List<String> get actions;
  @override

  /// Rationale explaining why each intervention is effective
  List<String> get rationales;
  @override

  /// Optional frequency or timing of the intervention
  String? get frequency;
  @override

  /// Optional special considerations or precautions
  List<String>? get specialConsiderations;
  @override
  @JsonKey(ignore: true)
  _$$InterventionImplCopyWith<_$InterventionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Evaluation _$EvaluationFromJson(Map<String, dynamic> json) {
  return _Evaluation.fromJson(json);
}

/// @nodoc
mixin _$Evaluation {
  /// The evaluation statement or question
  String get statement => throw _privateConstructorUsedError;

  /// Expected outcomes indicating successful intervention
  List<String> get expectedOutcomes => throw _privateConstructorUsedError;

  /// Methods or tools for measuring outcomes
  List<String>? get evaluationMethods => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EvaluationCopyWith<Evaluation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EvaluationCopyWith<$Res> {
  factory $EvaluationCopyWith(
          Evaluation value, $Res Function(Evaluation) then) =
      _$EvaluationCopyWithImpl<$Res, Evaluation>;
  @useResult
  $Res call(
      {String statement,
      List<String> expectedOutcomes,
      List<String>? evaluationMethods});
}

/// @nodoc
class _$EvaluationCopyWithImpl<$Res, $Val extends Evaluation>
    implements $EvaluationCopyWith<$Res> {
  _$EvaluationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statement = null,
    Object? expectedOutcomes = null,
    Object? evaluationMethods = freezed,
  }) {
    return _then(_value.copyWith(
      statement: null == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String,
      expectedOutcomes: null == expectedOutcomes
          ? _value.expectedOutcomes
          : expectedOutcomes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      evaluationMethods: freezed == evaluationMethods
          ? _value.evaluationMethods
          : evaluationMethods // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EvaluationImplCopyWith<$Res>
    implements $EvaluationCopyWith<$Res> {
  factory _$$EvaluationImplCopyWith(
          _$EvaluationImpl value, $Res Function(_$EvaluationImpl) then) =
      __$$EvaluationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String statement,
      List<String> expectedOutcomes,
      List<String>? evaluationMethods});
}

/// @nodoc
class __$$EvaluationImplCopyWithImpl<$Res>
    extends _$EvaluationCopyWithImpl<$Res, _$EvaluationImpl>
    implements _$$EvaluationImplCopyWith<$Res> {
  __$$EvaluationImplCopyWithImpl(
      _$EvaluationImpl _value, $Res Function(_$EvaluationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statement = null,
    Object? expectedOutcomes = null,
    Object? evaluationMethods = freezed,
  }) {
    return _then(_$EvaluationImpl(
      statement: null == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String,
      expectedOutcomes: null == expectedOutcomes
          ? _value._expectedOutcomes
          : expectedOutcomes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      evaluationMethods: freezed == evaluationMethods
          ? _value._evaluationMethods
          : evaluationMethods // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EvaluationImpl with DiagnosticableTreeMixin implements _Evaluation {
  const _$EvaluationImpl(
      {required this.statement,
      required final List<String> expectedOutcomes,
      final List<String>? evaluationMethods})
      : _expectedOutcomes = expectedOutcomes,
        _evaluationMethods = evaluationMethods;

  factory _$EvaluationImpl.fromJson(Map<String, dynamic> json) =>
      _$$EvaluationImplFromJson(json);

  /// The evaluation statement or question
  @override
  final String statement;

  /// Expected outcomes indicating successful intervention
  final List<String> _expectedOutcomes;

  /// Expected outcomes indicating successful intervention
  @override
  List<String> get expectedOutcomes {
    if (_expectedOutcomes is EqualUnmodifiableListView)
      return _expectedOutcomes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expectedOutcomes);
  }

  /// Methods or tools for measuring outcomes
  final List<String>? _evaluationMethods;

  /// Methods or tools for measuring outcomes
  @override
  List<String>? get evaluationMethods {
    final value = _evaluationMethods;
    if (value == null) return null;
    if (_evaluationMethods is EqualUnmodifiableListView)
      return _evaluationMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Evaluation(statement: $statement, expectedOutcomes: $expectedOutcomes, evaluationMethods: $evaluationMethods)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Evaluation'))
      ..add(DiagnosticsProperty('statement', statement))
      ..add(DiagnosticsProperty('expectedOutcomes', expectedOutcomes))
      ..add(DiagnosticsProperty('evaluationMethods', evaluationMethods));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EvaluationImpl &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            const DeepCollectionEquality()
                .equals(other._expectedOutcomes, _expectedOutcomes) &&
            const DeepCollectionEquality()
                .equals(other._evaluationMethods, _evaluationMethods));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      statement,
      const DeepCollectionEquality().hash(_expectedOutcomes),
      const DeepCollectionEquality().hash(_evaluationMethods));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EvaluationImplCopyWith<_$EvaluationImpl> get copyWith =>
      __$$EvaluationImplCopyWithImpl<_$EvaluationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EvaluationImplToJson(
      this,
    );
  }
}

abstract class _Evaluation implements Evaluation {
  const factory _Evaluation(
      {required final String statement,
      required final List<String> expectedOutcomes,
      final List<String>? evaluationMethods}) = _$EvaluationImpl;

  factory _Evaluation.fromJson(Map<String, dynamic> json) =
      _$EvaluationImpl.fromJson;

  @override

  /// The evaluation statement or question
  String get statement;
  @override

  /// Expected outcomes indicating successful intervention
  List<String> get expectedOutcomes;
  @override

  /// Methods or tools for measuring outcomes
  List<String>? get evaluationMethods;
  @override
  @JsonKey(ignore: true)
  _$$EvaluationImplCopyWith<_$EvaluationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Reference _$ReferenceFromJson(Map<String, dynamic> json) {
  return _Reference.fromJson(json);
}

/// @nodoc
mixin _$Reference {
  /// Author(s) of the reference
  String get author => throw _privateConstructorUsedError;

  /// Title of the publication
  String get title => throw _privateConstructorUsedError;

  /// Year of publication
  String get year => throw _privateConstructorUsedError;

  /// Source (journal, book, website)
  String get source => throw _privateConstructorUsedError;

  /// Optional URL for online references
  String? get url => throw _privateConstructorUsedError;

  /// Optional DOI for academic references
  String? get doi => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReferenceCopyWith<Reference> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferenceCopyWith<$Res> {
  factory $ReferenceCopyWith(Reference value, $Res Function(Reference) then) =
      _$ReferenceCopyWithImpl<$Res, Reference>;
  @useResult
  $Res call(
      {String author,
      String title,
      String year,
      String source,
      String? url,
      String? doi});
}

/// @nodoc
class _$ReferenceCopyWithImpl<$Res, $Val extends Reference>
    implements $ReferenceCopyWith<$Res> {
  _$ReferenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? title = null,
    Object? year = null,
    Object? source = null,
    Object? url = freezed,
    Object? doi = freezed,
  }) {
    return _then(_value.copyWith(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      doi: freezed == doi
          ? _value.doi
          : doi // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReferenceImplCopyWith<$Res>
    implements $ReferenceCopyWith<$Res> {
  factory _$$ReferenceImplCopyWith(
          _$ReferenceImpl value, $Res Function(_$ReferenceImpl) then) =
      __$$ReferenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String author,
      String title,
      String year,
      String source,
      String? url,
      String? doi});
}

/// @nodoc
class __$$ReferenceImplCopyWithImpl<$Res>
    extends _$ReferenceCopyWithImpl<$Res, _$ReferenceImpl>
    implements _$$ReferenceImplCopyWith<$Res> {
  __$$ReferenceImplCopyWithImpl(
      _$ReferenceImpl _value, $Res Function(_$ReferenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = null,
    Object? title = null,
    Object? year = null,
    Object? source = null,
    Object? url = freezed,
    Object? doi = freezed,
  }) {
    return _then(_$ReferenceImpl(
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      doi: freezed == doi
          ? _value.doi
          : doi // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReferenceImpl with DiagnosticableTreeMixin implements _Reference {
  const _$ReferenceImpl(
      {required this.author,
      required this.title,
      required this.year,
      required this.source,
      this.url,
      this.doi});

  factory _$ReferenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReferenceImplFromJson(json);

  /// Author(s) of the reference
  @override
  final String author;

  /// Title of the publication
  @override
  final String title;

  /// Year of publication
  @override
  final String year;

  /// Source (journal, book, website)
  @override
  final String source;

  /// Optional URL for online references
  @override
  final String? url;

  /// Optional DOI for academic references
  @override
  final String? doi;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Reference(author: $author, title: $title, year: $year, source: $source, url: $url, doi: $doi)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Reference'))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('source', source))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('doi', doi));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferenceImpl &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.doi, doi) || other.doi == doi));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, author, title, year, source, url, doi);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferenceImplCopyWith<_$ReferenceImpl> get copyWith =>
      __$$ReferenceImplCopyWithImpl<_$ReferenceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReferenceImplToJson(
      this,
    );
  }
}

abstract class _Reference implements Reference {
  const factory _Reference(
      {required final String author,
      required final String title,
      required final String year,
      required final String source,
      final String? url,
      final String? doi}) = _$ReferenceImpl;

  factory _Reference.fromJson(Map<String, dynamic> json) =
      _$ReferenceImpl.fromJson;

  @override

  /// Author(s) of the reference
  String get author;
  @override

  /// Title of the publication
  String get title;
  @override

  /// Year of publication
  String get year;
  @override

  /// Source (journal, book, website)
  String get source;
  @override

  /// Optional URL for online references
  String? get url;
  @override

  /// Optional DOI for academic references
  String? get doi;
  @override
  @JsonKey(ignore: true)
  _$$ReferenceImplCopyWith<_$ReferenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
