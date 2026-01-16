import 'package:flutter/material.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';
import 'package:hyper_focused/features/settings/presentation/widgets/section_divider.dart';
import 'package:hyper_focused/features/settings/presentation/widgets/settings_tile.dart';
import 'package:hyper_focused/features/settings/presentation/widgets/address_card.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary200,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    // Profile Image
                    Stack(
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4.w),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/user_avatar_placeholder.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.neutralDark.withOpacity(0.1),
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
                              padding: EdgeInsets.all(8.w),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: AppColors.neutralWhite,
                                size: 16.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),

                    // Personal Information Divider
                    SectionDivider(text: AppStrings.personalInformation),

                    // Personal Details Header
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppStrings.personalDetails,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.neutralDark,
                          ),
                        ),
                      ),
                    ),

                    // Personal Details Card
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(12.w),
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

                    SizedBox(height: 24.h),

                    // Company Details Divider
                    const SectionDivider(text: 'Company Details'),

                    SizedBox(height: 8.h),

                    // Company Details Card
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Column(
                        children: [
                          // Company Logo Row
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.business_outlined,
                                  size: 20.w,
                                  color: AppColors.neutral500,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  'Company Logo',
                                  style: TextStyle(
                                    color: AppColors.neutralDark,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: 32.w,
                                  height: 32.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF003366),
                                    // Dark blue like in image
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.water_drop,
                                      color: Colors.blue,
                                      size: 20.w,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14.w,
                                  color: AppColors.neutralDark,
                                ),
                              ],
                            ),
                          ),
                          _buildDivider(),
                          const SettingsTile(
                            icon: Icons.business,
                            title: 'Company Name',
                            value: 'Jesse Doe',
                            isRequired: true,
                          ),
                          _buildDivider(),
                          const SettingsTile(
                            icon: Icons.email_outlined,
                            title: 'Contact Email',
                            value: 'jessedoe@email.com',
                          ),
                          _buildDivider(),
                          const SettingsTile(
                            icon: Icons.phone_outlined,
                            title: 'Company Phone',
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

                    SizedBox(height: 24.h),

                    // Address Header
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 14.sp,
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

                    // Extra spacing for bottom nav
                    SizedBox(height: 100.h),
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.neutralWhite,
            radius: 18.w,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 16.w,
                color: AppColors.neutralDark,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Text(
            AppStrings.editProfile,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.neutralDark,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.info,
              size: 26.w,
              color: AppColors.neutralDark,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: AppColors.neutral100);
  }
}
