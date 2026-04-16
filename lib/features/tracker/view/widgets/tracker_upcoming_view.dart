import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:prepflow_ai/features/tracker/notifier/tracker_notifier.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../core/constants/app_spacing.dart';
import 'upcoming_interview_card.dart';

class TrackerUpcomingView extends ConsumerWidget {
  const TrackerUpcomingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trackerNotifierProvider);
    final logs = state.upcomingLogs;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        AppButton(
          text: '+ Add Upcoming Interview',
          isSecondary: true,
          onPressed: () => context.push('/tracker/add-upcoming'),
        ),
        AppSpacing.vMD,
        if (state.errorMessage != null)
          Container(
            padding: EdgeInsets.all(16.r),
            color: Colors.redAccent.withValues(alpha: 0.1),
            child: Text(
              'DEBUG ERROR: ${state.errorMessage}',
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
          )
        else if (logs.isEmpty)
          AppEmptyState(
            icon: Icons.calendar_today_rounded,
            title: 'No Upcoming Interviews',
            description: 'Stay ahead of the competition. Add your next interview details to get a custom prep roadmap.',
            actionLabel: 'Schedule Now',
            onAction: () => context.push('/tracker/add-upcoming'),
          )
        else
          ...logs.map((log) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: UpcomingInterviewCard(
                  company: log.companyName,
                  role: log.role,
                  date: DateFormat('MMM d').format(log.dateTime),
                  timeLabel: _getTimeLabel(log.dateTime),
                  onTap: () {
                    // TODO: Show details
                  },
                ),
              )),
      ],
    );
  }

  String _getTimeLabel(DateTime dateTime) {
    final diff = dateTime.difference(DateTime.now());
    if (diff.inDays == 0) return 'TODAY';
    if (diff.inDays == 1) return 'TOMORROW';
    if (diff.inDays > 1 && diff.inDays < 7) return 'IN ${diff.inDays} DAYS';
    return DateFormat('MMM d').format(dateTime).toUpperCase();
  }
}
