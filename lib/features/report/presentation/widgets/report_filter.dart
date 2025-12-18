import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ReportFilter extends StatelessWidget {
  const ReportFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildFilterButton('Most Recent', true)),
              const SizedBox(width: 8),
              Expanded(child: _buildFilterButton('Under Review', false)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildFilterButton('Inspection Done', false)),
              const SizedBox(width: 8),
              Expanded(child: _buildFilterButton('Published', false)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildFilterButton('In Progress', false)),
              const SizedBox(width: 8),
              Expanded(child: _buildFilterButton('Oldest', false)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFC8E6C9).withOpacity(0.4) : const Color(0xFFDAEBE1).withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
        border: isSelected ? Border.all(color: AppColors.primary.withOpacity(0.2)) : null,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.neutralDark,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }
}
