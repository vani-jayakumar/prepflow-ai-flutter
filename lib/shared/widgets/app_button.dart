import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final Widget? icon;
  final bool isLoading;
  final bool isDisabled;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(_) {
    if (widget.onPressed != null && !widget.isDisabled) {
      _controller.forward();
    }
  }

  void _handleTapUp(_) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryGrad = isDarkMode
        ? AppColors.darkGradPrimary
        : AppColors.lightGradPrimary;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.isSecondary
                ? _buildSecondaryButton(context, isDarkMode)
                : _buildPrimaryButton(context, primaryGrad, isDarkMode),
          );
        },
      ),
    );
  }

  Widget _buildPrimaryButton(
    BuildContext context,
    List<Color> gradientColors,
    bool isDarkMode,
  ) {
    final isInteractive = widget.onPressed != null && !widget.isDisabled;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isInteractive
              ? gradientColors
              : gradientColors.map((c) => c.withValues(alpha: 0.5)).toList(),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(
              alpha: isInteractive ? 0.3 : 0.15,
            ),
            offset: Offset(0, 8.h),
            blurRadius: 24.r,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isLoading ? null : widget.onPressed,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isInteractive && !widget.isLoading)
                  AnimatedBuilder(
                    animation: _shimmerAnimation,
                    builder: (context, child) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(_shimmerAnimation.value - 1, 0),
                              end: Alignment(_shimmerAnimation.value, 0),
                              colors: const [
                                Colors.transparent,
                                Colors.white24,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                _buildContent(Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, bool isDarkMode) {
    final isInteractive = widget.onPressed != null && !widget.isDisabled;
    final surfaceColor = isDarkMode
        ? AppColors.darkSurfaceMedium
        : AppColors.lightSurfaceMedium;
    final textColor = isDarkMode
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final borderColor = isDarkMode
        ? AppColors.darkSeparator
        : AppColors.lightSeparator;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: surfaceColor.withValues(alpha: isInteractive ? 1.0 : 0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: borderColor.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isLoading ? null : widget.onPressed,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
            child: _buildContent(textColor),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Color textColor) {
    if (widget.isLoading) {
      return SizedBox(
        height: 20.h,
        width: 20.w,
        child: CircularProgressIndicator(
          strokeWidth: 2.w,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.icon != null) ...[widget.icon!, SizedBox(width: 8.w)],
        Text(
          widget.text,
          style: AppTextStyles.button.copyWith(color: textColor),
        ),
      ],
    );
  }
}
