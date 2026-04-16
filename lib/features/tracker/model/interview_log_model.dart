enum InterviewStatus {
  upcoming,
  completed,
  cancelled,
  offered,
  rejected,
}

class InterviewLogModel {
  final String? id;
  final String userId;
  final String companyName;
  final String role;
  final DateTime dateTime;
  final InterviewStatus status;
  final String? feedback;
  final List<String>? topics;
  final DateTime createdAt;

  InterviewLogModel({
    this.id,
    required this.userId,
    required this.companyName,
    required this.role,
    required this.dateTime,
    this.status = InterviewStatus.upcoming,
    this.feedback,
    this.topics,
    required this.createdAt,
  });

  factory InterviewLogModel.fromJson(Map<String, dynamic> json) {
    return InterviewLogModel(
      id: json['id'] as String?,
      userId: json['userId'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      role: json['role'] as String? ?? '',
      dateTime: json['dateTime'] != null 
          ? DateTime.parse(json['dateTime'] as String) 
          : DateTime.now(),
      status: InterviewStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => InterviewStatus.upcoming,
      ),
      feedback: json['feedback'] as String?,
      topics: (json['topics'] as List?)?.cast<String>(),
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String) 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'companyName': companyName,
      'role': role,
      'dateTime': dateTime.toIso8601String(),
      'status': status.name,
      'feedback': feedback,
      'topics': topics,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  InterviewLogModel copyWith({
    String? id,
    String? userId,
    String? companyName,
    String? role,
    DateTime? dateTime,
    InterviewStatus? status,
    String? feedback,
    List<String>? topics,
    DateTime? createdAt,
  }) {
    return InterviewLogModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      role: role ?? this.role,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      feedback: feedback ?? this.feedback,
      topics: topics ?? this.topics,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
