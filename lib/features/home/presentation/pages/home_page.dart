import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/home/presentation/widgets/home_header.dart';
import 'package:hyper_focused/features/home/presentation/widgets/dashboard_stats.dart';
import 'package:hyper_focused/features/home/presentation/widgets/upcoming_schedules.dart';
import 'package:hyper_focused/features/home/presentation/widgets/recent_reports.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralWhite,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.3, 1.0],
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFF5F5F5),
              AppColors.neutralWhite,
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeader(),
                SizedBox(height: 24.h),
                const DashboardStats(),
                SizedBox(height: 24.h),
                const UpcomingSchedules(),
                SizedBox(height: 24.h),
                const RecentReports(),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
