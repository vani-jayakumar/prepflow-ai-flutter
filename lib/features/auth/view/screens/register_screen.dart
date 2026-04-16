import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/social_auth_button.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../view_model/auth_view_model.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final isLoading = authState.isLoading;

    // BUSINESS LOGIC: Reactive side effects
    ref.listen(authViewModelProvider, (previous, next) {
      if (next.isSuccess && !(previous?.isSuccess ?? false)) {
        AppToast.showSuccess(context, 'Account created successfully!');
        context.go('/dashboard');
      }
      if (next.errorMessage != null && next.errorMessage != previous?.errorMessage) {
        AppToast.showError(context, next.errorMessage!);
      }
    });

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

              AppTextField(
                hintText: 'Full Name',
                keyboardType: TextInputType.name,
                controller: _nameController,
              ),
              AppTextField(
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              AppTextField(
                hintText: 'Password',
                isPassword: true,
                controller: _passwordController,
              ),

              SizedBox(height: 8.h),
              AppButton(
                text: isLoading ? 'Creating Account...' : 'Create Account',
                isLoading: isLoading,
                onPressed: () {
                  ref.read(authViewModelProvider.notifier).signUpWithEmail(
                    _emailController.text,
                    _passwordController.text,
                    _nameController.text,
                  );
                },
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
                    onTap: () {
                      ref.read(authViewModelProvider.notifier).signInWithGoogle();
                    },
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
                onTap: () {
                  ref.read(authViewModelProvider.notifier).resetState();
                  context.go('/login');
                },
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
