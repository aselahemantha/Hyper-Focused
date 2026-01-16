import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/add_section_dialog.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/icon_picker_dialog.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';
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
          padding: EdgeInsets.only(left: 16.w),
          child: CircleAvatar(
            backgroundColor: AppColors.neutralWhite,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 18.w, color: AppColors.neutralDark),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        title: Column(
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.neutralDark,
                ),
                children: [
                  const TextSpan(text: 'Create a New Template '),
                  WidgetSpan(
                    child: Icon(Icons.arrow_forward, size: 12.w, color: AppColors.neutralDark),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(text: ' Step 2'),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: AppColors.neutralDark,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(text: 'Main Categories '),
                  WidgetSpan(
                    child: Icon(Icons.keyboard_arrow_right, size: 20.w, color: AppColors.neutralDark),
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
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 14.w,
              child: Icon(Icons.info_outline, color: Colors.white, size: 18.w),
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
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
                children: [
                  Text(
                    'You can manage your services here. These services will be shown on your website.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.neutral500,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  // General Info Item
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.neutral500),
                        SizedBox(width: 12.w),
                        Text(
                          'General Info (Default)',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.neutralDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  // User Added Sub-Sections
                  ..._subSections.asMap().entries.map((entry) {
                    final index = entry.key;
                    final section = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: AppColors.neutralWhite,
                          borderRadius: BorderRadius.circular(12.w),
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
                            SizedBox(width: 12.w),
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
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.neutralDark,
                                      ),
                                    )
                                : Text(
                                  section['name'] ?? '',
                                  style: TextStyle(
                                    fontSize: 16.sp,
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
                                  context.push(
                                    '/create-template/step-2/sub-sections/items',
                                    extra: {
                                      'categoryName': widget.categoryName,
                                      'subCategoryName': section['name'],
                                    },
                                  );
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
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      decoration: BoxDecoration(
                        color: AppColors.neutralWhite.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.w),
                        border: Border.all(
                          color: AppColors.neutral100,
                          style: BorderStyle.solid, 
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Click to add a New Section',
                          style: TextStyle(
                            color: AppColors.neutral500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              // Bottom Bar
              Positioned(
                bottom: 24.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35.h),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 70.w,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            decoration: BoxDecoration(
                              color: AppColors.neutralWhite.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(35.h),
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
                                  icon: Icon(Icons.arrow_back, color: AppColors.neutralDark, size: 28.w),
                                  onPressed: () => context.pop(),
                                ),
                                if (_isEditing)
                                   IconButton(
                                    // Tick for finishing edit
                                    icon: Icon(Icons.check, color: AppColors.neutralDark, size: 28.w),
                                    onPressed: () => _toggleEditMode(),
                                  )
                                else 
                                  IconButton(
                                  icon: Icon(Icons.save_outlined, color: AppColors.neutralDark, size: 28.w),
                                  onPressed: () {
                                    // Save
                                  },
                                ),
                                if (_isEditing)
                                   IconButton(
                                    icon: Icon(Icons.save_outlined, color: AppColors.neutralDark, size: 28.w),
                                    onPressed: () {
                                      _toggleEditMode();
                                    },
                                  )
                                else if (_subSections.isNotEmpty)
                                  IconButton(
                                    icon: Icon(Icons.edit_outlined, color: AppColors.neutralDark, size: 28.w),
                                    onPressed: () => _toggleEditMode(),
                                  ),
                                if (!_isEditing)
                                IconButton(
                                  icon: Icon(Icons.add, color: AppColors.neutralDark, size: 28.w),
                                  onPressed: () => _showAddSectionDialog(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: () => _showMenuModal(context),
                      child: Container(
                        width: 70.w,
                        height: 70.w,
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
                        child: Icon(Icons.menu, color: AppColors.neutralDark, size: 30.w),
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
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.w),
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
