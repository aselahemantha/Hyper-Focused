import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class DashboardStats extends StatelessWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(
          icon: Icons.pending_actions_outlined,
          iconColor: Colors.orange,
          count: '5',
          label: 'Pending\nPayments',
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          icon: Icons.calendar_today_outlined,
          iconColor: Colors.teal,
          count: '4',
          label: 'Today',
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          icon: Icons.assignment_outlined,
          iconColor: Colors.green,
          count: '16',
          label: 'Unsigned\nContracts',
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          icon: Icons.mail_outline,
          iconColor: Colors.blue,
          count: '25',
          label: 'Submissions',
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String count,
    required String label,
  }) {
    return Expanded(
      child: Container(
        height: 110, // Fixed height to keep them uniform
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.neutralDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: AppColors.textBody,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
