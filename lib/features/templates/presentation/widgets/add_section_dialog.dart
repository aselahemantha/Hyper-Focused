import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/utils/icon_library.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class AddSectionDialog extends StatefulWidget {
  final bool showIconPicker;
  const AddSectionDialog({super.key, this.showIconPicker = true});

  @override
  State<AddSectionDialog> createState() => _AddSectionDialogState();
}

class _AddSectionDialogState extends State<AddSectionDialog> {
  final TextEditingController _nameController = TextEditingController();
  bool _isIconExpanded = false;
  IconData? _selectedIcon;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.w)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      backgroundColor: AppColors.neutralWhite,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 0.8.h,
        ),
        child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add a New Section',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutralDark,
                  ),
                ),
                SizedBox(height: 16.h),
                
                // Section Name Input
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8.w),
                  ),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Section Name',
                      hintStyle: const TextStyle(color: AppColors.neutral500),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Icon Chooser
                if (widget.showIconPicker) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: _isIconExpanded ? Colors.transparent : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8.w),
                      border: _isIconExpanded 
                        ? Border.all(color: AppColors.primary, width: 1.5)
                        : null,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isIconExpanded = !_isIconExpanded;
                            });
                          },
                          borderRadius: BorderRadius.circular(8.w),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _selectedIcon == null ? 'Choose a Icon (Optional)' : 'Icon Selected',
                                  style: TextStyle(
                                    color: AppColors.neutral500,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                Icon(
                                  _isIconExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  color: AppColors.neutralDark,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                if (widget.showIconPicker && _isIconExpanded) ...[
                  SizedBox(height: 8.h),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      padding: EdgeInsets.all(16.w),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: IconLibrary.categories.length,
                        itemBuilder: (context, index) {
                          final category = IconLibrary.categories[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (index > 0) SizedBox(height: 24.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    category.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      color: AppColors.neutralDark,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.neutral200,
                                      borderRadius: BorderRadius.circular(12.w),
                                    ),
                                    child: Text(
                                      '${category.icons.length}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.neutralDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 12.h,
                                  crossAxisSpacing: 12.w,
                                  childAspectRatio: 1, // Square tiles
                                ),
                                itemCount: category.icons.length,
                                itemBuilder: (context, iconIndex) {
                                  final item = category.icons[iconIndex];
                                  final isSelected = _selectedIcon == item.icon;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedIcon = item.icon;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.neutralWhite,
                                        borderRadius: BorderRadius.circular(8.w),
                                        border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(item.icon, color: AppColors.neutralDark, size: 24.w),
                                          SizedBox(height: 8.h),
                                          Text(
                                            item.label,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: AppColors.neutralDark,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],

                SizedBox(height: 24.h),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
                          side: const BorderSide(color: AppColors.neutral200),
                        ),
                        child: const Text('Cancel', style: TextStyle(color: AppColors.neutralDark)),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_nameController.text.isNotEmpty) {
                            Navigator.pop(context, {
                              'name': _nameController.text,
                              'icon': _selectedIcon,
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
                        ),
                        child: const Text('Add', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}
