import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/add_section_dialog.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class InspectionSectionPage extends StatefulWidget {
  final String categoryName;
  const InspectionSectionPage({super.key, required this.categoryName});

  @override
  State<InspectionSectionPage> createState() => _InspectionSectionPageState();
}

class _InspectionSectionPageState extends State<InspectionSectionPage> {
  bool _isEditing = false;
  
  // Dummy data for sections - this would ideally come from the category or backend
  final List<Map<String, dynamic>> _sections = [
    {'icon': Icons.info_outline, 'name': 'General Info', 'pins': null},
    {'icon': Icons.chair_outlined, 'name': 'Living Room', 'pins': null},
    {'icon': Icons.kitchen_outlined, 'name': 'Kitchen', 'pins': null},
    {'icon': Icons.bed_outlined, 'name': 'Master Bedroom', 'pins': 1},
    {'icon': Icons.bed_outlined, 'name': 'Bedroom 1', 'pins': 2},
    {'icon': Icons.bed_outlined, 'name': 'Bedroom 2', 'pins': 2},
    {'icon': Icons.bed_outlined, 'name': 'Bedroom 3', 'pins': null},
  ];

  Future<void> _showAddSectionDialog(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const AddSectionDialog(),
    );

    if (result != null) {
      setState(() {
        _sections.add({
          'icon': result['icon'] ?? Icons.folder_outlined,
          'name': result['name'],
          'pins': null,
        });
      });
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _removeSection(int index) {
    setState(() {
      _sections.removeAt(index);
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = _sections.removeAt(oldIndex);
      _sections.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Stack(
        children: [
          // Background Gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300.h,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green.withOpacity(0.05),
                    const Color(0xFFF9FAFB),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: _isEditing
                      ? ReorderableListView.builder(
                          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 120.h),
                          itemCount: _sections.length,
                          onReorder: _onReorder,
                          header: _buildListHeader(),
                          proxyDecorator: (child, index, animation) {
                            return AnimatedBuilder(
                              animation: animation,
                              builder: (BuildContext context, Widget? child) {
                                return Material(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  child: child,
                                );
                              },
                              child: child,
                            );
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              key: ValueKey(_sections[index]),
                              margin: EdgeInsets.only(bottom: 12.h),
                              child: _buildSectionItem(_sections[index], index: index),
                            );
                          },
                        )
                      : ListView(
                          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 120.h),
                          children: [
                            _buildListHeader(),
                            ..._sections.map((section) => Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              child: _buildSectionItem(section),
                            )),
                            SizedBox(height: 24.h),
                            _buildActionButton(
                              context: context,
                              label: 'Add a new section',
                              bgColor: AppColors.primary,
                              textColor: Colors.white,
                              onTap: () => _showAddSectionDialog(context),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
          
          if (!_isEditing)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomActionBar(context),
          ),

          if (_isEditing)
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 32.h,
              child: SafeArea(
                child: _buildActionButton(
                   context: context,
                   label: 'Save Changes',
                   bgColor: AppColors.primary,
                   textColor: Colors.white,
                   onTap: _toggleEditMode,
                 ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                     boxShadow: [
                       BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.black87, size: 20.w),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inspection Details',
                    style: TextStyle(
                      color: AppColors.neutral500,
                      fontSize: 12.sp,
                    ),
                  ),
                  Text(
                    widget.categoryName,
                    style: TextStyle(
                      color: AppColors.neutralDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(2.w), // Black circle border effect
            decoration: const BoxDecoration(
              color: Colors.black, 
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.info_outline, color: Colors.white, size: 20.w),
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _isEditing 
          ? Text(
                'Edit Sections',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.neutralDark),
              )
          : Row(
            children: [
               Icon(Icons.grid_on_outlined, size: 20.w, color: AppColors.neutral500),
               SizedBox(width: 8.w),
               Text(
                'Sections',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.neutralDark),
              ),
            ],
          ),
          TextButton(
            onPressed: _toggleEditMode,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              _isEditing ? 'Save Changes' : 'Edit Sections',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionItem(Map<String, dynamic> section, {int? index}) {
    final pins = section['pins'] as int?;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Row(
        children: [
           if (_isEditing)
            ReorderableDragStartListener(
              index: index!,
              child: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: const Icon(Icons.menu, color: AppColors.neutral500),
              ),
            ),
          Icon(section['icon'] as IconData, color: AppColors.neutral500, size: 24.w),
          SizedBox(width: 16.w),
          Expanded(
            child: GestureDetector(
              onTap: _isEditing ? null : () {
                 context.push(
                  '/inspection-item', 
                  extra: {
                    'categoryName': widget.categoryName,
                    'sectionName': section['name'],
                  },
                );
              },
              behavior: HitTestBehavior.translucent,
              child: Text(
                section['name'] as String,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralDark,
                ),
              ),
            ),
          ),
          if (!_isEditing) ...[
            GestureDetector(
              onTap: () {
                 context.push(
                  '/inspection-item', 
                  extra: {
                    'categoryName': widget.categoryName,
                    'sectionName': section['name'],
                  },
                );
              },
              behavior: HitTestBehavior.translucent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (pins != null) ...[
                    Icon(Icons.push_pin_outlined, size: 16.w, color: AppColors.primary),
                    SizedBox(width: 4.w),
                    Text(
                      '$pins ${pins == 1 ? 'Pin' : 'Pins'}',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 12.w),
                  ],
                  Icon(Icons.arrow_forward_ios, size: 16.w, color: AppColors.neutralDark),
                ],
              ),
            ),
          ] else 
            GestureDetector(
              onTap: () => _removeSection(index!),
              child: Container(
                width: 24.w, 
                height: 2.h, 
                color: Colors.red,
              ),
            )
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
    bool isOutline = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.w),
          border: isOutline ? Border.all(color: AppColors.primary) : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

   Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Capsule Container
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.w),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 72.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(50.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildIcon(Icons.arrow_back),
                      // Cloud upload with red dot
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.cloud_upload_outlined, color: Colors.black87, size: 24.w),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: BoxDecoration(
                                  color: AppColors.statusNotify,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 1.5.w),
                                ),
                              ),
                            ),
                        ],
                      ),
                      _buildIcon(Icons.flashlight_on_outlined),
                      _buildIcon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          
          // FAB like icon (Menu)
          GestureDetector(
            onTap: () => _showMenuModal(context),
            child: Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                 boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
              ),
              child: Icon(Icons.menu, color: Colors.black87, size: 28.w),
            ),
          ),
        ],
      ),
    );
  }

  void _showMenuModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h), // Adjust bottom margin to sit above bottom bar if needed, or just standard
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
              title: Text(
                'Edit Sections',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralDark,
                ),
              ),
              onTap: () {
                context.pop();
                _toggleEditMode();
              },
            ),
            const Divider(height: 1, color: AppColors.neutral100),
            ListTile(
              leading: const Icon(Icons.grid_view_outlined, color: AppColors.neutral500), // Using grid_view_outlined to match "New Section" idea (or create_new_folder)
              title: Text(
                'New Section',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralDark,
                ),
              ),
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

  Widget _buildIcon(IconData icon) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, color: Colors.black87, size: 24.w),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}
