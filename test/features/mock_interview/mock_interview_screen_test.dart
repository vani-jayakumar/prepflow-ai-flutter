import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prepflow_ai/core/constants/loader_state.dart';
import 'package:prepflow_ai/features/mock_interview/model/session_model.dart';
import 'package:prepflow_ai/features/mock_interview/notifier/session_notifier.dart';
import 'package:prepflow_ai/features/mock_interview/state/session_state.dart';
import 'package:prepflow_ai/features/mock_interview/view/screens/mock_interview_screen.dart';

class _FakeSessionNotifier extends SessionNotifier {
  _FakeSessionNotifier(this._mockState);

  final SessionState _mockState;

  @override
  SessionState build() => _mockState;

  @override
  Future<void> initializeSession({String? selectedQuestion}) async {}

  @override
  Future<void> restartSession() async {}

  @override
  Future<void> sendMessage(String text) async {}
}

Widget _buildApp(SessionState state) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, _) {
      return ProviderScope(
        overrides: [
          sessionNotifierProvider.overrideWith(
            () => _FakeSessionNotifier(state),
          ),
        ],
        child: const MaterialApp(home: MockInterviewScreen()),
      );
    },
  );
}

void main() {
  testWidgets('shows loading indicator while session initializes', (
    tester,
  ) async {
    const state = SessionState(loaderState: LoaderState.loading, messages: []);

    await tester.pumpWidget(_buildApp(state));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error empty state when startup fails', (tester) async {
    const state = SessionState(
      loaderState: LoaderState.error,
      messages: [],
      errorMessage: 'Unable to initialize mock',
    );

    await tester.pumpWidget(_buildApp(state));
    await tester.pump();

    expect(find.text('Unable to Start Mock Interview'), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);
  });

  testWidgets('renders active session context and messages', (tester) async {
    final session = SessionModel(
      id: 's1',
      userId: 'u1',
      roleContext: 'Senior Flutter Developer at Acme',
      messages: const [],
      startedAt: DateTime(2026, 4, 17),
    );

    final state = SessionState(
      currentSession: session,
      loaderState: LoaderState.loaded,
      messages: [
        MessageModel(
          text: 'Tell me about your architecture decisions.',
          role: 'assistant',
          timestamp: DateTime(2026, 4, 17),
        ),
      ],
    );

    await tester.pumpWidget(_buildApp(state));
    await tester.pump();

    expect(find.text('Role Context'), findsOneWidget);
    expect(find.text('Senior Flutter Developer at Acme'), findsOneWidget);
    expect(
      find.text('Tell me about your architecture decisions.'),
      findsOneWidget,
    );
    expect(find.text('Type your answer...'), findsOneWidget);
  });
}
