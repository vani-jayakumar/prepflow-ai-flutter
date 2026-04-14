import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_chip.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SkillGapPreviewCard extends StatelessWidget {
  final VoidCallback onTap;

  const SkillGapPreviewCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppGlassCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDarkMode
                        ? AppColors.darkGradSecondary
                        : AppColors.lightGradSecondary,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.auto_graph_rounded,
                  color: Colors.white,
                  size: 20.r,
                ),
              ),
              AppSpacing.hMD,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Skill Gap Insights',
                      style: AppTextStyles.h4.copyWith(
                        color: isDarkMode
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    Text(
                      'Based on your resume & job description',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSpacing.vMD,
          Row(
            children: [
              const AppChip(label: 'Python', type: ChipType.strong),
              AppSpacing.hSM,
              const AppChip(label: 'System Design', type: ChipType.weak),
              AppSpacing.hSM,
              const AppChip(label: '+3 more', type: ChipType.defaultType),
            ],
          ),
        ],
      ),
    );
  }
}
