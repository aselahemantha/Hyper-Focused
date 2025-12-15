
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/social_sign_in_button.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        context.go('/');
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState is AsyncLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.neutral100,
              border: Border.all(color: AppColors.neutral200),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.neutralDark, size: 20),
              onPressed: () => context.pop(),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Logo
                Image.asset(
                  'assets/images/hyperfocused_icon.png',
                  height: 60,
                  // width: 60,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.apps, size: 60, color: AppColors.primary),
                ),
                const SizedBox(height: 24),
                
                // Title
                const Text(
                  AppStrings.welcomeBack,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutralDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.loginSubtitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textBody,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Email Field
                AuthTextField(
                  label: AppStrings.emailAddress,
                  hintText: AppStrings.emailHint,
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterEmail;
                    }
                    if (!value.contains('@')) {
                      return AppStrings.validEmail;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Password Field
                AuthTextField(
                  label: AppStrings.password,
                  hintText: AppStrings.passwordHint,
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.enterPassword;
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                
                // Remember Me & Forgot Password
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      AppStrings.rememberMe,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.neutralDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                         // TODO: Implement Forgot Password
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: AppColors.primary,
                      ),
                      child: const Text(AppStrings.forgotPassword),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              ref.read(authControllerProvider.notifier).login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            AppStrings.signIn,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Or continue with
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.neutral500)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        AppStrings.orContinueWith,
                        style: TextStyle(
                          color: AppColors.neutral500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.neutral500)),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Social Buttons
                Row(
                  children: [
                    SocialSignInButton(
                      text: AppStrings.google,
                      assetName: 'assets/images/google_logo.png',
                      onPressed: () {
                        ref.read(authControllerProvider.notifier).loginWithGoogle();
                      },
                    ),
                    const SizedBox(width: 16),
                    SocialSignInButton(
                      text: AppStrings.apple,
                      assetName: 'assets/images/apple_logo.png',
                      onPressed: () {
                        ref.read(authControllerProvider.notifier).loginWithApple();
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Sign Up Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.dontHaveAccount,
                      style: TextStyle(
                        color: AppColors.neutralDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push('/signup'),
                      child: const Text(
                        AppStrings.signUp,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
