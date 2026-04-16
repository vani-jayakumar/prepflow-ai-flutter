import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/notifier/auth_notifier.dart';
import '../repo/profile_repo.dart';
import '../state/profile_state.dart';

part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  ProfileState build() {
    // Watch current auth state
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;

    if (user != null) {
      // Listen to profile updates from the repo for the current user
      final repo = ref.watch(profileRepositoryProvider);
      ref.listen(profileRepositoryProvider.select((_) => repo.watchProfile(user.uid)), (previous, next) {
        next.listen((userProfile) {
          state = state.copyWith(user: userProfile);
        });
      });
    }

    return const ProfileState();
  }

  Future<void> updateProfile({
    String? displayName,
    String? bio,
    String? phoneNumber,
  }) async {
    final uid = ref.read(authNotifierProvider).user?.uid;
    if (uid == null) return;

    state = state.copyWith(isLoading: true, error: null);

    final updates = <String, dynamic>{};
    if (displayName != null) updates['displayName'] = displayName;
    if (bio != null) updates['bio'] = bio;
    if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;

    final result = await ref.read(profileRepositoryProvider).updateProfile(uid, updates);
    
    result.fold(
      (error) => state = state.copyWith(isLoading: false, error: error),
      (_) => state = state.copyWith(isLoading: false),
    );
  }

  Future<void> uploadResume(File file) async {
    final uid = ref.read(authNotifierProvider).user?.uid;
    if (uid == null) return;

    state = state.copyWith(isUploadingResume: true, error: null);

    final result = await ref.read(profileRepositoryProvider).uploadResume(uid, file);
    
    result.fold(
      (error) => state = state.copyWith(isUploadingResume: false, error: error),
      (_) => state = state.copyWith(isUploadingResume: false),
    );
  }

  Future<void> uploadAvatar(File file) async {
    final uid = ref.read(authNotifierProvider).user?.uid;
    if (uid == null) return;

    state = state.copyWith(isUploadingAvatar: true, error: null);

    final result = await ref.read(profileRepositoryProvider).uploadAvatar(uid, file);
    
    result.fold(
      (error) => state = state.copyWith(isUploadingAvatar: false, error: error),
      (_) => state = state.copyWith(isUploadingAvatar: false),
    );
  }
}
