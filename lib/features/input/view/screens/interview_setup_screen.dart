import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../core/constants/app_spacing.dart';

class InterviewSetupScreen extends StatelessWidget {
  const InterviewSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Setup', style: TextStyle(fontWeight: FontWeight.w700)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/dashboard');
            }
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Context Extractor', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            AppSpacing.vSM,
            const Text(
              'Upload Details. The AI will parse them to build your custom mock preparation blueprint.',
              style: TextStyle(fontSize: 14),
            ),
            AppSpacing.vLG,
            
            AppGlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('STEP 1: YOUR RESUME', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  AppSpacing.vMD,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.cloud_upload_outlined, size: 40),
                        AppSpacing.vSM,
                        const Text('Upload PDF / DOCX', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        const Text('Max file size 5MB', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  
                  AppSpacing.vLG,
                  const Text('STEP 2: COMPANY & ROLE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  AppSpacing.vMD,
                  const AppTextField(hintText: 'Company Name (e.g. Google)'),
                  const AppTextField(hintText: 'Target Title (e.g. Senior iOS Engineer)'),
                  const AppTextField(hintText: 'Company/Job Link (Optional)'),
                  
                  AppSpacing.vLG,
                  const Text('STEP 3: JOB DESCRIPTION (JD)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  AppSpacing.vMD,
                  const AppTextField(
                    hintText: 'Paste full Job Description here...',
                    maxLines: 4,
                  ),
                  
                  AppSpacing.vLG,
                  AppButton(
                    text: 'Generate Insights',
                    onPressed: () => context.go('/dashboard'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
