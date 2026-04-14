import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../widgets/social_auth_button.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                padding: EdgeInsets.all(8.r),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.bolt,
                      size: 40.r,
                      color: AppColors.accentPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Join PrepFlow',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Start mastering your interviews with AI.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),

              const AppTextField(
                hintText: 'Full Name',
                keyboardType: TextInputType.name,
              ),
              const AppTextField(
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
              ),
              const AppTextField(hintText: 'Password', isPassword: true),

              SizedBox(height: 8.h),
              AppButton(
                text: 'Create Account',
                onPressed: () => context.go('/input'),
              ),

              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Theme.of(context).dividerColor),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'OR',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Theme.of(context).dividerColor),
                  ),
                ],
              ),

              SizedBox(height: 24.h),
              Row(
                children: [
                  SocialAuthButton(
                    icon: Icon(
                      Icons.g_mobiledata,
                      size: 40.r,
                      color: const Color(0xFF4285F4),
                    ),
                    onTap: () {},
                  ),
                  SizedBox(width: 12.w),
                  SocialAuthButton(
                    icon: Icon(Icons.apple, size: 32.r),
                    onTap: () {},
                  ),
                ],
              ),

              SizedBox(height: 32.h),
              GestureDetector(
                onTap: () => context.go('/login'),
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: const [
                      TextSpan(
                        text: 'Log In',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.accentPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
