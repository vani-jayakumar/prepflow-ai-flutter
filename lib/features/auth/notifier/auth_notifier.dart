import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/services/firestore_service.dart';
import '../../auth/model/user_model.dart';
import '../repo/auth_repo.dart';
import '../state/auth_state.dart';

part 'auth_notifier.g.dart';

@riverpod
AuthRepo authRepo(Ref ref) => FirebaseAuthRepo();

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late AuthRepo _repo;
  late FirestoreService _firestoreService;

  @override
  AuthState build() {
    _repo = ref.watch(authRepoProvider);
    _firestoreService = ref.watch(firestoreServiceProvider);

    // Listen to repo's auth state changes to keep the notifier state in sync
    ref.listen(authRepoProvider.select((r) => r.authStateChanges), (prev, next) {
      next.listen((user) {
        state = state.copyWith(user: user);
      });
    });

    return const AuthState();
  }

  Future<bool> signInWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authModel = await _repo.signInWithEmail(email, password);
      await _ensureUserProfileExists(authModel.uid, authModel.email, authModel.displayName);
      
      state = state.copyWith(isLoading: false, isSuccess: true, user: authModel);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapError(e.toString()),
      );
      return false;
    }
  }

  Future<bool> signUpWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authModel = await _repo.signUpWithEmail(email, password);
      
      await _firestoreService.saveUser(UserModel(
        uid: authModel.uid,
        email: authModel.email,
        displayName: authModel.displayName ?? email.split('@')[0],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));

      state = state.copyWith(isLoading: false, isSuccess: true, user: authModel);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapError(e.toString()),
      );
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final authModel = await _repo.signInWithGoogle();
      
      await _ensureUserProfileExists(
        authModel.uid, 
        authModel.email, 
        authModel.displayName,
        photoUrl: authModel.photoUrl,
      );

      state = state.copyWith(isLoading: false, isSuccess: true, user: authModel);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapError(e.toString()),
      );
      return false;
    }
  }

  Future<void> _ensureUserProfileExists(String uid, String email, String? displayName, {String? photoUrl}) async {
    final existingUser = await _firestoreService.getUser(uid);
    if (existingUser == null) {
      await _firestoreService.saveUser(UserModel(
        uid: uid,
        email: email,
        displayName: displayName ?? email.split('@')[0],
        photoUrl: photoUrl,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AuthState();
  }

  String _mapError(String error) {
    if (error.contains('user-not-found'))
      return 'No user found with this email.';
    if (error.contains('wrong-password')) return 'Incorrect password.';
    if (error.contains('email-already-in-use'))
      return 'This email is already registered.';
    if (error.contains('weak-password'))
      return 'Password must be at least 6 characters.';
    if (error.contains('invalid-email')) return 'Invalid email address format.';
    if (error.contains('network-request-failed'))
      return 'Network error. Check your connection.';
    return 'An error occurred. Please try again.';
  }
}
