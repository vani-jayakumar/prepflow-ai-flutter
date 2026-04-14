import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_glass_card.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';

class HistoryInterviewCard extends StatelessWidget {
  final String company;
  final String role;
  final String date;
  final VoidCallback? onTap;

  const HistoryInterviewCard({
    super.key,
    required this.company,
    required this.role,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppGlassCard(
      borderRadius: 20,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.success,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          AppSpacing.hMD,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                company,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Text(
                '$role • $date',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
