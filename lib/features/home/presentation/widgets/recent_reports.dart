import 'package:flutter/material.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

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
            const Text(
              AppStrings.recentReports,
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

        const SizedBox(height: 8),

        _buildReportCard(),
        // Add more cards here if needed
      ],
    );
  }

  Widget _buildReportCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutral300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.apartment,
                      size: 16,
                      color: AppColors.neutralDark,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Service Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutral300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.neutralDark,
                    ),
                    SizedBox(width: 6),
                    Text(
                      '12-12-2025 | 12.00PM',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // User Info
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 20,
                color: AppColors.neutralDark,
              ),
              const SizedBox(width: 8),
              const Text(
                'Jason Johnson',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Location
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 20,
                color: AppColors.neutralDark,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '1005 S Lorem Ipsum, Dolor Dantos, Garylord\nSt Dancer, Co 80209',
                  style: TextStyle(color: AppColors.textBody, fontSize: 13),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Phone
          Row(
            children: [
              const Icon(
                Icons.phone_outlined,
                size: 20,
                color: AppColors.neutralDark,
              ),
              // In design generic icon usually
              const SizedBox(width: 8),
              Text(
                '880 762 233 2234', // Assuming phone number
                style: TextStyle(color: AppColors.textBody, fontSize: 13),
              ),
            ],
          ),

          const SizedBox(height: 16),

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

          const SizedBox(height: 16),
          Divider(color: AppColors.neutral200),
          const SizedBox(height: 8),

          // Footer Row
          Row(
            children: [
              // Price Tag
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.neutral100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.sell_outlined, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '\$550.48',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Status Status Pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Under Review',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Spacer(),

              // Cloud Icon
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFE93D),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Arrow Button
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.neutral200,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: AppColors.neutralDark,
                  size: 20,
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
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 4),
        Icon(
          isChecked ? Icons.check : Icons.close,
          size: 16,
          color: isChecked ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}
