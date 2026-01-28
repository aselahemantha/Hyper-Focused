import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class ReportFilter extends StatefulWidget {
  const ReportFilter({super.key});

  @override
  State<ReportFilter> createState() => _ReportFilterState();
}

class _ReportFilterState extends State<ReportFilter> {
  String _selectedFilter = 'Most Recent';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildFilterButton('Most Recent')),
              SizedBox(width: 8.w),
              Expanded(child: _buildFilterButton('Under Review')),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _buildFilterButton('Inspection Done')),
              SizedBox(width: 8.w),
              Expanded(child: _buildFilterButton('Published')),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _buildFilterButton('In Progress')),
              SizedBox(width: 8.w),
              Expanded(child: _buildFilterButton('Oldest')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text) {
    final isSelected = _selectedFilter == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = text;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.transparency100.withOpacity(0.1) : AppColors.transparency100.withOpacity(0.2),
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
      ),
    );
  }
}
