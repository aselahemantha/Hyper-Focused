import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          // Image Section
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  'assets/images/property_placeholder_1.jpg',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.home, size: 50, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'In Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: Row(
                  children: [
                    _buildActionButton(Icons.phone, AppColors.secondary, Colors.black),
                    const SizedBox(width: 8),
                    _buildActionButton(Icons.cloud_upload_outlined, AppColors.neutralWhite, Colors.black, showBadge: true),
                  ],
                ),
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Info Chips
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoChip(
                        Icons.access_time, 
                        '8.00AM - 12.00PM', 
                        AppColors.primary
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildInfoChip(
                        Icons.business, 
                        'Service Name Length', 
                        AppColors.textBody
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Person
                Row(
                  children: [
                    const Icon(Icons.person_outline, color: AppColors.neutralDark),
                    const SizedBox(width: 8),
                    const Text(
                      'Jason Johnson',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
                    const Icon(Icons.location_on_outlined, color: AppColors.textBody, size: 20),
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
                const SizedBox(height: 16),

                // Tags
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color bg, Color iconColor, {bool showBadge = false}) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        if (showBadge)
          Container(
            margin: const EdgeInsets.only(top: 0, right: 0),
            width: 10,
            height: 10,
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
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
    final color = isSuccess ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);
    final iconColor = isSuccess ? Colors.green : Colors.red;
    final icon = isSuccess ? Icons.check : Icons.close;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          Icon(icon, size: 14, color: iconColor),
        ],
      ),
    );
  }
}
