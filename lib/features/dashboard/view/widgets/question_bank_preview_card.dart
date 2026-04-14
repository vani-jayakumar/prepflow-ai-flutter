import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';

class QuestionBankPreviewCard extends StatelessWidget {
  final VoidCallback onTap;

  const QuestionBankPreviewCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppGlassCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 52.w,
            height: 52.h,
            decoration: BoxDecoration(
              color: AppColors.accentPrimary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.forum_rounded,
              color: AppColors.accentPrimary,
              size: 26.r,
            ),
          ),
          AppSpacing.hMD,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smart Question Bank',
                  style: AppTextStyles.h4.copyWith(
                    color: isDarkMode
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                Text(
                  'Review 15 high-probability questions',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: isDarkMode
                ? AppColors.darkTextTertiary
                : AppColors.lightTextTertiary,
          ),
        ],
      ),
    );
  }
}
