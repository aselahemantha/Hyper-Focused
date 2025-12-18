import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isRequired;
  final bool showArrow;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.isRequired = false,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.neutral500),
          const SizedBox(width: 12),
          RichText(
            text: TextSpan(
              text: title,
              style: const TextStyle(
                color: AppColors.neutralDark,
                fontSize: 14,
              ),
              children: [
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.neutral500,
              fontSize: 14,
            ),
          ),
          if (showArrow) ...[
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.neutralDark),
          ],
        ],
      ),
    );
  }
}
