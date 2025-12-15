
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
                  AppStrings.employmentDetails,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.employmentDetailsSubtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
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
                    if (value == null || value.isEmpty) return AppStrings.enterPhone;
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Submit details API call
                        // Manually redirect to home for now to simulate completion
                        // In a real app we might update the state to "authenticated" here
                        
                        // Fake auth success:
                        // Since we don't have the full backend connected for this flow yet,
                        // we can't easily force the AuthState to "loggedIn" without a token.
                        // However, the router logic checks authState.
                        // User instruction says: "Later we can implement the api part".
                        // So I will just attempt to go home. If it redirects back to landing due to no token, so be it,
                        // but actually the router will probably block it.
                        // For the purpose of UI demo, I'll go to home.
                        
                        // NOTE: If the app redirects back to landing because user is not 'logged in' in state, that's expected behavior.
                        // To allow the user to see home, I might need to simulate login or just let them hit the wall.
                        // Given the instruction "created the Uis... hardcoded the navigation", I will navigate.
                        
                        context.go('/'); 
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      AppStrings.complete,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
