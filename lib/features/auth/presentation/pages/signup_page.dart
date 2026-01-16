import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/social_sign_in_button.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

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
          padding: EdgeInsets.only(left: 16.w),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.neutral100,
              border: Border.all(color: AppColors.neutral200),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.neutralDark,
                size: 20.w,
              ),
              onPressed: () => context.pop(),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Text(
                  AppStrings.joinHyperFocused,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutralDark,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppStrings.signupSubtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textBody,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 32.h),

                // Full Name
                AuthTextField(
                  label: AppStrings.fullName,
                  hintText: AppStrings.fullNameHint,
                  controller: _nameController,
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppStrings.enterName;
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                // Email Address
                AuthTextField(
                  label: AppStrings.emailAddress,
                  hintText: AppStrings.emailHint,
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppStrings.enterEmail;
                    if (!value.contains('@')) return AppStrings.validEmail;
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                // Password
                AuthTextField(
                  label: AppStrings.password,
                  hintText: AppStrings.createPasswordHint,
                  controller: _passwordController,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppStrings.enterPassword;
                    if (value.length < 6) return AppStrings.passwordLength;
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                // Confirm Password
                AuthTextField(
                  label: AppStrings.confirmPassword,
                  hintText: AppStrings.confirmPasswordHint,
                  controller: _confirmPasswordController,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppStrings.confirmYourPassword;
                    if (value != _passwordController.text)
                      return AppStrings.passwordsDoNotMatch;
                    return null;
                  },
                ),

                SizedBox(height: 32.h),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Call API to create account?
                        // For now, per instructions, just navigate to next step.
                        context.go('/signup/verify');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.neutralWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.h),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      AppStrings.continueText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                // Or continue with
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.neutral500)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        AppStrings.orContinueWith,
                        style: TextStyle(
                          color: AppColors.neutral500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.neutral500)),
                  ],
                ),

                SizedBox(height: 32.h),

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
                    SizedBox(width: 16.w),
                    SocialSignInButton(
                      text: AppStrings.apple,
                      assetName: 'assets/images/apple_logo.png',
                      onPressed: () {
                        // TODO
                      },
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.alreadyHaveAccount,
                      style: TextStyle(
                        color: AppColors.neutralDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Text(
                        AppStrings.signIn,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
