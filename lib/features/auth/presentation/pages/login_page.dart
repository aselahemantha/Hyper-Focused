import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/social_sign_in_button.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error.toString())));
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
                // Logo
                SvgPicture.asset(
                  'assets/images/svg/hyperfocused_icon.svg',
                  height: 60.h,
                  // width: 60,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.apps,
                    size: 60.w,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 24.h),

                // Title
                Text(
                  AppStrings.welcomeBack,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutralDark,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppStrings.loginSubtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textBody,
                  ),
                ),

                SizedBox(height: 32.h),

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

                SizedBox(height: 20.h),

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

                SizedBox(height: 16.h),

                // Remember Me & Forgot Password
                Row(
                  children: [
                    SizedBox(
                      height: 24.w,
                      width: 24.w,
                      child: Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      AppStrings.rememberMe,
                      style: TextStyle(
                        fontSize: 14.sp,
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

                SizedBox(height: 32.h),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .read(authControllerProvider.notifier)
                                  .login(
                                    _emailController.text,
                                    _passwordController.text,
                                  );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.primary.withOpacity(
                        0.6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.h),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            AppStrings.signIn,
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
                      assetName: 'assets/images/svg/google_logo.svg',
                      onPressed: () {
                        ref
                            .read(authControllerProvider.notifier)
                            .loginWithGoogle();
                      },
                    ),
                    SizedBox(width: 16.w),
                    SocialSignInButton(
                      text: AppStrings.apple,
                      assetName: 'assets/images/svg/apple_logo.svg',
                      onPressed: () {
                        ref
                            .read(authControllerProvider.notifier)
                            .loginWithApple();
                      },
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Sign Up Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: TextStyle(
                        color: AppColors.neutralDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push('/signup'),
                      child: Text(
                        AppStrings.signUp,
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
