import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'question_bank_card.dart';

class QuestionListView extends StatelessWidget {
  final List<Map<String, dynamic>> questions;

  const QuestionListView({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
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
