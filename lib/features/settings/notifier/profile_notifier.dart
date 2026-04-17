import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repo/profile_repo.dart';
import '../state/profile_state.dart';

part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  StreamSubscription? _profileSubscription;

  @override
  ProfileState build() {
    ref.onDispose(() => _profileSubscription?.cancel());

    // Schedule initialization tightly after build completely finishes
    Future.microtask(_initProfile);

    return const ProfileState();
  }

  void _initProfile() {
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser == null) return;

    final repo = ref.read(profileRepositoryProvider);
    _profileSubscription = repo
        .watchProfile(authUser.uid)
        .listen(
          (userProfile) {
            if (userProfile != null) {
              state = state.copyWith(user: userProfile);
            }
          },
          onError: (err) {
            // Error fetching profile silently aborted originally
          },
        );
  }

  Future<void> updateProfile({
    String? displayName,
    String? bio,
    String? phoneNumber,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    state = state.copyWith(isLoading: true, error: null);

    final updates = <String, dynamic>{};
    if (displayName != null) updates['displayName'] = displayName;
    if (bio != null) updates['bio'] = bio;
    if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;

    final result = await ref
        .read(profileRepositoryProvider)
        .updateProfile(uid, updates);

    result.fold(
      (error) => state = state.copyWith(isLoading: false, error: error),
      (_) {
        final currentUser = state.user;
        if (currentUser != null) {
          state = state.copyWith(
            isLoading: false,
            user: currentUser.copyWith(
              displayName: displayName ?? currentUser.displayName,
              bio: bio ?? currentUser.bio,
              phoneNumber: phoneNumber ?? currentUser.phoneNumber,
            ),
          );
        } else {
          state = state.copyWith(isLoading: false);
        }
      },
    );
  }

  Future<void> uploadResume(File file) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    state = state.copyWith(isUploadingResume: true, error: null);

    final result = await ref
        .read(profileRepositoryProvider)
        .uploadResume(uid, file);

    result.fold(
      (error) => state = state.copyWith(isUploadingResume: false, error: error),
      (_) => state = state.copyWith(isUploadingResume: false),
    );
  }

  Future<void> uploadAvatar(File file) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    state = state.copyWith(isUploadingAvatar: true, error: null);

    final result = await ref
        .read(profileRepositoryProvider)
        .uploadAvatar(uid, file);

    result.fold(
      (error) => state = state.copyWith(isUploadingAvatar: false, error: error),
      (_) => state = state.copyWith(isUploadingAvatar: false),
    );
  }
}
