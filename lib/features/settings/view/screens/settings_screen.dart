import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/app/app.dart';

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
            _buildAvatar(context),
            const SizedBox(height: 8),
            const Text('Vani Sharma', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            AppSpacing.vSM,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('Premium Account', style: TextStyle(color: Color(0xFF6366F1), fontSize: 12, fontWeight: FontWeight.w700)),
            ),
            
            AppSpacing.vXL,
            
            AppButton(
              text: 'Edit Profile',
              onPressed: () => context.push('/profile/edit'),
            ),
            
            AppSpacing.vLG,
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('APP SETTINGS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
            ),
            AppSpacing.vMD,
            
            AppGlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark Theme Mode', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  Switch(
                    value: isDark,
                    activeThumbColor: const Color(0xFF6366F1),
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
              icon: const Icon(Icons.logout, size: 18, color: Colors.red),
              onPressed: () => context.go('/login'),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Transform.rotate(
      angle: 0.08,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(colors: [Color(0xFFA78BFA), Color(0xFF34D399)]),
        ),
        child: const Center(
          child: Text('VS', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.black87)),
        ),
      ),
    );
  }
}
