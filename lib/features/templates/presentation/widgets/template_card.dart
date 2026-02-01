import 'package:flutter/material.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class TemplateCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onExport;
  final VoidCallback onEdit;

  const TemplateCard({
    super.key,
    required this.title,
    required this.description,
    required this.onExport,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutralDark.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.neutralDark,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textBody,
              height: 1.4,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onExport,
                  icon: Icon(Icons.upload_file, size: 16.w),
                  label: Text(
                    AppStrings.exportTemplate,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.neutral200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onEdit,
                  icon: Icon(Icons.edit_outlined, size: 16.w),
                  label: Text(
                    AppStrings.editTemplate,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.neutral200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
