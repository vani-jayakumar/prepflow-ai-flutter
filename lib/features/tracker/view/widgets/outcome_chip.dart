import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class OutcomeChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const OutcomeChip({
    super.key,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.accentPrimary
              : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isActive
                ? Colors.transparent
                : Theme.of(context).dividerColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isActive
                ? Colors.white
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}
