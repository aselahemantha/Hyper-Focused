import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class ApprovedPage extends StatelessWidget {
  const ApprovedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.neutralDark,
      body: Center(
        child: Text(
          'Approved Page',
          style: TextStyle(color: AppColors.neutralWhite),
        ),
      ),
    );
  }
}
