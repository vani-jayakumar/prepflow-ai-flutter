import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../core/constants/app_spacing.dart';

class RoadmapItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String label;
  final bool isCompleted;
  final VoidCallback? onPressed;

  const RoadmapItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.label,
    this.isCompleted = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Color(0xFF94A3B8), width: 3)),
      ),
      padding: const EdgeInsets.only(left: 20, bottom: 24),
      margin: const EdgeInsets.only(left: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -28.5,
            top: 0,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF6366F1), width: 3),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF6366F1),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.vXS,
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              AppSpacing.vXS,
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14),
              ),
              AppSpacing.vMD,
              AppButton(
                text: 'Take Module',
                isSecondary: true,
                onPressed: onPressed ?? () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
