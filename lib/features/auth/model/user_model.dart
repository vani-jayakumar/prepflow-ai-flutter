import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final String? bio;
  final String? masterResumeUrl;
  final String? masterResumeFileName;
  final double readinessScore;
  final Map<String, dynamic>? lastAnalysis;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.bio,
    this.masterResumeUrl,
    this.masterResumeFileName,
    this.readinessScore = 0.0,
    this.lastAnalysis,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      bio: json['bio'] as String?,
      masterResumeUrl: json['masterResumeUrl'] as String?,
      masterResumeFileName: json['masterResumeFileName'] as String?,
      readinessScore: (json['readinessScore'] as num?)?.toDouble() ?? 0.0,
      lastAnalysis: json['lastAnalysis'] as Map<String, dynamic>?,
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
    );
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'masterResumeUrl': masterResumeUrl,
      'masterResumeFileName': masterResumeFileName,
      'readinessScore': readinessScore,
      'lastAnalysis': lastAnalysis,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    String? bio,
    String? masterResumeUrl,
    String? masterResumeFileName,
    double? readinessScore,
    Map<String, dynamic>? lastAnalysis,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      masterResumeUrl: masterResumeUrl ?? this.masterResumeUrl,
      masterResumeFileName: masterResumeFileName ?? this.masterResumeFileName,
      readinessScore: readinessScore ?? this.readinessScore,
      lastAnalysis: lastAnalysis ?? this.lastAnalysis,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
