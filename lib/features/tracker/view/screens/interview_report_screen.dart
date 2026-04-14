import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_gradient_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../widgets/interview_report_question_item.dart';

class InterviewReportScreen extends StatelessWidget {
  const InterviewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interview Report',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGradientCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'ATTENDED OCT 10',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  AppSpacing.vMD,
                  Text(
                    'Amazon',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'SDE I • Virtual Onsite',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            AppSpacing.vLG,
            Text(
              'Extracted Questions',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            AppSpacing.vMD,

            AppGlassCard(
              child: Column(
                children: [
                  const InterviewReportQuestionItem(
                    category: 'System Design',
                    question: 'Design a URL shortener like TinyURL.',
                  ),
                  Divider(color: Theme.of(context).dividerColor, height: 32),
                  const InterviewReportQuestionItem(
                    category: 'Behavioral',
                    question:
                        '"Tell me about a time you disagreed with your manager."',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
