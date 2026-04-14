import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_chip.dart';
import '../../../../core/constants/app_spacing.dart';

class QuestionBankCard extends StatelessWidget {
  final Map<String, dynamic> question;
  final VoidCallback onPrepPressed;

  const QuestionBankCard({
    super.key,
    required this.question,
    required this.onPrepPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question['title'],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          AppSpacing.vMD,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...(question['tags'] as List<String>).map((tag) => AppChip(label: tag)),
              AppChip(
                label: question['priority'] == ChipType.accent ? 'High Priority' : 'Medium Priority',
                type: question['priority'],
              ),
            ],
          ),
          AppSpacing.vLG,
          AppButton(
            text: 'Start Mock Interview',
            isSecondary: true,
            onPressed: onPrepPressed,
          ),
        ],
      ),
    );
  }
}
