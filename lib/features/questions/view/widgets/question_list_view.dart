import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'question_bank_card.dart';

class QuestionListView extends StatelessWidget {
  final List<Map<String, dynamic>> questions;

  const QuestionListView({
    super.key,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return QuestionBankCard(
          question: questions[index],
          onPrepPressed: () => context.go('/mock'),
        );
      },
    );
  }
}
