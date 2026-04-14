import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repo/auth_repo.dart';
import '../state/auth_state.dart';

part 'auth_notifier.g.dart';

@riverpod
AuthRepo authRepo(Ref ref) => FirebaseAuthRepo();

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late AuthRepo _repo;

  @override
  AuthState build() {
    _repo = ref.watch(authRepoProvider);
    return const AuthState();
  }

  Future<bool> signInWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _repo.signInWithEmail(email, password);
      state = state.copyWith(isLoading: false, isSuccess: true);
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
      await _repo.signUpWithEmail(email, password);
      state = state.copyWith(isLoading: false, isSuccess: true);
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
      await _repo.signInWithGoogle();
      state = state.copyWith(isLoading: false, isSuccess: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapError(e.toString()),
      );
      return false;
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
