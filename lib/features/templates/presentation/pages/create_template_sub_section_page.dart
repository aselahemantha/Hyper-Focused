import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/add_section_dialog.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/icon_picker_dialog.dart';
import 'dart:ui';

class CreateTemplateSubSectionPage extends StatefulWidget {
  final String categoryName;

  const CreateTemplateSubSectionPage({super.key, required this.categoryName});

  @override
  State<CreateTemplateSubSectionPage> createState() => _CreateTemplateSubSectionPageState();
}

class _CreateTemplateSubSectionPageState extends State<CreateTemplateSubSectionPage> {
  final List<Map<String, dynamic>> _subSections = [];
  bool _isEditing = false;

  void _addSubSection(Map<String, dynamic> sectionData) {
    setState(() {
      _subSections.add(sectionData);
    });
  }

  void _updateSectionName(int index, String newName) {
    setState(() {
      _subSections[index]['name'] = newName;
    });
  }

  void _updateSectionIcon(int index, IconData newIcon) {
    setState(() {
      _subSections[index]['icon'] = newIcon;
    });
  }

  void _removeSection(int index) {
    setState(() {
      _subSections.removeAt(index);
      if (_subSections.isEmpty) {
        _isEditing = false;
      }
    });
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _pickIcon(int index) async {
    final IconData? pickedIcon = await showDialog<IconData>(
      context: context,
      builder: (context) => IconPickerDialog(currentIcon: _subSections[index]['icon']),
    );
    if (pickedIcon != null) {
      _updateSectionIcon(index, pickedIcon);
    }
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
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: AppColors.neutralDark,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(text: 'Main Categories '),
                  const WidgetSpan(
                    child: Icon(Icons.keyboard_arrow_right, size: 20, color: AppColors.neutralDark),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  TextSpan(text: ' ${widget.categoryName}'),
                ],
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
                  
                  // User Added Sub-Sections
                  ..._subSections.asMap().entries.map((entry) {
                    final index = entry.key;
                    final section = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: _isEditing ? () => _pickIcon(index) : null,
                              child: Icon(
                                section['icon'] ?? Icons.folder_outlined,
                                color: AppColors.neutral500,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _isEditing 
                                ? TextField(
                                      controller: TextEditingController(text: section['name'])
                                      ..selection = TextSelection.collapsed(offset: (section['name'] as String).length),
                                      onChanged: (val) => _updateSectionName(index, val),
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.neutralDark,
                                      ),
                                    )
                                : Text(
                                  section['name'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.neutralDark,
                                  ),
                                ),
                            ),
                            if (_isEditing)
                                IconButton(
                                  icon: const Icon(Icons.remove, color: Colors.red),
                                  onPressed: () => _removeSection(index),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                )
                            else
                              TextButton(
                                onPressed: () {
                                  // Action for adding items
                                },
                                child: const Text(
                                  'Add Items',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),

                  // Add New Section Button
                  if (!_isEditing)
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
                                if (_isEditing)
                                   IconButton(
                                    // Tick for finishing edit
                                    icon: const Icon(Icons.check, color: AppColors.neutralDark, size: 28),
                                    onPressed: () => _toggleEditMode(),
                                  )
                                else 
                                  IconButton(
                                  icon: const Icon(Icons.save_outlined, color: AppColors.neutralDark, size: 28),
                                  onPressed: () {
                                    // Save
                                  },
                                ),
                                if (_isEditing)
                                   IconButton(
                                    icon: const Icon(Icons.save_outlined, color: AppColors.neutralDark, size: 28),
                                    onPressed: () {
                                      _toggleEditMode();
                                    },
                                  )
                                else if (_subSections.isNotEmpty)
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined, color: AppColors.neutralDark, size: 28),
                                    onPressed: () => _toggleEditMode(),
                                  ),
                                if (!_isEditing)
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
                 if (_subSections.isNotEmpty) _toggleEditMode();
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.grid_view, color: AppColors.neutral500),
              title: const Text('New Section'),
              onTap: () {
                context.pop();
                _showAddSectionDialog(context);
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
      _addSubSection(result);
    }
  }
}
