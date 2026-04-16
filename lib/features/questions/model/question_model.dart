class QuestionModel {
  final String? id;
  final String text;
  final List<String> tags;
  final bool isPersonalized;
  final String? sourceLogId; // if it came from a logged interview

  QuestionModel({
    this.id,
    required this.text,
    this.tags = const [],
    this.isPersonalized = false,
    this.sourceLogId,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as String?,
      text: json['text'] as String? ?? '',
      tags: (json['tags'] as List?)?.cast<String>() ?? [],
      isPersonalized: json['isPersonalized'] as bool? ?? false,
      sourceLogId: json['sourceLogId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'text': text,
      'tags': tags,
      'isPersonalized': isPersonalized,
      'sourceLogId': sourceLogId,
    };
  }
}
