import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/storage_service.dart';
import '../../auth/model/user_model.dart';

part 'profile_repo.g.dart';

@riverpod
class ProfileRepository extends _$ProfileRepository {
  @override
  ProfileRepo build() {
    return ProfileRepo(
      firestoreService: ref.watch(firestoreServiceProvider),
      storageService: ref.watch(storageServiceProvider),
    );
  }
}

abstract class IProfileRepo {
  Future<Either<String, void>> updateProfile(String uid, Map<String, dynamic> data);
  Future<Either<String, String>> uploadResume(String uid, File file);
  Future<Either<String, String>> uploadAvatar(String uid, File file);
  Stream<UserModel?> watchProfile(String uid);
}

class ProfileRepo implements IProfileRepo {
  final FirestoreService _firestoreService;
  final StorageService _storageService;

  ProfileRepo({
    required FirestoreService firestoreService,
    required StorageService storageService,
  })  : _firestoreService = firestoreService,
        _storageService = storageService;

  @override
  Future<Either<String, void>> updateProfile(String uid, Map<String, dynamic> data) async {
    try {
      await _firestoreService.updateUser(uid, data);
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> uploadResume(String uid, File file) async {
    try {
      final url = await _storageService.uploadMasterResume(uid, file);
      await _firestoreService.updateUser(uid, {
        'masterResumeUrl': url,
        'masterResumeFileName': file.path.split('/').last,
      });
      return right(url);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> uploadAvatar(String uid, File file) async {
    try {
      final url = await _storageService.uploadAvatar(uid, file);
      await _firestoreService.updateUser(uid, {'photoUrl': url});
      return right(url);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Stream<UserModel?> watchProfile(String uid) {
    return _firestoreService.getUserStream(uid);
  }
}
