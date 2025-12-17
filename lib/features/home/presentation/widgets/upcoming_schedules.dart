import 'package:flutter/material.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

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
            const Text(
              AppStrings.upcomingSchedules,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.neutralDark,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                AppStrings.viewAll,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

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
              const SizedBox(width: 16),
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
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.neutralDark.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image Area with Overlay Text
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
              color: AppColors.neutral200,
            ),
            child: Stack(
              children: [
                // Gradient overlay for text visibility
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
                // Text Overlay
                Positioned(
                  bottom: 12,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: AppColors.neutralWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        service,
                        style: const TextStyle(
                          color: AppColors.neutralWhite,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Details Area
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.calendar_month,
                    color: AppColors.neutralDark,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),

                // Date & Time
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.neutralDark,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textBody,
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow Button
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_outward,
                    size: 18,
                    color: AppColors.neutralDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
