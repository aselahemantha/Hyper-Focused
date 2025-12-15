import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.neutralDark,
      body: Center(
        child: Text(
          'Plan Page',
          style: TextStyle(color: AppColors.neutralWhite),
        ),
      ),
    );
  }
}
