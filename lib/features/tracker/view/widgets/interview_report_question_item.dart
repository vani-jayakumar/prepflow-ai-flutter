import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          question,
          style: TextStyle(
            fontSize: 15.sp,
            color: Theme.of(context).textTheme.bodyMedium?.color,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
