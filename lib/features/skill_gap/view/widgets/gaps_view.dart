import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_chip.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import 'missing_requirements_card.dart';

class GapsView extends StatelessWidget {
  final double readinessScore;
  final String matchLabel;
  final List<String> strengths;
  final List<String> skillGaps;
  final List<String> focusAreas;

  const GapsView({
    super.key,
    required this.readinessScore,
    required this.matchLabel,
    required this.strengths,
    required this.skillGaps,
    required this.focusAreas,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      children: [
        _ReadinessSummaryCard(
          readinessScore: readinessScore,
          matchLabel: matchLabel,
        ),
        MissingRequirementsCard(
          title: 'Strength Snapshot',
          description: 'What your profile already aligns with for this role.',
          items: strengths,
          chipType: ChipType.strong,
          icon: Icons.verified_rounded,
          iconColor: AppColors.success,
          emptyMessage: 'No strengths identified yet.',
        ),
        MissingRequirementsCard(
          title: 'Skill Gaps',
          description:
              'Core requirements you should strengthen before interviews.',
          items: skillGaps,
          chipType: ChipType.weak,
          icon: Icons.warning_amber_rounded,
          iconColor: AppColors.danger,
          emptyMessage: 'No skill gaps found for this analysis.',
        ),
        MissingRequirementsCard(
          title: 'Focus Areas',
          description: 'Top areas to prioritize for short-term preparation.',
          items: focusAreas,
          chipType: ChipType.info,
          icon: Icons.track_changes_rounded,
          iconColor: AppColors.info,
          emptyMessage: 'No focus areas were returned by AI.',
        ),
      ],
    );
  }
}

class _ReadinessSummaryCard extends StatelessWidget {
  final double readinessScore;
  final String matchLabel;

  const _ReadinessSummaryCard({
    required this.readinessScore,
    required this.matchLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Readiness Overview',
            style: AppTextStyles.h4.copyWith(
              color: isDarkMode
                  ? AppColors.darkTextPrimary
                  : AppColors.lightTextPrimary,
            ),
          ),
          AppSpacing.vMD,
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDarkMode
                        ? AppColors.darkGradPrimary
                        : AppColors.lightGradPrimary,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${readinessScore.toInt()}%',
                  style: AppTextStyles.h4.copyWith(color: Colors.white),
                ),
              ),
              AppSpacing.hMD,
              Expanded(
                child: Text(
                  matchLabel.isEmpty ? 'N/A' : matchLabel,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.vMD,
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              AppChip(label: 'AI Derived', type: ChipType.accent),
              AppChip(
                label: readinessScore >= 70 ? 'Interview Ready' : 'Needs Focus',
                type: readinessScore >= 70 ? ChipType.strong : ChipType.weak,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
