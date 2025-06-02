import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'care_plan_model.freezed.dart';
part 'care_plan_model.g.dart';

/// A comprehensive model representing a nursing care plan.
///
/// This model contains all the essential components of a nursing care plan,
/// including assessments, diagnoses, goals, interventions, and evaluations.
@freezed
class CarePlanModel with _$CarePlanModel {
  const factory CarePlanModel({
    /// Unique identifier for the care plan
    required String id,
    
    /// Title of the care plan
    required String title,
    
    /// Primary category of the care plan (e.g., "Cardiovascular", "Respiratory")
    required String category,
    
    /// List of subcategories or tags for more specific classification
    required List<String> tags,
    
    /// Brief description or overview of the care plan
    required String description,
    
    /// Detailed assessment findings and data collection
    required List<AssessmentSection> assessments,
    
    /// Nursing diagnoses identified based on the assessments
    required List<NursingDiagnosis> nursingDiagnoses,
    
    /// Expected outcomes and goals for the patient
    required List<Goal> goals,
    
    /// Nursing interventions to address the diagnoses and achieve goals
    required List<Intervention> interventions,
    
    /// Evaluation criteria and methods to determine effectiveness
    required List<Evaluation> evaluations,
    
    /// Scientific references and evidence supporting the care plan
    required List<Reference> references,
    
    /// Optional notes or additional information
    String? notes,
    
    /// Difficulty or complexity level (e.g., "Basic", "Intermediate", "Advanced")
    @Default("Intermediate") String difficultyLevel,
    
    /// Estimated time frame for the care plan
    String? timeFrame,
    
    /// URL to an image or icon representing the care plan
    String? imageUrl,
    
    /// Whether this care plan is featured
    @Default(false) bool isFeatured,
    
    /// Whether this care plan is marked as favorite by the user
    @Default(false) bool isFavorite,
    
    /// Date when the care plan was created or last updated
    required DateTime lastUpdated,
  }) = _CarePlanModel;

  /// Creates a CarePlanModel from JSON map
  factory CarePlanModel.fromJson(Map<String, dynamic> json) => 
      _$CarePlanModelFromJson(json);
}

/// Model representing an assessment section in a care plan
@freezed
class AssessmentSection with _$AssessmentSection {
  const factory AssessmentSection({
    /// Title of the assessment section (e.g., "Vital Signs", "Physical Examination")
    required String title,
    
    /// List of specific assessment points or findings
    required List<String> points,
    
    /// Optional additional information about the assessment section
    String? description,
  }) = _AssessmentSection;

  /// Creates an AssessmentSection from JSON map
  factory AssessmentSection.fromJson(Map<String, dynamic> json) => 
      _$AssessmentSectionFromJson(json);
}

/// Model representing a nursing diagnosis in a care plan
@freezed
class NursingDiagnosis with _$NursingDiagnosis {
  const factory NursingDiagnosis({
    /// The formal nursing diagnosis statement
    required String statement,
    
    /// Related factors contributing to the diagnosis
    required List<String> relatedFactors,
    
    /// Defining characteristics or symptoms supporting the diagnosis
    required List<String> definingCharacteristics,
    
    /// Optional NANDA-I code for standardized diagnosis
    String? nandaCode,
  }) = _NursingDiagnosis;

  /// Creates a NursingDiagnosis from JSON map
  factory NursingDiagnosis.fromJson(Map<String, dynamic> json) => 
      _$NursingDiagnosisFromJson(json);
}

/// Model representing a patient goal in a care plan
@freezed
class Goal with _$Goal {
  const factory Goal({
    /// The goal statement describing the expected outcome
    required String statement,
    
    /// Indicators to measure progress toward the goal
    required List<String> indicators,
    
    /// Target timeframe for achieving the goal
    String? timeframe,
    
    /// Whether this is a short-term or long-term goal
    @Default("Short-term") String type,
  }) = _Goal;

  /// Creates a Goal from JSON map
  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
}

/// Model representing a nursing intervention in a care plan
@freezed
class Intervention with _$Intervention {
  const factory Intervention({
    /// Title or category of the intervention
    required String title,
    
    /// List of specific nursing actions
    required List<String> actions,
    
    /// Rationale explaining why each intervention is effective
    required List<String> rationales,
    
    /// Optional frequency or timing of the intervention
    String? frequency,
    
    /// Optional special considerations or precautions
    List<String>? specialConsiderations,
  }) = _Intervention;

  /// Creates an Intervention from JSON map
  factory Intervention.fromJson(Map<String, dynamic> json) => 
      _$InterventionFromJson(json);
}

/// Model representing evaluation criteria in a care plan
@freezed
class Evaluation with _$Evaluation {
  const factory Evaluation({
    /// The evaluation statement or question
    required String statement,
    
    /// Expected outcomes indicating successful intervention
    required List<String> expectedOutcomes,
    
    /// Methods or tools for measuring outcomes
    List<String>? evaluationMethods,
  }) = _Evaluation;

  /// Creates an Evaluation from JSON map
  factory Evaluation.fromJson(Map<String, dynamic> json) => 
      _$EvaluationFromJson(json);
}

/// Model representing a reference or evidence source
@freezed
class Reference with _$Reference {
  const factory Reference({
    /// Author(s) of the reference
    required String author,
    
    /// Title of the publication
    required String title,
    
    /// Year of publication
    required String year,
    
    /// Source (journal, book, website)
    required String source,
    
    /// Optional URL for online references
    String? url,
    
    /// Optional DOI for academic references
    String? doi,
  }) = _Reference;

  /// Creates a Reference from JSON map
  factory Reference.fromJson(Map<String, dynamic> json) => 
      _$ReferenceFromJson(json);
}
