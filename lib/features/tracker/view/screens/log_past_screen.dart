import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class LogPastScreen extends StatelessWidget {
  const LogPastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Interview', style: TextStyle(fontWeight: FontWeight.w700)),
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
            const Text('Log Past Interview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            AppSpacing.vSM,
            const Text(
              'Feed real questions into your Brain to improve future mocks.',
              style: TextStyle(fontSize: 14),
            ),
            AppSpacing.vLG,
            
            AppGlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('INTERVIEW META', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  AppSpacing.vMD,
                  const AppTextField(hintText: 'Company Name (e.g. Amazon)'),
                  const AppTextField(hintText: 'Role (e.g. SDE I)'),
                  
                  AppSpacing.vLG,
                  const Text('QUESTIONS THEY ASKED', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2, color: Color(0xFF6366F1))),
                  AppSpacing.vXS,
                  const Text('Add the technical or behavioral questions you remember.', style: TextStyle(fontSize: 14)),
                  AppSpacing.vMD,
                  
                  _buildQuestionItem(context, 'What is a Bloom Filter?'),
                  _buildQuestionItem(context, 'Design a distributed rate limiter.'),
                  
                  AppSpacing.vMD,
                  Row(
                    children: [
                      const Expanded(child: AppTextField(hintText: 'Type a new question...')),
                      AppSpacing.hMD,
                      SizedBox(
                        width: 80,
                        child: AppButton(text: 'Add', onPressed: () {}),
                      ),
                    ],
                  ),
                  
                  AppSpacing.vLG,
                  const Text('OUTCOME', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
                  AppSpacing.vMD,
                  const Wrap(
                    spacing: 8,
                    children: [
                      _OutcomeChip(label: 'Offer Received'),
                      _OutcomeChip(label: 'Rejected'),
                      _OutcomeChip(label: 'Waiting', isActive: true),
                    ],
                  ),
                ],
              ),
            ),
            
            AppButton(
              text: 'Commit to Study Bank',
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionItem(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
          const Icon(Icons.close, size: 18, color: AppColors.danger),
        ],
      ),
    );
  }
}

class _OutcomeChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _OutcomeChip({required this.label, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF6366F1) : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? Colors.transparent : Theme.of(context).dividerColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
