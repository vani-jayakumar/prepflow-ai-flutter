import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:prepflow_ai/features/questions/view/widgets/question_list_view.dart';
import 'package:prepflow_ai/shared/widgets/app_chip.dart';

Widget _buildApp() {
  final sampleQuestion =
      'Explain the difference between a Struct and a Class in Swift.';

  final router = GoRouter(
    initialLocation: '/bank',
    routes: [
      GoRoute(
        path: '/bank',
        builder: (context, state) => QuestionListView(
          questions: [
            {
              'title': sampleQuestion,
              'tags': ['AI Generated', 'Technical'],
              'priority': ChipType.accent,
            },
          ],
        ),
      ),
      GoRoute(
        path: '/mock/preview',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>?;
          final question = data?['question'] as String? ?? 'No question';
          return Scaffold(body: Center(child: Text(question)));
        },
      ),
    ],
  );

  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, _) => MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets('passes clicked question to mock preview route', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Start Mock Interview').first);
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Explain the difference between a Struct and a Class in Swift.',
      ),
      findsOneWidget,
    );
  });
}
