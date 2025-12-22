import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class ContactStatsCard extends StatelessWidget {
  final String label;
  final String count;
  final IconData icon;
  final bool isSelected;

  const ContactStatsCard({
    super.key,
    required this.label,
    required this.count,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFA0D6CB) : Colors.white, // Selected color matches design
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (!isSelected)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                count,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.neutralDark : AppColors.neutralDark,
                ),
              ),
              Container(
                 padding: const EdgeInsets.all(4),
                 decoration: BoxDecoration(
                     color: isSelected ? AppColors.primary : Colors.grey.withOpacity(0.2),
                     shape: BoxShape.circle,
                 ),
                 child: Icon(icon, size: 16, color: isSelected ? Colors.white : Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: isSelected ? AppColors.neutralDark : AppColors.neutral500,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
