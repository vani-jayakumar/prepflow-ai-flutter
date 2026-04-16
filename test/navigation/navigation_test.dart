import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepflow_ai/core/routing/app_router.dart';
import 'package:prepflow_ai/core/app/app.dart';
import 'package:prepflow_ai/features/auth/view_model/auth_view_model.dart';
import 'package:prepflow_ai/features/auth/repo/auth_repo.dart';
import 'package:prepflow_ai/features/auth/model/auth_model.dart';

// Mock AuthRepo to prevent Firebase initialization in tests
class MockAuthRepo implements AuthRepo {
  @override
  Future<AuthModel> signInWithEmail(String email, String password) async => throw UnimplementedError();
  @override
  Future<AuthModel> signUpWithEmail(String email, String password) async => throw UnimplementedError();
  @override
  Future<AuthModel> signInWithGoogle() async => throw UnimplementedError();
  @override
  Future<void> signOut() async {}
  @override
  Stream<AuthModel?> get authStateChanges => Stream.value(null);
}

void main() {
  testWidgets('App should start and show App successfully', (tester) async {
    // Override authRepo to avoid real Firebase calls
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepoProvider.overrideWithValue(MockAuthRepo()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          builder: (context, _) => const App(),
        ),
      ),
    );

    // Initial pump
    await tester.pump();
    
    // Check if App is rendered
    expect(find.byType(App), findsOneWidget);
  });
}
