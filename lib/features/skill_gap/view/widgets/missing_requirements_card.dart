import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../shared/widgets/app_chip.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class MissingRequirementsCard extends StatelessWidget {
  const MissingRequirementsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('!', style: TextStyle(color: AppColors.danger, fontSize: 20, fontWeight: FontWeight.w800)),
              AppSpacing.hSM,
              const Text('Missing Requirements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
          AppSpacing.vSM,
          const Text('Core elements asked by employer, missing from resume.', style: TextStyle(fontSize: 14)),
          AppSpacing.vMD,
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppChip(label: 'GraphQL APIs', type: ChipType.weak),
              AppChip(label: 'Docker Containerization', type: ChipType.weak),
            ],
          ),
        ],
      ),
    );
  }
}
