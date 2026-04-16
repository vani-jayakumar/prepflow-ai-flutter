import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageServiceProvider = Provider((ref) => StorageService());

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadMasterResume(String uid, File file) async {
    final ref = _storage.ref().child('users/$uid/resumes/master.pdf');
    final uploadTask = await ref.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }

  Future<String> uploadAvatar(String uid, File file) async {
    final ref = _storage.ref().child('users/$uid/profile/avatar.jpg');
    final uploadTask = await ref.putFile(file);
    return await uploadTask.ref.getDownloadURL();
  }

  Future<void> deleteResume(String uid) async {
    final ref = _storage.ref().child('users/$uid/resumes/master.pdf');
    await ref.delete();
  }
}
