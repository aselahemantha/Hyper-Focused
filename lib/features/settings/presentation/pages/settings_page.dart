import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/settings/presentation/widgets/settings_section_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/app_logo_small.png',
                          height: 45,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.change_history,
                              size: 45,
                              color: AppColors.neutralDark,
                            );
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        // Context.pop() if it's pushed, but settings is a tab.
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.neutralWhite,
                        padding: const EdgeInsets.all(8),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Profile Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.neutralWhite,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/user_avatar_placeholder.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Jesse Doe',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.neutralDark,
                              ),
                            ),
                            Text(
                              'jessejoe@email.com',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.neutral500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/edit-profile');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary100,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: const Text(
                          AppStrings.editProfile,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Management Section
                const Text(
                  AppStrings.management,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textBody,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SettingsSectionTile(
                        icon: Icons.people_outline,
                        title: AppStrings.contacts,
                        onTap: () {
                          context.push('/contacts');
                        },
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      SettingsSectionTile(
                        icon: Icons.calendar_today_outlined,
                        title: AppStrings.calender,
                        onTap: () {},
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      SettingsSectionTile(
                        icon: Icons.grid_view_outlined,
                        title: AppStrings.templateCentre,
                        onTap: () {},
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      SettingsSectionTile(
                        icon: Icons.format_list_bulleted,
                        title: AppStrings.myServices,
                        onTap: () {
                          context.push('/my-services');
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Analytics Section
                const Text(
                  AppStrings.analytics,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textBody,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.neutralWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SettingsSectionTile(
                        icon: Icons.show_chart,
                        title: AppStrings.mySubscription,
                        onTap: () {},
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      SettingsSectionTile(
                        icon: Icons.person_outline,
                        title: AppStrings.finance,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Device Settings Section
                const Text(
                  AppStrings.deviceSettings,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textBody,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.neutralWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SettingsSectionTile(
                        icon: Icons.smartphone_outlined,
                        title: AppStrings.applicationSettings,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Support Centre Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppStrings.supportCentre,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textBody,
                        fontWeight: FontWeight.w400,
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
                        AppStrings.reportAProblem,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.neutralWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SettingsSectionTile(
                        icon: Icons.help_outline,
                        title: AppStrings.knowledgeCentre,
                        onTap: () {},
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      SettingsSectionTile(
                        icon: Icons.help_outline,
                        title: AppStrings.hireATutor,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Bottom Footer
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.neutralWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          AppStrings.signOut,
                          style: TextStyle(
                            color: AppColors.statusNotify,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          _buildSocialIcon(Icons.language),
                          const SizedBox(width: 8),
                          _buildSocialIcon(Icons.camera_alt_outlined),
                          // Instagram-ish
                          const SizedBox(width: 8),
                          _buildSocialIcon(Icons.play_circle_outline),
                          // Youtube-ish
                          const SizedBox(width: 8),
                          _buildSocialIcon(Icons.book_outlined),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Icon(icon, size: 20, color: AppColors.textBody);
  }
}
