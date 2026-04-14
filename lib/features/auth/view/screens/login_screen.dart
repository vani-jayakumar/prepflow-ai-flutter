import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../notifier/auth_notifier.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../widgets/social_auth_button.dart';
import '../widgets/auth_orb.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please fill in all fields');
      return;
    }

    setState(() => _errorMessage = null);

    final success = await ref
        .read(authNotifierProvider.notifier)
        .signInWithEmail(email, password);

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;

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
                  child: AuthOrb(
                    colors: isDarkMode
                        ? AppColors.darkGradPrimary
                        : AppColors.lightGradPrimary,
                    size: 400.w,
                    opacity: 0.1,
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
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
                        color: Colors.white.withValues(alpha: 0.2),
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
                    'Welcome back',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Log in to access your AI preparation roadmap.',
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
                    text: isLoading ? 'Logging in...' : 'Log In',
                    isLoading: isLoading,
                    onPressed: _signIn,
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
                          'OR CONTINUE WITH',
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
                    onTap: () => context.go('/register'),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: const [
                          TextSpan(
                            text: 'Sign Up',
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
        ],
      ),
    );
  }
}
