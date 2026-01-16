import 'package:flutter/material.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class UpcomingSchedules extends StatelessWidget {
  const UpcomingSchedules({super.key});

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
              AppStrings.upcomingSchedules,
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

        SizedBox(height: 12.h),

        // Horizontal List
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildScheduleCard(
                imageUrl: 'assets/images/property_placeholder_1.jpg',
                name: 'Emma W.',
                service: 'Cleaning Services',
                date: '12th December 2025',
                time: '8.00AM - 12.00PM',
                isFirst: true,
              ),
              SizedBox(width: 16.w),
              _buildScheduleCard(
                imageUrl: 'assets/images/property_placeholder_2.jpg',
                name: 'Olivia R.',
                service: 'Maintenance',
                date: '12th December 2025',
                time: '8.00PM - 12.00AM',
                isFirst: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildScheduleCard({
    required String imageUrl,
    required String name,
    required String service,
    required String date,
    required String time,
    required bool isFirst,
  }) {
    // Dimensions
    double imageHeight = 170.h;
    double cardHeight = 230.h;

    return Container(
      width: 320.w,
      height: cardHeight,
      margin: EdgeInsets.only(right: 16.w),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Image Area
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: imageHeight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.w),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neutralDark.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Gradient Overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.w),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Text Overlay (Name & Service)
                  Positioned(
                    left: 20.w,
                    right: 20.w,
                    bottom: 40.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: AppColors.neutralWhite,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          service,
                          style: TextStyle(
                            color: AppColors.neutralWhite,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Details Capsule
          Positioned(
            bottom: 10.h,
            left: 12.w,
            right: 12.w,
            child: Container(
              constraints: BoxConstraints(minHeight: 70.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.neutralWhite,
                borderRadius: BorderRadius.circular(40.w),
                border: Border.all(
                  color: const Color(0xFF29B6F6),
                  width: 1,
                  style: BorderStyle.none,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neutralDark.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.calendar_month,
                      color: AppColors.neutralDark,
                      size: 22.w,
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Date & Time
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: AppColors.neutralDark,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.neutral500,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arrow Button
                  SizedBox(width: 8.w),
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: AppColors.neutral200.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_outward,
                      size: 22.w,
                      color: AppColors.neutralDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
