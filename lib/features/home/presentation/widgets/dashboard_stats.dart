import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class DashboardStats extends StatelessWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(
          svgPath: 'assets/images/svg/pending_payment_icon.svg',
          iconColor: Colors.orange,
          count: '5',
          label: AppStrings.pendingPayment,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          svgPath: 'assets/images/svg/today_icon.svg',
          iconColor: Colors.teal,
          count: '4',
          label: AppStrings.today,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          svgPath: 'assets/images/svg/unsigned_contracts_icon.svg',
          iconColor: Colors.green,
          count: '16',
          label: AppStrings.unsignedContracts,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          svgPath: 'assets/images/svg/submissions_icon.svg',
          iconColor: Colors.blue,
          count: '25',
          label: AppStrings.submissions,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String svgPath,
    required Color iconColor,
    required String count,
    required String label,
  }) {
    return Expanded(
      child: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.neutralWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutralDark.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.neutralDark,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 24,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.textBody,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
