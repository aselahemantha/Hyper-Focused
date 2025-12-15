import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.neutralDark,
      body: Center(
        child: Text(
          'Check Page',
          style: TextStyle(color: AppColors.neutralWhite),
        ),
      ),
    );
  }
}
