import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/model/user_model.dart';

final firestoreServiceProvider = Provider((ref) => FirestoreService());

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirebaseFirestore get db => _db;

  Future<void> saveUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).set({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<UserModel?> getUserStream(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromJson(snapshot.data()!);
      }
      return null;
    });
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }
}
