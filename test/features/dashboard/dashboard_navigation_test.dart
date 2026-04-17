import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:prepflow_ai/features/auth/model/user_model.dart';
import 'package:prepflow_ai/features/dashboard/view/screens/dashboard_screen.dart';
import 'package:prepflow_ai/features/settings/notifier/profile_notifier.dart';
import 'package:prepflow_ai/features/settings/state/profile_state.dart';

class _FakeProfileNotifier extends ProfileNotifier {
  _FakeProfileNotifier(this._state);

  final ProfileState _state;

  @override
  ProfileState build() => _state;
}

UserModel _buildUserWithAnalysis() {
  return UserModel(
    uid: 'test-user',
    email: 'test@example.com',
    displayName: 'Alex Test',
    readinessScore: 82,
    lastAnalysis: {
      'readinessScore': 82,
      'matchLabel': 'Good Potential',
      'strengths': ['Python', 'Communication'],
      'skillGaps': ['System Design'],
      'roadmap': ['Review architecture patterns'],
      'interviewQuestions': ['How do you scale a service?'],
      'focusAreas': ['System Design'],
      'analyzedAt': DateTime(2026, 4, 17).toIso8601String(),
    },
  );
}

Widget _buildApp({required UserModel user}) {
  final router = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/skillgap',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Skill Gap Route'))),
      ),
      GoRoute(
        path: '/bank',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Question Bank Route'))),
      ),
      GoRoute(
        path: '/input',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Input Route'))),
      ),
    ],
  );

  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, _) {
      return ProviderScope(
        overrides: [
          profileNotifierProvider.overrideWith(
            () => _FakeProfileNotifier(ProfileState(user: user)),
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      );
    },
  );
}

void main() {
  testWidgets('AI Skill Gap card opens skill gap route', (tester) async {
    await tester.pumpWidget(_buildApp(user: _buildUserWithAnalysis()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('AI Skill Gap Insights'));
    await tester.pumpAndSettle();

    expect(find.text('Skill Gap Route'), findsOneWidget);
    expect(find.text('Question Bank Route'), findsNothing);
  });

  testWidgets('Question Bank card still opens bank route', (tester) async {
    await tester.pumpWidget(_buildApp(user: _buildUserWithAnalysis()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Smart Question Bank'));
    await tester.pumpAndSettle();

    expect(find.text('Question Bank Route'), findsOneWidget);
    expect(find.text('Skill Gap Route'), findsNothing);
  });
}
