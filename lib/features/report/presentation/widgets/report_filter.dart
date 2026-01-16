import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class ReportFilter extends StatelessWidget {
  const ReportFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildFilterButton('Most Recent', true)),
              SizedBox(width: 8.w),
              Expanded(child: _buildFilterButton('Under Review', false)),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _buildFilterButton('Inspection Done', false)),
              SizedBox(width: 8.w),
              Expanded(child: _buildFilterButton('Published', false)),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _buildFilterButton('In Progress', false)),
              SizedBox(width: 8.w),
              Expanded(child: _buildFilterButton('Oldest', false)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFC8E6C9).withOpacity(0.4) : const Color(0xFFDAEBE1).withOpacity(0.5),
        borderRadius: BorderRadius.circular(4.w),
        border: isSelected ? Border.all(color: AppColors.primary.withOpacity(0.2)) : null,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.neutralDark,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
