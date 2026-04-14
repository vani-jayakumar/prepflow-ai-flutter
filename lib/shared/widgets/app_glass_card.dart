import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class AppGlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool animateOnTap;

  const AppGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20.0,
    this.onTap,
    this.animateOnTap = true,
  });

  @override
  State<AppGlassCard> createState() => _AppGlassCardState();
}

class _AppGlassCardState extends State<AppGlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _shadowAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(_) {
    if (widget.onTap != null && widget.animateOnTap) {
      _controller.forward();
    }
  }

  void _handleTapUp(_) {
    if (widget.onTap != null && widget.animateOnTap) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onTap != null && widget.animateOnTap) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final glassColor = isDarkMode ? AppColors.darkGlass : AppColors.lightGlass;
    final borderColor = isDarkMode
        ? AppColors.darkBorder
        : AppColors.lightBorder;
    final shadowColor = isDarkMode
        ? AppColors.shadowMedium
        : AppColors.shadowLight;

    return GestureDetector(
      onTapDown: widget.onTap != null ? _handleTapDown : null,
      onTapUp: widget.onTap != null ? _handleTapUp : null,
      onTapCancel: widget.onTap != null ? _handleTapCancel : null,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    offset: Offset(0, 8.h),
                    blurRadius: 24.r,
                    spreadRadius: 0,
                  ),
                  if (widget.animateOnTap && _shadowAnimation.value > 0)
                    BoxShadow(
                      color: AppColors.accentPrimary.withValues(alpha: 0.08),
                      offset: Offset(0, 4.h),
                      blurRadius: 16.r,
                      spreadRadius: -4,
                    ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                  child: Container(
                    padding: widget.padding ?? EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: glassColor,
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius.r,
                      ),
                      border: Border.all(color: borderColor, width: 0.5),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
