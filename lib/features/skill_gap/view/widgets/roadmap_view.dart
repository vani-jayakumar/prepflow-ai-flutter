import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import 'roadmap_item.dart';

class RoadmapView extends StatelessWidget {
  final List<String> roadmap;

  const RoadmapView({super.key, required this.roadmap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (roadmap.isEmpty) {
      return ListView(
        padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
        children: const [
          AppGlassCard(
            child: Text(
              'No roadmap generated yet. Run analysis to unlock your preparation plan.',
            ),
          ),
        ],
      );
    }

    return ListView(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      children: [
        Text(
          'Structured Preparation',
          style: AppTextStyles.h4.copyWith(
            color: isDarkMode
                ? AppColors.darkTextPrimary
                : AppColors.lightTextPrimary,
          ),
        ),
        AppSpacing.vLG,
        ...List.generate(roadmap.length, (index) {
          final stepNumber = index + 1;
          final label = index == 0 ? 'Up Next • Step 1' : 'Step $stepNumber';
          return RoadmapItem(
            title: 'Module $stepNumber',
            subtitle: roadmap[index],
            label: label,
          );
        }),
      ],
    );
  }
}
