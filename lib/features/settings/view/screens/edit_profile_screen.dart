import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../core/constants/app_spacing.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Information', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            AppGlassCard(
              child: Column(
                children: [
                   Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(colors: [AppColors.accentPrimary, AppColors.accentSecondary]),
                    ),
                    child: const Center(
                      child: Text('VS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black87)),
                    ),
                  ),
                  AppSpacing.vSM,
                  Text(
                    'Change Avatar',
                    style: TextStyle(
                      color: AppColors.accentPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            
            AppGlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PRIMARY INFO', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  AppSpacing.vMD,
                  const AppTextField(hintText: 'Full Name'),
                  const AppTextField(hintText: 'Email Address'),
                  const AppTextField(hintText: 'Phone Number', keyboardType: TextInputType.phone),
                  
                  AppSpacing.vLG,
                  const Text('MASTER RESUME', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  AppSpacing.vMD,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Vani_Resume_Oct.pdf', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        GestureDetector(
                          onTap: () {},
                          child: const Text('Remove', style: TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.vMD,
                  AppButton(
                    text: '+ Upload New Master Resume',
                    isSecondary: true,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            
            AppButton(
              text: 'Save Changes',
              onPressed: () => context.pop(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
