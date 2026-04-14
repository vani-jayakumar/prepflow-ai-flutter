import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../widgets/resume_upload_card.dart';
import '../widgets/setup_form_section.dart';

class InterviewSetupScreen extends StatelessWidget {
  const InterviewSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Interview Setup',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Context Extractor',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  AppSpacing.vSM,
                  const Text(
                    'Upload Details. The AI will parse them to build your custom mock preparation blueprint.',
                    style: TextStyle(fontSize: 14),
                  ),
                  AppSpacing.vLG,

                  const AppGlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResumeUploadCard(),
                        AppSpacing.vLG,
                        SetupFormSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sticky Bottom Button
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: AppButton(
                text: 'Generate Insights',
                onPressed: () => context.go('/dashboard'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
