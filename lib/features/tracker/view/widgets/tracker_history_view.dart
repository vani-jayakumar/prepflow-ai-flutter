import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:prepflow_ai/features/tracker/notifier/tracker_notifier.dart';
import '../../../../shared/widgets/app_empty_state.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../core/constants/app_spacing.dart';
import 'history_interview_card.dart';

class TrackerHistoryView extends ConsumerWidget {
  const TrackerHistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trackerNotifierProvider);
    final logs = state.historyLogs;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        AppButton(
          text: '+ Log Past Interview Details',
          isSecondary: true,
          onPressed: () => context.push('/tracker/log-past'),
        ),
        AppSpacing.vMD,
        if (logs.isEmpty)
          AppEmptyState(
            icon: Icons.history_edu_rounded,
            title: 'No Interview History',
            description: 'Log your past interview experiences to help the AI learn your strengths and gaps.',
            actionLabel: 'Log My First',
            onAction: () => context.push('/tracker/log-past'),
          )
        else
          ...logs.map((log) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: HistoryInterviewCard(
                  company: log.companyName,
                  role: log.role,
                  date: DateFormat('MMM d, y').format(log.dateTime),
                  onTap: () {
                    // TODO: Show report
                  },
                ),
              )),
      ],
    );
  }
}
