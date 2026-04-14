import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import 'main_nav_item.dart';
import 'main_nav_center_item.dart';

class MainBottomNavBar extends StatelessWidget {
  final String location;
  final bool isDarkMode;

  const MainBottomNavBar({
    super.key,
    required this.location,
    required this.isDarkMode,
  });

  int _calculateSelectedIndex() {
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/bank')) return 1;
    if (location.startsWith('/mock')) return 2;
    if (location.startsWith('/tracker')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/bank');
        break;
      case 2:
        context.go('/mock');
        break;
      case 3:
        context.go('/tracker');
        break;
      case 4:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex();
    final primaryColor = AppColors.accentPrimary;

    final glassColor = isDarkMode ? AppColors.darkGlass : AppColors.lightGlass;
    final borderColor = isDarkMode
        ? AppColors.darkBorder
        : AppColors.lightBorder;

    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 28.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: glassColor,
              borderRadius: BorderRadius.circular(32.r),
              border: Border.all(color: borderColor, width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black.withValues(alpha: 0.4)
                      : Colors.black.withValues(alpha: 0.08),
                  blurRadius: 24.r,
                  offset: Offset(0, 8.h),
                ),
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.08),
                  blurRadius: 32.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MainNavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                  isActive: selectedIndex == 0,
                  onTap: () => _onTap(context, 0),
                  activeColor: primaryColor,
                ),
                MainNavItem(
                  icon: Icons.list_alt_outlined,
                  activeIcon: Icons.list_alt_rounded,
                  label: 'Bank',
                  isActive: selectedIndex == 1,
                  onTap: () => _onTap(context, 1),
                  activeColor: primaryColor,
                ),
                MainCenterNavItem(
                  icon: Icons.forum_rounded,
                  onTap: () => _onTap(context, 2),
                  backgroundColor: primaryColor,
                  isDarkMode: isDarkMode,
                ),
                MainNavItem(
                  icon: Icons.calendar_month_outlined,
                  activeIcon: Icons.calendar_month_rounded,
                  label: 'Planner',
                  isActive: selectedIndex == 3,
                  onTap: () => _onTap(context, 3),
                  activeColor: primaryColor,
                ),
                MainNavItem(
                  icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  label: 'Profile',
                  isActive: selectedIndex == 4,
                  onTap: () => _onTap(context, 4),
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
