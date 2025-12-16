import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.neutralWhite,
      body: Center(
        child: Text(
          'Schedule Page',
          style: TextStyle(color: AppColors.neutralDark),
        ),
      ),
    );
  }
}
