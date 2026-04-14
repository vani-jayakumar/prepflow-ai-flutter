import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../core/constants/app_spacing.dart';
import 'upcoming_interview_card.dart';

class TrackerUpcomingView extends StatelessWidget {
  const TrackerUpcomingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        AppButton(
          text: '+ Add Upcoming Interview',
          isSecondary: true,
          onPressed: () => context.push('/tracker/add-upcoming'),
        ),
        AppSpacing.vMD,
        const UpcomingInterviewCard(
          company: 'Google',
          role: 'SWE L4',
          date: 'Oct 10',
          timeLabel: 'IN 2 DAYS',
          onTap: null,
        ),
      ],
    );
  }
}
