import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialAuthButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const SocialAuthButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surface.withValues(alpha: isDarkMode ? 0.6 : 0.8),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
