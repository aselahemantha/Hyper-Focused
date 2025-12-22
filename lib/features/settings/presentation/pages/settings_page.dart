import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/settings/presentation/pages/edit_profile_page.dart';
import 'package:hyper_focused/features/contacts/presentation/pages/contacts_page.dart';
import 'package:hyper_focused/features/settings/presentation/widgets/settings_section_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100, // Light background
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
                          'assets/images/app_logo_small.png', // Assuming you have a small logo
                          height: 24,
                          errorBuilder: (context, error, stackTrace) {
                             return const Icon(Icons.change_history, size: 24, color: Colors.black);
                          },
                        ),
                        const SizedBox(width: 8),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                                Text(
                                    "HYPER",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                        height: 1.0,
                                    ),
                                ),
                                Text(
                                    "FOCUSED",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        height: 1.0,
                                    ),
                                ),
                            ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                          Navigator.maybePop(context);
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
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
                    color: AppColors.neutralWhite, // Not really defined, using white
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
                            image: AssetImage('assets/images/user_avatar_placeholder.jpg'),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfilePage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD6EFE6), // Light green
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Management Section
                const Text(
                  'Management',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w500,
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
                        title: 'Contacts',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ContactsPage()),
                          );
                        },
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      SettingsSectionTile(
                        icon: Icons.calendar_today_outlined,
                        title: 'Calendar',
                        onTap: () {},
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      SettingsSectionTile(
                        icon: Icons.grid_view_outlined,
                        title: 'Template Centre',
                        onTap: () {},
                      ),
                       const Divider(height: 1, indent: 16, endIndent: 16),
                      SettingsSectionTile(
                        icon: Icons.format_list_bulleted,
                        title: 'My Services',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Analytics Section
                const Text(
                  'Analytics',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w500,
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
                        icon: Icons.show_chart, // Or similar icon
                        title: 'My Subscription',
                        onTap: () {},
                      ),
                       const Divider(height: 1, indent: 16, endIndent: 16),
                      SettingsSectionTile(
                        icon: Icons.person_outline,
                        title: 'Finance',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Device Settings Section
                const Text(
                  'Device Settings',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.neutral500,
                    fontWeight: FontWeight.w500,
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
                        icon: Icons.smartphone_outlined,
                        title: 'Application Settings',
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
                          'Support Centre',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.neutral500,
                            fontWeight: FontWeight.w500,
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
                                "Report a Problem",
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                ),
                            ),
                        ),
                    ],
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
                        icon: Icons.help_outline,
                        title: 'Knowledge Centre',
                        onTap: () {},
                      ),
                       const Divider(height: 1, indent: 16, endIndent: 16),
                      SettingsSectionTile(
                        icon: Icons.help_outline, // Question mark icon
                        title: 'Hire a Tutor',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Bottom Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(
                          color: Color(0xFFFF6B6B), // Light red
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _buildSocialIcon(Icons.language),
                        const SizedBox(width: 8),
                        _buildSocialIcon(Icons.camera_alt_outlined), // Instagram-ish
                        const SizedBox(width: 8),
                        _buildSocialIcon(Icons.play_circle_outline), // Youtube-ish
                        const SizedBox(width: 8),
                        _buildSocialIcon(Icons.book_outlined),
                      ],
                    ),
                  ],
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
    return Icon(
        icon,
        size: 20,
        color: AppColors.neutral500,
    );
  }
}
