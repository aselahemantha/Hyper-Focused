import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:hyper_focused/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class SignupDetailsPage extends ConsumerStatefulWidget {
  const SignupDetailsPage({super.key});

  @override
  ConsumerState<SignupDetailsPage> createState() => _SignupDetailsPageState();
}

class _SignupDetailsPageState extends ConsumerState<SignupDetailsPage> {
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _yearsController = TextEditingController();
  final _inspectorsCountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _companyController.dispose();
    _yearsController.dispose();
    _inspectorsCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Navigate home on success is handled in the listener in SignupPage or logic there.
    // For now we assume this page completes the flow and manually navigates.

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
                  AppStrings.employmentDetails,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.neutralDark,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  AppStrings.employmentDetailsSubtitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textBody,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 32.h),

                // Phone Number
                AuthTextField(
                  label: AppStrings.phoneNumber,
                  hintText: AppStrings.phoneNumberHint,
                  controller: _phoneController,
                  prefixIcon: Icons.phone_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return AppStrings.enterPhone;
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                // Company
                AuthTextField(
                  label: AppStrings.company,
                  hintText: AppStrings.companyHint,
                  controller: _companyController,
                  prefixIcon: Icons.business_outlined,
                ),

                SizedBox(height: 20.h),

                // Years
                AuthTextField(
                  label: AppStrings.yearsAsInspector,
                  hintText: AppStrings.yearsAsInspectorHint,
                  controller: _yearsController,
                ),

                SizedBox(height: 20.h),

                // Number of Inspectors
                AuthTextField(
                  label: AppStrings.numberOfInspectors,
                  hintText: AppStrings.numberOfInspectorsHint,
                  controller: _inspectorsCountController,
                ),

                SizedBox(height: 32.h),

                // Complete Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              // Simulate API call
                              await Future.delayed(const Duration(seconds: 2));

                              if (mounted) {
                                context.go('/landing');
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.neutralWhite,
                      disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.h),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 24.w,
                            width: 24.w,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            AppStrings.complete,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.neutralWhite,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
