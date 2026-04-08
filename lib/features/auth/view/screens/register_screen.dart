import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // App Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.bolt, size: 40, color: Color(0xFF6366F1)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Join PrepFlow',
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Start mastering your interviews with AI.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              const AppTextField(
                hintText: 'Full Name',
                keyboardType: TextInputType.name,
              ),
              const AppTextField(
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
              ),
              const AppTextField(
                hintText: 'Password',
                isPassword: true,
              ),
              
              const SizedBox(height: 8),
              AppButton(
                text: 'Create Account',
                onPressed: () => context.go('/input'),
              ),
              
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: Divider(color: Theme.of(context).dividerColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'OR',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Expanded(child: Divider(color: Theme.of(context).dividerColor)),
                ],
              ),
              
              const SizedBox(height: 24),
              Row(
                children: [
                   SocialAuthButton(
                     icon: const Icon(Icons.g_mobiledata, size: 40, color: Color(0xFF4285F4)),
                     onTap: () {},
                   ),
                   const SizedBox(width: 12),
                   SocialAuthButton(
                     icon: const Icon(Icons.apple, size: 32),
                     onTap: () {},
                   ),
                ],
              ),
              
              const SizedBox(height: 32),
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
                          color: Color(0xFF6366F1),
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
