class AnalysisModel {
  final double readinessScore;
  final String matchLabel;
  final List<String> strengths;
  final List<String> skillGaps;
  final List<String> roadmap;
  final List<String> interviewQuestions;
  final List<String> focusAreas;
  final DateTime analyzedAt;

  AnalysisModel({
    required this.readinessScore,
    required this.matchLabel,
    required this.strengths,
    required this.skillGaps,
    required this.roadmap,
    required this.interviewQuestions,
    required this.focusAreas,
    required this.analyzedAt,
  });

  factory AnalysisModel.fromJson(Map<String, dynamic> json) {
    return AnalysisModel(
      readinessScore: (json['readinessScore'] as num?)?.toDouble() ?? 0.0,
      matchLabel: json['matchLabel'] as String? ?? 'N/A',
      strengths: List<String>.from(json['strengths'] ?? []),
      skillGaps: List<String>.from(json['skillGaps'] ?? []),
      roadmap: List<String>.from(json['roadmap'] ?? []),
      interviewQuestions: List<String>.from(json['interviewQuestions'] ?? []),
      focusAreas: List<String>.from(json['focusAreas'] ?? []),
      analyzedAt: json['analyzedAt'] != null 
          ? DateTime.parse(json['analyzedAt'] as String) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'readinessScore': readinessScore,
      'matchLabel': matchLabel,
      'strengths': strengths,
      'skillGaps': skillGaps,
      'roadmap': roadmap,
      'interviewQuestions': interviewQuestions,
      'focusAreas': focusAreas,
      'analyzedAt': analyzedAt.toIso8601String(),
    };
  }

  AnalysisModel copyWith({
    double? readinessScore,
    String? matchLabel,
    List<String>? strengths,
    List<String>? skillGaps,
    List<String>? roadmap,
    List<String>? interviewQuestions,
    List<String>? focusAreas,
    DateTime? analyzedAt,
  }) {
    return AnalysisModel(
      readinessScore: readinessScore ?? this.readinessScore,
      matchLabel: matchLabel ?? this.matchLabel,
      strengths: strengths ?? this.strengths,
      skillGaps: skillGaps ?? this.skillGaps,
      roadmap: roadmap ?? this.roadmap,
      interviewQuestions: interviewQuestions ?? this.interviewQuestions,
      focusAreas: focusAreas ?? this.focusAreas,
      analyzedAt: analyzedAt ?? this.analyzedAt,
    );
  }
}
