import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepflow_ai/features/auth/view/screens/login_screen.dart';
import 'package:prepflow_ai/features/auth/view_model/auth_view_model.dart';
import 'package:prepflow_ai/shared/widgets/app_button.dart';
import 'package:prepflow_ai/features/auth/repo/auth_repo.dart';
import 'package:prepflow_ai/features/auth/model/auth_model.dart';

// Manual Mock for AuthRepo to avoid Firebase calls
class MockAuthRepo implements AuthRepo {
  @override
  Future<AuthModel> signInWithEmail(String email, String password) async =>
      throw UnimplementedError();
  @override
  Future<AuthModel> signUpWithEmail(String email, String password) async =>
      throw UnimplementedError();
  @override
  Future<AuthModel> signInWithGoogle() async => throw UnimplementedError();
  @override
  Future<void> signOut() async {}
  @override
  Stream<AuthModel?> get authStateChanges => Stream.value(null);
}

void main() {
  group('AuthViewModel Logic Tests', () {
    test('Should update error message when fields are empty', () async {
      final container = ProviderContainer(
        overrides: [authRepoProvider.overrideWithValue(MockAuthRepo())],
      );
      addTearDown(container.dispose);

      final viewModel = container.read(authViewModelProvider.notifier);
      await viewModel.signInWithEmail('', '');

      expect(
        container.read(authViewModelProvider).errorMessage,
        'Please fill in all fields',
      );
    });

    test('Should reset state correctly', () {
      final container = ProviderContainer(
        overrides: [authRepoProvider.overrideWithValue(MockAuthRepo())],
      );
      addTearDown(container.dispose);

      final viewModel = container.read(authViewModelProvider.notifier);
      viewModel.resetState();

      final state = container.read(authViewModelProvider);
      expect(state.errorMessage, isNull);
      expect(state.isSuccess, isFalse);
    });
  });

  group('LoginScreen Widget Tests', () {
    testWidgets('Should render login screen components', (tester) async {
      final container = ProviderContainer(
        overrides: [authRepoProvider.overrideWithValue(MockAuthRepo())],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            builder: (context, _) =>
                const MaterialApp(home: Scaffold(body: LoginScreen())),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check for presence of essential widgets
      expect(find.byType(AppButton), findsAtLeastNWidgets(1));
      expect(find.byType(TextField), findsAtLeastNWidgets(2));
    });
  });
}
