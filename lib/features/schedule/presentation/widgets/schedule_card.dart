import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../domain/entities/schedule_entity.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleEntity schedule;

  const ScheduleCard({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(16.w),
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
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
                child: Image.asset(
                  schedule.imageUrl,
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180.h,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, size: 50.w, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                bottom: 12.h,
                left: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Text(
                    schedule.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12.h,
                right: 12.w,
                child: Row(
                  children: [
                    _buildActionButton(
                      Icons.phone_outlined,
                      AppColors.secondary,
                      AppColors.neutralDark,
                    ),
                    SizedBox(width: 8.w),
                    _buildActionButton(
                      Icons.cloud_upload_outlined,
                      AppColors.neutralWhite,
                      Colors.black,
                      showBadge: true,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Info Chips
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoChip(
                        Icons.alarm,
                        '${schedule.startTime} - ${schedule.endTime}',
                        AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: _buildInfoChip(
                        Icons.business,
                        schedule.serviceName,
                        AppColors.textBody,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Person
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: AppColors.neutralDark,
                      size: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      schedule.personName,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
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
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.textBody,
                      size: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        schedule.address,
                        style: TextStyle(
                          color: AppColors.textBody,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Tags
                // Tags
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: [
                    _buildStatusTag('Signed', schedule.isSigned),
                    _buildStatusTag('Payment', schedule.isPaymentCompleted),
                    _buildStatusTag('Uploaded', schedule.isUploaded),
                    _buildStatusTag('Published', schedule.isPublished),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    Color bg,
    Color iconColor, {
    bool showBadge = false,
  }) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 20.w),
        ),
        if (showBadge)
          Container(
            margin: EdgeInsets.only(top: 0, right: 0),
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: AppColors.statusNotify,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.w, color: color),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(String label, bool isSuccess) {
    final color = isSuccess ? AppColors.successLight : AppColors.errorLight;
    final iconColor = isSuccess ? AppColors.success : AppColors.error;
    final icon = isSuccess ? Icons.check : Icons.close;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.neutral800, fontSize: 12.sp),
          ),
          SizedBox(width: 4.w),
          Icon(icon, size: 14.w, color: iconColor),
        ],
      ),
    );
  }
}
