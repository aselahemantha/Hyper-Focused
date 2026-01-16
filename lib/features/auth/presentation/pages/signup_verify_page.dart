import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class SignupVerifyPage extends StatefulWidget {
  const SignupVerifyPage({super.key});

  @override
  State<SignupVerifyPage> createState() => _SignupVerifyPageState();
}

class _SignupVerifyPageState extends State<SignupVerifyPage> {
  // Using a list of controllers for the OTP fields
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      }
    }
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Text(
                AppStrings.enter6DigitCode,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.neutralDark,
                ),
              ),
              SizedBox(height: 8.h),
              RichText(
                text: TextSpan(
                  text: AppStrings.verifySubtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textBody,
                    height: 1.5,
                  ),
                  children: [
                    const TextSpan(
                      text: 'jessydoe@email.com', // Passed from prev screen
                      style: TextStyle(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 48.h),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 48.w,
                    height: 56.h,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      onChanged: (value) => _onChanged(value, index),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.neutral100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.w),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.w),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.5.w,
                          ),
                        ),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  );
                }),
              ),

              SizedBox(height: 24.h),

              // Timer and Help
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Remaining 60s',
                    style: TextStyle(color: AppColors.textBody, fontSize: 14.sp),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(AppStrings.needHelp),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Validate OTP
                    context.go('/signup/details');
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
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Resend Code
              Center(
                child: RichText(
                  text: TextSpan(
                    text: AppStrings.didntReceiveCode,
                    style: TextStyle(color: AppColors.textBody, fontSize: 14.sp),
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Resend action
                          },
                          child: Text(
                            AppStrings.resendIt,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
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
