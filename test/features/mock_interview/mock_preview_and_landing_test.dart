import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:prepflow_ai/core/constants/loader_state.dart';
import 'package:prepflow_ai/core/services/ai_service.dart';
import 'package:prepflow_ai/features/input/notifier/setup_notifier.dart';
import 'package:prepflow_ai/features/input/state/setup_state.dart';
import 'package:prepflow_ai/features/mock_interview/notifier/session_notifier.dart';
import 'package:prepflow_ai/features/mock_interview/state/session_state.dart';
import 'package:prepflow_ai/features/mock_interview/view/screens/mock_landing_screen.dart';
import 'package:prepflow_ai/features/mock_interview/view/screens/mock_question_preview_screen.dart';

class _FakeSetupNotifier extends SetupNotifier {
  _FakeSetupNotifier(this._state);

  final SetupState _state;

  @override
  SetupState build() => _state;
}

class _FakeSessionNotifier extends SessionNotifier {
  _FakeSessionNotifier(this._state);

  final SessionState _state;

  @override
  SessionState build() => _state;

  @override
  Future<void> initializeSession({String? selectedQuestion}) async {}

  @override
  Future<void> restartSession() async {}

  @override
  Future<void> sendMessage(String text) async {}
}

class _FakeAIService extends AIService {
  _FakeAIService({required this.answer, this.shouldThrow = false})
    : super(apiKey: 'test');

  final String answer;
  final bool shouldThrow;

  @override
  Future<String> generateQuestionAnswer({
    required String question,
    required String roleContext,
  }) async {
    if (shouldThrow) throw Exception('AI unavailable');
    await Future<void>.delayed(const Duration(milliseconds: 10));
    return answer;
  }
}

Widget _buildPreviewApp({
  required AIService aiService,
  String selectedQuestion = 'How would you scale an API for 10x traffic?',
}) {
  final router = GoRouter(
    initialLocation: '/bank',
    routes: [
      GoRoute(
        path: '/bank',
        builder: (context, state) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => context.push(
                '/mock/preview',
                extra: {'question': selectedQuestion},
              ),
              child: const Text('Open Preview'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: '/mock/preview',
        builder: (context, state) => const MockQuestionPreviewScreen(),
      ),
      GoRoute(
        path: '/mock/live',
        builder: (context, state) {
          final payload = state.extra as Map<String, dynamic>?;
          return Scaffold(
            body: Center(
              child: Text(payload?['seedQuestion'] as String? ?? 'No seed'),
            ),
          );
        },
      ),
    ],
  );

  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, _) {
      return ProviderScope(
        overrides: [
          aiServiceProvider.overrideWithValue(aiService),
          setupNotifierProvider.overrideWith(
            () => _FakeSetupNotifier(
              const SetupState(
                targetRole: 'Backend Engineer',
                companyName: 'Acme',
              ),
            ),
          ),
        ],
        child: MaterialApp.router(routerConfig: router),
      );
    },
  );
}

Widget _buildLandingApp(SessionState state) {
  final router = GoRouter(
    initialLocation: '/mock',
    routes: [
      GoRoute(
        path: '/mock',
        builder: (context, state) => const MockLandingScreen(),
      ),
      GoRoute(
        path: '/mock/live',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Live Mock Screen'))),
      ),
    ],
  );

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
        child: MaterialApp.router(routerConfig: router),
      );
    },
  );
}

void main() {
  testWidgets('preview generates answer and starts mock with seed question', (
    tester,
  ) async {
    await tester.pumpWidget(
      _buildPreviewApp(
        aiService: _FakeAIService(
          answer:
              'Approach: Start with load balancing and caching. Trade-offs: cost vs latency. Example: Profile bottlenecks before scaling.',
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open Preview'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Approach: Start with load balancing'),
      findsOneWidget,
    );

    await tester.tap(find.text('Let\'s Start Mock Interview'));
    await tester.pumpAndSettle();

    expect(
      find.text('How would you scale an API for 10x traffic?'),
      findsOneWidget,
    );
  });

  testWidgets('preview shows fallback answer when AI fails', (tester) async {
    await tester.pumpWidget(
      _buildPreviewApp(
        aiService: _FakeAIService(answer: '', shouldThrow: true),
        selectedQuestion: 'Tell me about a time you resolved team conflict.',
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open Preview'));
    await tester.pumpAndSettle();

    expect(
      find.text('AI answer unavailable. Showing a reliable fallback template.'),
      findsOneWidget,
    );
    expect(find.textContaining('Situation:'), findsOneWidget);
  });

  testWidgets('mock tab opens landing and CTA starts live mock', (
    tester,
  ) async {
    await tester.pumpWidget(
      _buildLandingApp(const SessionState(loaderState: LoaderState.initial)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mock Interview'), findsOneWidget);
    expect(find.text('Let\'s Start Mock Interview'), findsOneWidget);

    await tester.tap(find.text('Let\'s Start Mock Interview'));
    await tester.pumpAndSettle();

    expect(find.text('Live Mock Screen'), findsOneWidget);
  });
}
