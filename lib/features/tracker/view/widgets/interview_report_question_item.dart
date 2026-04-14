import 'package:flutter/material.dart';

class InterviewReportQuestionItem extends StatelessWidget {
  final String category;
  final String question;

  const InterviewReportQuestionItem({
    super.key,
    required this.category,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          question,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).textTheme.bodyMedium?.color,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
