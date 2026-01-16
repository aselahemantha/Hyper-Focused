import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

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
        SizedBox(width: 12.w),
        _buildStatCard(
          svgPath: 'assets/images/svg/today_icon.svg',
          iconColor: Colors.teal,
          count: '4',
          label: AppStrings.today,
        ),
        SizedBox(width: 12.w),
        _buildStatCard(
          svgPath: 'assets/images/svg/unsigned_contracts_icon.svg',
          iconColor: Colors.green,
          count: '16',
          label: AppStrings.unsignedContracts,
        ),
        SizedBox(width: 12.w),
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
        height: 110.h,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: AppColors.neutralWhite,
          borderRadius: BorderRadius.circular(16.w),
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
              width: 24.w,
              height: 24.w,
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              count,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.neutralDark,
              ),
            ),
            SizedBox(height: 4.h),
            SizedBox(
              height: 24.h,
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.sp,
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
