import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repo/auth_repo.dart';
import '../state/auth_state.dart';

part 'auth_view_model.g.dart';

@riverpod
AuthRepo authRepo(Ref ref) => FirebaseAuthRepo();

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRepo _repo;

  @override
  AuthState build() {
    _repo = ref.watch(authRepoProvider);
    return const AuthState();
  }

  /// Resets the auth state to clear errors and success flags.
  void resetState() {
    state = const AuthState();
  }

  Future<void> signInWithEmail(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      state = state.copyWith(errorMessage: 'Please fill in all fields');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null, isSuccess: false);
    try {
      await _repo.signInWithEmail(email.trim(), password);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapError(e),
      );
    } on PlatformException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Connection error: ${e.message}',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred: $e',
      );
    }
  }

  Future<void> signUpWithEmail(String email, String password, String name) async {
    if (email.trim().isEmpty || password.isEmpty || name.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please fill in all fields');
      return;
    }

    if (password.length < 6) {
      state = state.copyWith(errorMessage: 'Password must be at least 6 characters');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null, isSuccess: false);
    try {
      await _repo.signUpWithEmail(email.trim(), password);
      state = state.copyWith(isLoading: false, isSuccess: true);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapError(e),
      );
    } on PlatformException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Connection error: ${e.message}',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred: $e',
      );
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, errorMessage: null, isSuccess: false);
    try {
      await _repo.signInWithGoogle();
      state = state.copyWith(isLoading: false, isSuccess: true);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _mapError(e),
      );
    } on PlatformException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Connection error: ${e.message}',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An unexpected error occurred: $e',
      );
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AuthState();
  }

  String _mapError(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Incorrect password.';
        case 'email-already-in-use':
          return 'This email is already registered.';
        case 'weak-password':
          return 'Password must be at least 6 characters.';
        case 'invalid-email':
          return 'Invalid email address format.';
        case 'network-request-failed':
          return 'Network error. Check your connection.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'operation-not-allowed':
          return 'Sign-in provider not enabled. Please contact support.';
        case 'invalid-credential':
          return 'Invalid email or password. Please check your credentials.';
        default:
          return error.message ?? 'Authentication failed. (${error.code})';
      }
    }
    return 'An error occurred. Please try again.';
  }
}
