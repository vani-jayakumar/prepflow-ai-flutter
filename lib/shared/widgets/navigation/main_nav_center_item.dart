import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MainCenterNavItem extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color backgroundColor;
  final bool isDarkMode;

  const MainCenterNavItem({
    super.key,
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
    required this.isDarkMode,
  });

  @override
  State<MainCenterNavItem> createState() => _MainCenterNavItemState();
}

class _MainCenterNavItemState extends State<MainCenterNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _glowAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(_) {
    _controller.forward();
  }

  void _handleTapUp(_) {
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = [
      AppColors.accentPrimary,
      AppColors.accentSecondary,
    ];

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: gradientColors.first.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                  // Pressed glow
                  if (_glowAnimation.value > 0)
                    BoxShadow(
                      color: gradientColors.first.withValues(alpha: 0.6),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                ],
              ),
              child: Icon(widget.icon, size: 26, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
