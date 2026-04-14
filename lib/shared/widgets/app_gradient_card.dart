import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class AppGradientCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;

  const AppGradientCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20.0,
    this.onTap,
    this.gradientColors,
  });

  @override
  State<AppGradientCard> createState() => _AppGradientCardState();
}

class _AppGradientCardState extends State<AppGradientCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

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
    final gradientColors =
        widget.gradientColors ??
        (isDarkMode ? AppColors.darkGradPrimary : AppColors.lightGradPrimary);

    final shadowColor = gradientColors.first.withValues(alpha: 0.25);

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
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    offset: Offset(0, 12.h),
                    blurRadius: 32.r,
                    spreadRadius: 0,
                  ),
                ],
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.2),
                              Colors.white.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: widget.onTap,
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius.r,
                        ),
                        child: Container(
                          padding: widget.padding ?? EdgeInsets.all(20.r),
                          child: widget.child,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
