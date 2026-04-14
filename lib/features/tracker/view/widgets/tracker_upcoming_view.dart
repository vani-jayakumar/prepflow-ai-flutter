import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../core/constants/app_spacing.dart';
import 'upcoming_interview_card.dart';

class TrackerUpcomingView extends StatelessWidget {
  const TrackerUpcomingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        AppButton(
          text: '+ Add Upcoming Interview',
          isSecondary: true,
          onPressed: () => context.push('/tracker/add-upcoming'),
        ),
        AppSpacing.vMD,
        UpcomingInterviewCard(
          company: 'Google',
          role: 'SWE L4',
          date: 'Oct 10',
          timeLabel: 'IN 2 DAYS',
          onTap: () => context.go('/input'),
        ),
      ],
    );
  }
}
