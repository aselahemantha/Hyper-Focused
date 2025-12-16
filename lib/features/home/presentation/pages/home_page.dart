import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/features/home/presentation/widgets/home_header.dart';
import 'package:hyper_focused/features/home/presentation/widgets/dashboard_stats.dart';
import 'package:hyper_focused/features/home/presentation/widgets/upcoming_schedules.dart';
import 'package:hyper_focused/features/home/presentation/widgets/recent_reports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.3, 1.0],
            colors: [
              Color(0xFFE0F7FA), // Very light teal at top
              Color(0xFFF5F5F5), // Light grey middle
              Colors.white,      // White bottom
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                HomeHeader(),
                SizedBox(height: 24),
                DashboardStats(),
                SizedBox(height: 24),
                UpcomingSchedules(),
                SizedBox(height: 24),
                RecentReports(),
                // Add extra padding at bottom for the floating navbar
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
