import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SectionDivider extends StatelessWidget {
  final String text;

  const SectionDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        children: [
          const Expanded(child: Divider(color: AppColors.neutral300)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.neutral500,
                fontSize: 12,
              ),
            ),
          ),
          const Expanded(child: Divider(color: AppColors.neutral300)),
        ],
      ),
    );
  }
}
