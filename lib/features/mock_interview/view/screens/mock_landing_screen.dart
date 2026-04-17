import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_colors.dart';
import '../../notifier/session_notifier.dart';

class MockLandingScreen extends ConsumerWidget {
  const MockLandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(sessionNotifierProvider);
    final hasActiveSession =
        sessionState.currentSession != null && sessionState.messages.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mock Interview',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
        child: Column(
          children: [
            AppGlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52.r,
                    height: 52.r,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkGradPrimary
                            : AppColors.lightGradPrimary,
                      ),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Icon(
                      Icons.record_voice_over_rounded,
                      color: Colors.white,
                      size: 28.r,
                    ),
                  ),
                  AppSpacing.vMD,
                  Text('Practice Like It\'s Real', style: AppTextStyles.h3),
                  AppSpacing.vSM,
                  Text(
                    hasActiveSession
                        ? 'You already have an active mock interview session. Continue when you are ready.'
                        : 'Start a focused interview simulation with AI follow-up questions and feedback-like prompts.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SafeArea(
              top: false,
              child: AppButton(
                text: hasActiveSession
                    ? 'Resume Mock Interview'
                    : 'Let\'s Start Mock Interview',
                onPressed: () => context.push('/mock/live'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
