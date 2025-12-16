import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:hyper_focused/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';

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
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.neutral100,
              border: Border.all(color: AppColors.neutral200),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.neutralDark,
                size: 20,
              ),
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
                  AppStrings.employmentDetails,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.neutralDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.employmentDetailsSubtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textBody,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 32),

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

                const SizedBox(height: 20),

                // Company
                AuthTextField(
                  label: AppStrings.company,
                  hintText: AppStrings.companyHint,
                  controller: _companyController,
                  prefixIcon: Icons.business_outlined,
                ),

                const SizedBox(height: 20),

                // Years
                AuthTextField(
                  label: AppStrings.yearsAsInspector,
                  hintText: AppStrings.yearsAsInspectorHint,
                  controller: _yearsController,
                ),

                const SizedBox(height: 20),

                // Number of Inspectors
                AuthTextField(
                  label: AppStrings.numberOfInspectors,
                  hintText: AppStrings.numberOfInspectorsHint,
                  controller: _inspectorsCountController,
                ),

                const SizedBox(height: 32),

                // Complete Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
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
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            AppStrings.complete,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.neutralWhite,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
