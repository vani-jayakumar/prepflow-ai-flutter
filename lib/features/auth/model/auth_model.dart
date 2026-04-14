import '../../../core/utils/converters.dart';

class AuthModel {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;

  AuthModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      uid: convertToString(json['uid']) ?? '',
      email: convertToString(json['email']) ?? '',
      displayName: convertToString(json['displayName']),
      photoUrl: convertToString(json['photoUrl']),
      phoneNumber: convertToString(json['phoneNumber']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
    };
  }
}
