import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_chip.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class MissingRequirementsCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> items;
  final ChipType chipType;
  final IconData icon;
  final Color? iconColor;
  final String emptyMessage;

  const MissingRequirementsCard({
    super.key,
    required this.title,
    required this.description,
    required this.items,
    this.chipType = ChipType.defaultType,
    this.icon = Icons.insights_rounded,
    this.iconColor,
    this.emptyMessage = 'No insights available yet.',
  });

  @override
  Widget build(BuildContext context) {
    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20.r,
                color: iconColor ?? AppColors.accentPrimary,
              ),
              AppSpacing.hSM,
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.vSM,
          Text(description, style: TextStyle(fontSize: 14.sp)),
          AppSpacing.vMD,
          if (items.isEmpty)
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 13.sp,
                color: Theme.of(context).disabledColor,
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items
                  .map((item) => AppChip(label: item, type: chipType))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
