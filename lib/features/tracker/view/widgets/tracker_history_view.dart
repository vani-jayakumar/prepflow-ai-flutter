import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../core/constants/app_spacing.dart';
import 'history_interview_card.dart';

class TrackerHistoryView extends StatelessWidget {
  const TrackerHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        AppButton(
          text: '+ Log Past Interview Details',
          isSecondary: true,
          onPressed: () => context.push('/tracker/log-past'),
        ),
        AppSpacing.vMD,
        const HistoryInterviewCard(
          company: 'Amazon',
          role: 'SDE I',
          date: 'Oct 1st',
          onTap: null,
        ),
      ],
    );
  }
}
