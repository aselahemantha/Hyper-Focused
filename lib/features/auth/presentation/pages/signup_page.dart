
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/social_sign_in_button.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
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
                const Text(
                  AppStrings.joinHyperFocused,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.signupSubtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Full Name
                AuthTextField(
                  label: AppStrings.fullName,
                  hintText: AppStrings.fullNameHint,
                  controller: _nameController,
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) return AppStrings.enterName;
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Email Address
                AuthTextField(
                  label: AppStrings.emailAddress,
                  hintText: AppStrings.emailHint,
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) return AppStrings.enterEmail;
                    if (!value.contains('@')) return AppStrings.validEmail;
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Password
                AuthTextField(
                  label: AppStrings.password,
                  hintText: AppStrings.createPasswordHint,
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) return AppStrings.enterPassword;
                    if (value.length < 6) return AppStrings.passwordLength;
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Confirm Password
                AuthTextField(
                  label: AppStrings.confirmPassword,
                  hintText: AppStrings.confirmPasswordHint,
                  controller: _confirmPasswordController,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) return AppStrings.confirmYourPassword;
                    if (value != _passwordController.text) return AppStrings.passwordsDoNotMatch;
                    return null;
                  },
                ),
                
                const SizedBox(height: 32),
                
                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Call API to create account?
                        // For now, per instructions, just navigate to next step.
                        context.go('/signup/verify');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, // Teal
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      AppStrings.continueText,
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
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        AppStrings.orContinueWith,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
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
                         // TODO
                      },
                    ),
                    const SizedBox(width: 16),
                    SocialSignInButton(
                      text: AppStrings.apple,
                      assetName: 'assets/images/apple_logo.png',
                      onPressed: () {
                         // TODO
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.alreadyHaveAccount,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: const Text(
                        AppStrings.signIn,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
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
