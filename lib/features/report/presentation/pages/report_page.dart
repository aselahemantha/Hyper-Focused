import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.neutralWhite,
      body: Center(
        child: Text(
          'Report Page',
          style: TextStyle(color: AppColors.neutralDark),
        ),
      ),
    );
  }
}
