import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prepflow_ai/core/constants/loader_state.dart';
import 'package:prepflow_ai/features/questions/model/question_model.dart';
import 'package:prepflow_ai/features/questions/notifier/question_notifier.dart';
import 'package:prepflow_ai/features/questions/state/question_state.dart';
import 'package:prepflow_ai/features/questions/view/screens/question_bank_screen.dart';

class _FakeQuestionNotifier extends QuestionNotifier {
  _FakeQuestionNotifier(this._mockState);

  final QuestionState _mockState;

  @override
  QuestionState build() => _mockState;
}

Widget _buildApp(QuestionState state) {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, _) {
      return ProviderScope(
        overrides: [
          questionNotifierProvider.overrideWith(
            () => _FakeQuestionNotifier(state),
          ),
        ],
        child: const MaterialApp(home: QuestionBankScreen()),
      );
    },
  );
}

void main() {
  testWidgets('shows AI-generated questions in personalized tab', (
    tester,
  ) async {
    final state = QuestionState(
      personalizedQuestions: [
        QuestionModel(
          text: 'How would you scale a backend service?',
          isPersonalized: true,
          tags: ['AI Generated', 'Technical'],
        ),
      ],
      loaderState: LoaderState.loaded,
    );

    await tester.pumpWidget(_buildApp(state));
    await tester.pumpAndSettle();

    expect(find.text('How would you scale a backend service?'), findsOneWidget);
  });

  testWidgets('uses personalized questions in technical and behavioral tabs', (
    tester,
  ) async {
    final state = QuestionState(
      personalizedQuestions: [
        QuestionModel(
          text: 'How would you optimize a distributed system?',
          isPersonalized: true,
          tags: ['AI Generated', 'Technical'],
        ),
        QuestionModel(
          text: 'Tell me about a conflict you resolved in your team.',
          isPersonalized: true,
          tags: ['AI Generated', 'Behavioral'],
        ),
      ],
      loaderState: LoaderState.loaded,
    );

    await tester.pumpWidget(_buildApp(state));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(Tab, 'Technical'));
    await tester.pumpAndSettle();
    expect(
      find.text('How would you optimize a distributed system?'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(Tab, 'Behavioral'));
    await tester.pumpAndSettle();
    expect(
      find.text('Tell me about a conflict you resolved in your team.'),
      findsOneWidget,
    );
  });
}
