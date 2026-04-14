import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_switch.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/app/app.dart';
import '../widgets/user_avatar.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const UserAvatar(initials: 'VS'),
            SizedBox(height: 8.h),
            Text(
              'Vani Sharma',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
            ),
            AppSpacing.vSM,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.accentPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Premium Account',
                style: TextStyle(
                  color: AppColors.accentPrimary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            AppSpacing.vXL,

            AppButton(
              text: 'Edit Profile',
              onPressed: () => context.push('/profile/edit'),
            ),

            AppSpacing.vLG,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'APP SETTINGS',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            AppSpacing.vMD,

            AppGlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark Theme Mode',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppSwitch(
                    value: isDark,
                    onChanged: (val) {
                      ref.read(themeModeProvider.notifier).state = val
                          ? ThemeMode.dark
                          : ThemeMode.light;
                    },
                  ),
                ],
              ),
            ),

            AppSpacing.vLG,
            AppButton(
              text: 'Log Out',
              isSecondary: true,
              icon: Icon(Icons.logout, size: 18.r, color: AppColors.danger),
              onPressed: () => context.go('/login'),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
