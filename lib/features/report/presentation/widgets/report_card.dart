import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(16),
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
              const SizedBox(width: 8),
              _buildHeaderChip(Icons.access_time, '12-12-2025 | 12.00PM'),
            ],
          ),
          const SizedBox(height: 12),

          // Person
          Row(
            children: [
              const Icon(Icons.person_outline, size: 20, color: AppColors.neutralDark),
              const SizedBox(width: 8),
              const Text(
                'Jason Johnson',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.neutralDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, size: 20, color: AppColors.textBody),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '1005 S Lorem Ipsum, Dolor Dantos, Garylord St Dancer, Co 80209',
                  style: TextStyle(
                    color: AppColors.textBody,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Phone
          Row(
            children: [
              const Icon(Icons.phone_outlined, size: 18, color: AppColors.textBody),
              const SizedBox(width: 8),
              Text(
                '880 762 233 2234',
                style: TextStyle(
                  color: AppColors.textBody,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Status Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStatusTag('Signed', true),
              _buildStatusTag('Payment', true),
              _buildStatusTag('Uploaded', false),
              _buildStatusTag('Published', false),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.neutral200),
          const SizedBox(height: 16),

          // Footer
          Row(
            children: [
              // Price Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.neutral100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.sell_outlined, size: 16, color: Colors.black87),
                    SizedBox(width: 4),
                    Text(
                      '\$550.48',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Status Outline
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.statusNotify),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Under Review',
                  style: TextStyle(
                    color: AppColors.statusNotify,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),

              // Action Icons
              _buildCircleIcon(Icons.cloud_upload_outlined, AppColors.secondary, showDot: true),
              const SizedBox(width: 8),
              _buildCircleIcon(Icons.arrow_forward, AppColors.neutral200, showDot: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.black87),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
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
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 2),
          Icon(icon, size: 14, color: iconColor),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(IconData icon, Color bgColor, {bool showDot = false}) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: Colors.black87),
        ),
        if (showDot)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 10,
              height: 10,
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
