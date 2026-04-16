class MessageModel {
  final String text;
  final String role; // 'user' or 'assistant'
  final DateTime timestamp;

  MessageModel({
    required this.text,
    required this.role,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'] as String? ?? '',
      role: json['role'] as String? ?? 'user',
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp'] as String) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'role': role,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class SessionModel {
  final String? id;
  final String userId;
  final String roleContext;
  final List<MessageModel> messages;
  final double? score;
  final String? feedback;
  final DateTime startedAt;
  final bool isCompleted;

  SessionModel({
    this.id,
    required this.userId,
    required this.roleContext,
    required this.messages,
    this.score,
    this.feedback,
    required this.startedAt,
    this.isCompleted = false,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as String?,
      userId: json['userId'] as String? ?? '',
      roleContext: json['roleContext'] as String? ?? '',
      messages: (json['messages'] as List?)
              ?.map((m) => MessageModel.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
      score: (json['score'] as num?)?.toDouble(),
      feedback: json['feedback'] as String?,
      startedAt: json['startedAt'] != null 
          ? DateTime.parse(json['startedAt'] as String) 
          : DateTime.now(),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'roleContext': roleContext,
      'messages': messages.map((m) => m.toJson()).toList(),
      'score': score,
      'feedback': feedback,
      'startedAt': startedAt.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  SessionModel copyWith({
    String? id,
    String? userId,
    String? roleContext,
    List<MessageModel>? messages,
    double? score,
    String? feedback,
    DateTime? startedAt,
    bool? isCompleted,
  }) {
    return SessionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      roleContext: roleContext ?? this.roleContext,
      messages: messages ?? this.messages,
      score: score ?? this.score,
      feedback: feedback ?? this.feedback,
      startedAt: startedAt ?? this.startedAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
