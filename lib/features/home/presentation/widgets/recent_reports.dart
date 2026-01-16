import 'package:flutter/material.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class RecentReports extends StatelessWidget {
  const RecentReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.recentReports,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.neutralDark,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.viewAll,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        _buildReportCard(),
        _buildReportCard(),
      ],
    );
  }

  Widget _buildReportCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Service Name & Date
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutral300),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.apartment,
                      size: 16.w,
                      color: AppColors.neutralDark,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Service Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutral300),
                  borderRadius: BorderRadius.circular(4.w),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16.w,
                      color: AppColors.neutralDark,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '12-12-2025 | 12.00PM',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // User Info
          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 20.w,
                color: AppColors.neutralDark,
              ),
              SizedBox(width: 8.w),
              Text(
                'Jason Johnson',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Location
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20.w,
                color: AppColors.neutralDark,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '1005 S Lorem Ipsum, Dolor Dantos, Garylord\nSt Dancer, Co 80209',
                  style: TextStyle(color: AppColors.neutral800, fontSize: 14.sp),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Phone
          Row(
            children: [
              Icon(
                Icons.phone_outlined,
                size: 20.w,
                color: AppColors.neutralDark,
              ),
              SizedBox(width: 8.w),
              Text(
                '880 762 233 2234',
                style: TextStyle(color: AppColors.textBody, fontSize: 14.sp),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Status Checks
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusCheck('Signed', true),
              _buildStatusCheck('Payment', true),
              _buildStatusCheck('Uploaded', false),
              _buildStatusCheck('Published', false),
            ],
          ),

          SizedBox(height: 16.h),
          Divider(color: AppColors.neutral200),
          SizedBox(height: 8.h),

          // Footer Row
          Row(
            children: [
              // Price Tag
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.neutral100,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sell_outlined, size: 16.w),
                    SizedBox(width: 4.w),
                    Text(
                      '\$550.48',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              // Status Status Pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Text(
                  'Under Review',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Spacer(),

              // Cloud Icon
              Container(
                width: 36.w,
                height: 36.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFE93D),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      color: Colors.black,
                      size: 20.w,
                    ),
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              // Arrow Button
              Container(
                width: 36.w,
                height: 36.w,
                decoration: const BoxDecoration(
                  color: AppColors.neutral200,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: AppColors.neutralDark,
                  size: 20.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCheck(String label, bool isChecked) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(width: 4.w),
        Icon(
          isChecked ? Icons.check : Icons.close,
          size: 16.w,
          color: isChecked ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}
