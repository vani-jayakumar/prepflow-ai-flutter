import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

enum ChipType { defaultType, weak, strong, accent }

class AppChip extends StatelessWidget {
  final String label;
  final ChipType type;
  final VoidCallback? onTap;

  const AppChip({
    super.key,
    required this.label,
    this.type = ChipType.defaultType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    BorderSide borderSide = BorderSide(color: Theme.of(context).dividerColor);

    switch (type) {
      case ChipType.weak:
        bgColor = AppColors.danger.withValues(alpha: 0.1);
        textColor = AppColors.danger;
        borderSide = BorderSide(color: AppColors.danger.withValues(alpha: 0.2));
        break;
      case ChipType.strong:
        bgColor = AppColors.success.withValues(alpha: 0.1);
        textColor = AppColors.success;
        borderSide = BorderSide(color: AppColors.success.withValues(alpha: 0.2));
        break;
      case ChipType.accent:
        return _buildAccentChip(context);
      default:
        bgColor = Theme.of(context).colorScheme.surface;
        textColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.fromBorderSide(borderSide),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccentChip(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final grad = isDarkMode ? AppColors.darkGradSecondary : AppColors.lightGradSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: grad),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
