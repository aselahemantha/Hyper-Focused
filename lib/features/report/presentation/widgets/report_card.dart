import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';
import '../../../../core/theme/app_colors.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(16.w),
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
          // Header Chips
          Row(
            children: [
              _buildHeaderChip(Icons.business, 'Service Name'),
              SizedBox(width: 8.w),
              _buildHeaderChip(Icons.access_time, '12-12-2025 | 12.00PM'),
            ],
          ),
          SizedBox(height: 12.h),

          // Person
          Row(
            children: [
              Icon(Icons.person_outline, size: 20.w, color: AppColors.neutralDark),
              SizedBox(width: 8.w),
              Text(
                'Jason Johnson',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: AppColors.neutralDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on_outlined, size: 20.w, color: AppColors.textBody),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  '1005 S Lorem Ipsum, Dolor Dantos, Garylord St Dancer, Co 80209',
                  style: TextStyle(
                    color: AppColors.textBody,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Phone
          Row(
            children: [
              Icon(Icons.phone_outlined, size: 18.w, color: AppColors.textBody),
              SizedBox(width: 8.w),
              Text(
                '880 762 233 2234',
                style: TextStyle(
                  color: AppColors.textBody,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Status Tags
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildStatusTag('Signed', true),
              _buildStatusTag('Payment', true),
              _buildStatusTag('Uploaded', false),
              _buildStatusTag('Published', false),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(height: 1, color: AppColors.neutral200),
          SizedBox(height: 16.h),

          // Footer
          Row(
            children: [
              // Price Tag
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.neutral100,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sell_outlined, size: 16.w, color: Colors.black87),
                    SizedBox(width: 4.w),
                    Text(
                      '\$550.48',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),

              // Status Outline
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.statusNotify),
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Text(
                  'Under Review',
                  style: TextStyle(
                    color: AppColors.statusNotify,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),

              // Action Icons
              _buildCircleIcon(Icons.cloud_upload_outlined, AppColors.secondary, showDot: true),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => context.push('/report-detail'),
                child: _buildCircleIcon(Icons.arrow_forward, AppColors.neutral200, showDot: false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.w, color: Colors.black87),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(String label, bool isSuccess) {
    final color = isSuccess ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);
    final iconColor = isSuccess ? Colors.green : Colors.red;
    final icon = isSuccess ? Icons.check : Icons.close;

    return Container(
      height: 24.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 2.w),
          Icon(icon, size: 14.w, color: iconColor),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, Color bgColor, {bool showDot = false}) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18.w, color: Colors.black87),
        ),
        if (showDot)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: AppColors.statusNotify,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
