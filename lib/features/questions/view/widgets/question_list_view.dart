import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import 'question_bank_card.dart';

class QuestionListView extends StatelessWidget {
  final List<Map<String, dynamic>> questions;

  const QuestionListView({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return AppEmptyState(
        icon: Icons.auto_awesome_rounded,
        title: 'Your AI Questions',
        description: 'Once you scan a job description, AI will generate custom interview questions for you here.',
        actionLabel: 'Scan New JD',
        onAction: () => context.go('/input'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 100.h),
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
