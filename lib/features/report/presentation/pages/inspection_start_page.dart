import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/widgets/add_section_dialog.dart';

class InspectionStartPage extends StatefulWidget {
  const InspectionStartPage({super.key});

  @override
  State<InspectionStartPage> createState() => _InspectionStartPageState();
}

class _InspectionStartPageState extends State<InspectionStartPage> {
  bool _isEditing = false;
  // Dummy data for categories - converted to a state variable
  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.info_outline, 'name': 'General Info', 'pins': null},
    {'icon': Icons.chair_outlined, 'name': 'Interior', 'pins': 3},
    {'icon': Icons.grid_view, 'name': 'Exterior', 'pins': null},
    {'icon': Icons.garage_outlined, 'name': 'Garage', 'pins': 3},
    {'icon': Icons.pool_outlined, 'name': 'Pool', 'pins': null},
    {'icon': Icons.hvac, 'name': 'Heating', 'pins': 5},
    {'icon': Icons.nature_people_outlined, 'name': 'Roof', 'pins': 2},
    {'icon': Icons.park_outlined, 'name': 'Garden', 'pins': null},
    {'icon': Icons.water_drop_outlined, 'name': 'Plumbing', 'pins': null},
    {'icon': Icons.local_fire_department_outlined, 'name': 'Fireplace', 'pins': null},
    {'icon': Icons.fence_outlined, 'name': 'Gate', 'pins': null},
  ];

  Future<void> _showAddSectionDialog(BuildContext context) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const AddSectionDialog(),
    );

    if (result != null) {
      setState(() {
        _categories.add({
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

  void _removeCategory(int index) {
    setState(() {
      _categories.removeAt(index);
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = _categories.removeAt(oldIndex);
      _categories.insert(newIndex, item);
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
            height: 300,
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
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                          itemCount: _categories.length,
                          onReorder: _onReorder,
                          header: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Edit Sections',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.neutralDark,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: _toggleEditMode,
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      'Save Changes',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                              key: ValueKey(_categories[index]),
                              margin: const EdgeInsets.only(bottom: 12),
                              child: _buildCategoryItem(_categories[index], index: index),
                            );
                          },
                        )
                      : ListView(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Main Categories',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.neutralDark,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: _toggleEditMode,
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text(
                                      'Edit Sections',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ..._categories.map((category) => Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: _buildCategoryItem(category),
                            )),
                            const SizedBox(height: 24),
                            _buildActionButton(
                              context: context,
                              label: 'Add a new section',
                              bgColor: AppColors.primary,
                              textColor: Colors.white,
                              onTap: () => _showAddSectionDialog(context),
                            ),
                            const SizedBox(height: 12),
                            _buildActionButton(
                              context: context,
                              label: 'Save as a new template',
                              bgColor: const Color(0xFFE0F2F1),
                              textColor: AppColors.primary,
                              onTap: () {},
                              isOutline: true,
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
              left: 16,
              right: 16,
              bottom: 32,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
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
                  child: const Icon(Icons.arrow_back, color: Colors.black87, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Residential Inspection',
                    style: TextStyle(
                      color: AppColors.neutral500,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'John Johnson | 12.12.2025',
                    style: TextStyle(
                      color: AppColors.neutralDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(2), // Black circle border effect
            decoration: const BoxDecoration(
              color: Colors.black, 
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.info_outline, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category, {int? index}) {
    final pins = category['pins'] as int?;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
           if (_isEditing)
            ReorderableDragStartListener(
              index: index!,
              child: const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.menu, color: AppColors.neutral500),
              ),
            ),
          Icon(category['icon'] as IconData, color: AppColors.neutral500, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              category['name'] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.neutralDark,
              ),
            ),
          ),
          if (!_isEditing) ...[
            if (pins != null) ...[
              const Icon(Icons.push_pin_outlined, size: 16, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                '$pins Pins',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
            ],
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.neutralDark),
          ] else 
            GestureDetector(
              onTap: () => _removeCategory(index!),
              child: Container(
                width: 24, 
                height: 2, 
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: isOutline ? Border.all(color: AppColors.primary) : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

   Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Capsule Container
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 72,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIcon(Icons.grid_view, isSelected: true),
                      _buildIcon(Icons.assignment_outlined), // Clipboard icon
                       // Cloud upload with red dot
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(Icons.cloud_upload_outlined, color: Colors.black87, size: 24),
                             Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: AppColors.statusNotify,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 1.5),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      _buildIcon(Icons.edit_outlined), // Edit icon
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // FAB like icon (Menu)
          Container(
            width: 72,
            height: 72,
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
            child: const Icon(Icons.menu, color: Colors.black87, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, {bool isSelected = false}) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, color: Colors.black87, size: 24),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}
