import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/settings/presentation/widgets/section_divider.dart';
import 'package:hyper_focused/features/settings/presentation/widgets/settings_tile.dart';
import 'package:hyper_focused/features/settings/presentation/widgets/address_card.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF5EF), // Light green background matching image
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile Image
                    Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/user_avatar_placeholder.jpg'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    
                    // Personal Information Divider
                    const SectionDivider(text: 'Personal Information'),

                    // Personal Details Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Personal Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.neutralDark,
                          ),
                        ),
                      ),
                    ),

                    // Personal Details Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          const SettingsTile(
                            icon: Icons.person_outline,
                            title: 'Full Name',
                            value: 'Jesse Doe',
                            isRequired: true,
                          ),
                          _buildDivider(),
                          const SettingsTile(
                            icon: Icons.email_outlined,
                            title: 'Email Address',
                            value: 'jessedoe@email.com',
                            isRequired: true,
                          ),
                          _buildDivider(),
                          const SettingsTile(
                            icon: Icons.phone_outlined,
                            title: 'Phone Number',
                            value: '+1 888 897 778 1239',
                          ),
                          _buildDivider(),
                          const SettingsTile(
                            icon: Icons.language,
                            title: 'Website',
                            value: 'www.jessedoes.com',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Address Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.neutralDark,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Address Card
                    const AddressCard(),

                    // Company Details Divider
                    const SectionDivider(text: 'Company Details'),
                    
                    // Extra spacing for bottom nav
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.neutralDark),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.neutralDark,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 12,
            child: const Icon(Icons.info_outline, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColors.neutral100,
    );
  }
}
