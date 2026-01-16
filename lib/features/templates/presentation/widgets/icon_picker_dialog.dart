import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/templates/presentation/utils/icon_library.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class IconPickerDialog extends StatefulWidget {
  final IconData? currentIcon;

  const IconPickerDialog({super.key, this.currentIcon});

  @override
  State<IconPickerDialog> createState() => _IconPickerDialogState();
}

class _IconPickerDialogState extends State<IconPickerDialog> {
  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.currentIcon;
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
                'Choose a Icon',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.neutralDark,
                ),
              ),
              SizedBox(height: 16.h),
              Flexible(
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
                            childAspectRatio: 1,
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
                                // Auto-close on selection could be an option, but design likely implies selection then confirmation?
                                // User request: "if i click the icon infront of the section, it should pop up the icon picker"
                                // Assume immediate selection return or manual close. 
                                // To act like a picker, let's select and return.
                                Navigator.pop(context, item.icon);
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
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel', style: TextStyle(color: AppColors.neutral500)),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
