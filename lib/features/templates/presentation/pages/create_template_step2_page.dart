import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/add_section_dialog.dart';
import 'dart:ui';

class CreateTemplateStep2Page extends StatefulWidget {
  const CreateTemplateStep2Page({super.key});

  @override
  State<CreateTemplateStep2Page> createState() => _CreateTemplateStep2PageState();
}

class _CreateTemplateStep2PageState extends State<CreateTemplateStep2Page> {
  final List<Map<String, dynamic>> _sections = [];

  void _addSection(Map<String, dynamic> sectionData) {
    setState(() {
      _sections.add(sectionData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundColor: AppColors.neutralWhite,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.neutralDark),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        title: Column(
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.neutralDark,
                ),
                children: [
                  TextSpan(text: 'Create a New Template '),
                  WidgetSpan(
                    child: Icon(Icons.arrow_forward, size: 12, color: AppColors.neutralDark),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  TextSpan(text: ' Step 2'),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Main Categories',
              style: TextStyle(
                color: AppColors.neutralDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 14,
              child: const Icon(Icons.info_outline, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.3, 1.0],
            colors: [
              Color(0xFFE0F7FA), // Light cyan/blue at top
              Color(0xFFF5F5F5), // Fade to white-ish
              Color(0xFFF5F5F5),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: [
                  const Text(
                    'You can manage your services here. These services will be shown on your website.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.neutral500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // General Info Item
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.neutral500),
                        const SizedBox(width: 12),
                        const Text(
                          'General Info (Default)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.neutralDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // User Added Sections
                  ..._sections.map((section) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            section['icon'] ?? Icons.folder_outlined,
                            color: AppColors.neutral500,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              section['name'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.neutralDark,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Action for adding sub sections
                            },
                            child: const Text(
                              'Add Sub Sections',
                              style: TextStyle(
                                color: AppColors.primary, // Using primary color (teal-ish)
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),

                  // Add New Section Button
                  GestureDetector(
                    onTap: () => _showAddSectionDialog(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.neutral100,
                          style: BorderStyle.solid, 
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Click to add a New Section',
                          style: TextStyle(
                            color: AppColors.neutral500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Bottom Bar
              Positioned(
                bottom: 24,
                left: 16,
                right: 16,
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 70,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                              color: AppColors.neutralWhite.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(35),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.neutralDark.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back, color: AppColors.neutralDark, size: 28),
                                  onPressed: () => context.pop(),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.save_outlined, color: AppColors.neutralDark, size: 28),
                                  onPressed: () {
                                    // Save
                                  },
                                ),
                                if (_sections.isNotEmpty)
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined, color: AppColors.neutralDark, size: 28),
                                    onPressed: () {
                                      // Edit
                                    },
                                  ),
                                IconButton(
                                  icon: const Icon(Icons.add, color: AppColors.neutralDark, size: 28),
                                  onPressed: () => _showAddSectionDialog(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => _showMenuModal(context),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                            color: AppColors.neutralWhite,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                        child: const Icon(Icons.menu, color: AppColors.neutralDark, size: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMenuModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: AppColors.neutral500),
              title: const Text('Edit Sections'),
              onTap: () {
                context.pop();
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.grid_view, color: AppColors.neutral500),
              title: const Text('New Section'),
              onTap: () {
                context.pop(); // Close sheet
                _showAddSectionDialog(context); // Open dialog
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddSectionDialog(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const AddSectionDialog(),
    );

    if (result != null) {
      _addSection(result);
    }
  }
}
