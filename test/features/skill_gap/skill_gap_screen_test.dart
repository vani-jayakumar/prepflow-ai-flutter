import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prepflow_ai/features/auth/model/user_model.dart';
import 'package:prepflow_ai/features/settings/notifier/profile_notifier.dart';
import 'package:prepflow_ai/features/settings/state/profile_state.dart';
import 'package:prepflow_ai/features/skill_gap/view/screens/skill_gap_screen.dart';

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
    readinessScore: 84,
    lastAnalysis: {
      'readinessScore': 84,
      'matchLabel': 'Good Potential',
      'strengths': ['Python', 'API Design'],
      'skillGaps': ['System Design'],
      'roadmap': [
        'Revise distributed system fundamentals',
        'Practice scaling and caching tradeoffs',
      ],
      'interviewQuestions': ['How do you scale a monolith?'],
      'focusAreas': ['System Design', 'Scalability'],
      'analyzedAt': DateTime(2026, 4, 17).toIso8601String(),
    },
  );
}

Widget _buildApp({required ProfileState state}) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, _) {
      return ProviderScope(
        overrides: [
          profileNotifierProvider.overrideWith(
            () => _FakeProfileNotifier(state),
          ),
        ],
        child: const MaterialApp(home: SkillGapScreen()),
      );
    },
  );
}

void main() {
  testWidgets('renders complete insights and roadmap from analysis', (
    tester,
  ) async {
    await tester.pumpWidget(
      _buildApp(state: ProfileState(user: _buildUserWithAnalysis())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Complete Insights'), findsOneWidget);
    expect(find.text('Readiness Overview'), findsOneWidget);
    expect(find.text('Good Potential'), findsOneWidget);
    expect(find.text('Python'), findsOneWidget);

    await tester.tap(find.text('AI Roadmap'));
    await tester.pumpAndSettle();

    expect(find.text('Structured Preparation'), findsOneWidget);
    expect(find.text('Module 1'), findsOneWidget);
    expect(find.text('Revise distributed system fundamentals'), findsOneWidget);
  });

  testWidgets('shows empty state when analysis is missing', (tester) async {
    final userWithoutAnalysis = UserModel(
      uid: 'test-user',
      email: 'test@example.com',
      readinessScore: 0,
    );

    await tester.pumpWidget(
      _buildApp(state: ProfileState(user: userWithoutAnalysis)),
    );
    await tester.pumpAndSettle();

    expect(find.text('No Insights Yet'), findsOneWidget);
    expect(find.text('Generate Insights'), findsOneWidget);
    expect(find.text('Complete Insights'), findsNothing);
  });
}
