import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../notifier/auth_notifier.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../widgets/social_auth_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please fill in all fields');
      return;
    }

    if (password.length < 6) {
      setState(() => _errorMessage = 'Password must be at least 6 characters');
      return;
    }

    setState(() => _errorMessage = null);

    final success = await ref
        .read(authNotifierProvider.notifier)
        .signUpWithEmail(email, password);

    if (success && mounted) {
      context.go('/dashboard');
    } else if (mounted) {
      final authState = ref.read(authNotifierProvider);
      setState(() => _errorMessage = authState.errorMessage);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _errorMessage = null);

    final success = await ref
        .read(authNotifierProvider.notifier)
        .signInWithGoogle();

    if (success && mounted) {
      context.go('/dashboard');
    } else if (mounted) {
      final authState = ref.read(authNotifierProvider);
      setState(() => _errorMessage = authState.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

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

              if (_errorMessage != null) ...[
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: AppColors.danger,
                        size: 20.r,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: AppColors.danger,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
              ],

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
                onPressed: _signUp,
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
                    onTap: _signInWithGoogle,
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
