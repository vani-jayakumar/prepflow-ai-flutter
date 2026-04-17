import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

enum ChipType { defaultType, weak, strong, accent, info }

class AppChip extends StatefulWidget {
  final String label;
  final ChipType type;
  final VoidCallback? onTap;
  final IconData? icon;

  const AppChip({
    super.key,
    required this.label,
    this.type = ChipType.defaultType,
    this.onTap,
    this.icon,
  });

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(_) {
    if (widget.onTap != null) {
      _controller.forward();
    }
  }

  void _handleTapUp(_) {
    if (widget.onTap != null) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (widget.type == ChipType.accent) {
      return _buildAccentChip(context, isDarkMode);
    }

    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (widget.type) {
      case ChipType.weak:
        bgColor = AppColors.dangerLight;
        textColor = AppColors.danger;
        borderColor = AppColors.danger.withValues(alpha: 0.15);
        break;
      case ChipType.strong:
        bgColor = AppColors.successLight;
        textColor = AppColors.success;
        borderColor = AppColors.success.withValues(alpha: 0.15);
        break;
      case ChipType.info:
        bgColor = AppColors.infoLight;
        textColor = AppColors.info;
        borderColor = AppColors.info.withValues(alpha: 0.15);
        break;
      default:
        bgColor = isDarkMode
            ? AppColors.darkSurfaceMedium
            : AppColors.lightSurfaceMedium;
        textColor = isDarkMode
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary;
        borderColor = isDarkMode
            ? AppColors.darkSeparator.withValues(alpha: 0.3)
            : AppColors.lightSeparator.withValues(alpha: 0.3);
    }

    return GestureDetector(
      onTapDown: widget.onTap != null ? _handleTapDown : null,
      onTapUp: widget.onTap != null ? _handleTapUp : null,
      onTapCancel: widget.onTap != null ? _handleTapCancel : null,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: borderColor, width: 0.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 14.r, color: textColor),
                    SizedBox(width: 4.w),
                  ],
                  Flexible(
                    child: Text(
                      widget.label,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAccentChip(BuildContext context, bool isDarkMode) {
    final gradientColors = isDarkMode
        ? AppColors.darkGradSecondary
        : AppColors.lightGradSecondary;

    return GestureDetector(
      onTapDown: widget.onTap != null ? _handleTapDown : null,
      onTapUp: widget.onTap != null ? _handleTapUp : null,
      onTapCancel: widget.onTap != null ? _handleTapCancel : null,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: gradientColors.first.withValues(alpha: 0.2),
                    offset: Offset(0, 2.h),
                    blurRadius: 8.r,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 14.r, color: Colors.white),
                    SizedBox(width: 4.w),
                  ],
                  Flexible(
                    child: Text(
                      widget.label,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
