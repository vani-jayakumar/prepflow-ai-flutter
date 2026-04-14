import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Avatar Section
            const UserAvatar(initials: 'VS'),
            const SizedBox(height: 8),
            const Text('Vani Sharma', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            AppSpacing.vSM,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accentPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Premium Account',
                style: TextStyle(
                  color: AppColors.accentPrimary,
                  fontSize: 12,
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'APP SETTINGS',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2),
              ),
            ),
            AppSpacing.vMD,
            
            AppGlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark Theme Mode', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  AppSwitch(
                    value: isDark,
                    onChanged: (val) {
                      ref.read(themeModeProvider.notifier).state = val ? ThemeMode.dark : ThemeMode.light;
                    },
                  ),
                ],
              ),
            ),
            
            AppSpacing.vLG,
            AppButton(
              text: 'Log Out',
              isSecondary: true,
              icon: Icon(Icons.logout, size: 18, color: AppColors.danger),
              onPressed: () => context.go('/login'),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
