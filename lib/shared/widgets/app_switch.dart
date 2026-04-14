import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const AppSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 52.w,
        height: 28.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          gradient: value
              ? LinearGradient(
                  colors: isDark
                      ? AppColors.darkGradPrimary
                      : AppColors.lightGradPrimary,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: value
              ? null
              : (isDark
                    ? AppColors.darkBgTertiary
                    : AppColors.lightSeparator.withValues(alpha: 0.3)),
          border: Border.all(
            color: value
                ? Colors.transparent
                : (isDark ? AppColors.darkBorder : AppColors.lightSeparator),
            width: 1,
          ),
          boxShadow: value
              ? [
                  BoxShadow(
                    color: AppColors.accentPrimary.withValues(alpha: 0.3),
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.all(2.r),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4.r,
                    offset: Offset(0, 1.h),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
