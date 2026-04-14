import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/score_card.dart';
import '../widgets/skill_gap_preview_card.dart';
import '../widgets/question_bank_preview_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getGreeting(),
          style: AppTextStyles.h4.copyWith(
            color: isDarkMode
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScoreCard(score: '88%', label: 'Excellent'),
            AppSpacing.vLG,
            SkillGapPreviewCard(onTap: () => context.go('/bank')),
            AppSpacing.vMD,
            Text(
              'Up Next For You',
              style: AppTextStyles.h3.copyWith(
                color: isDarkMode
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
            AppSpacing.vMD,
            QuestionBankPreviewCard(onTap: () => context.go('/bank')),
            AppSpacing.vLG,
            AppButton(
              text: 'Prepare For A New Role',
              isSecondary: true,
              onPressed: () => context.go('/input'),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }
}
