import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../core/constants/app_spacing.dart';

class LogUpcomingScreen extends StatelessWidget {
  const LogUpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Interview', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('New Schedule', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            AppSpacing.vSM,
            const Text(
              'Enter details so AI can build your preparation timeline.',
              style: TextStyle(fontSize: 14),
            ),
            AppSpacing.vLG,
            
            AppGlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('BASICS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  AppSpacing.vMD,
                  const AppTextField(hintText: 'Company Name (e.g. Meta)'),
                  const AppTextField(hintText: 'Target Role (e.g. Senior Frontend)'),
                  
                  Row(
                    children: [
                      const Expanded(child: AppTextField(labelText: 'Date', hintText: 'select')),
                      AppSpacing.hMD,
                      const Expanded(child: AppTextField(labelText: 'Time', hintText: 'select')),
                    ],
                  ),
                  
                  AppSpacing.vLG,
                  const Text('JOB DESCRIPTION (JD)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  AppSpacing.vMD,
                  const AppTextField(
                    hintText: 'Paste the JD here... PrepFlow AI will automatically extract required skills.',
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            
            AppButton(
              text: 'Save to Planner',
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
