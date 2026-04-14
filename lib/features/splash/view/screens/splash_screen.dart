import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/splash_orb.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) context.go('/login');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  top: -100.h,
                  right: -100.w,
                  child: SplashOrb(
                    colors: isDarkMode
                        ? AppColors.darkGradPrimary
                        : AppColors.lightGradPrimary,
                    size: 400.w,
                    opacity: isDarkMode ? 0.2 : 0.4,
                  ),
                ),
                Positioned(
                  bottom: -50.h,
                  left: -100.w,
                  child: SplashOrb(
                    colors: isDarkMode
                        ? AppColors.darkGradSecondary
                        : AppColors.lightGradSecondary,
                    size: 350.w,
                    opacity: isDarkMode ? 0.15 : 0.3,
                  ),
                ),
              ],
            ),
          ),

          FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(40.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          offset: Offset(0, 30.h),
                          blurRadius: 60.r,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(12.r),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28.r),
                      child: Container(
                        color: Colors.white.withValues(alpha: 0.2),
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.bolt, size: 80.r, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'PrepFlow',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'The AI Coach & Planner',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
