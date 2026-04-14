import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_gradient_card.dart';
import '../../../../core/constants/app_spacing.dart';

class UpcomingInterviewCard extends StatelessWidget {
  final String company;
  final String role;
  final String date;
  final String? timeLabel;
  final VoidCallback? onTap;

  const UpcomingInterviewCard({
    super.key,
    required this.company,
    required this.role,
    required this.date,
    this.timeLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppGradientCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                company,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              if (timeLabel != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    timeLabel!,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
            ],
          ),
          AppSpacing.vSM,
          Text(
            '$role • $date',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
