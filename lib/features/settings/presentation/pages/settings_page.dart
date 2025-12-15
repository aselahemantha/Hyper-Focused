import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.neutralDark,
      body: Center(
        child: Text(
          'Settings Page',
          style: TextStyle(color: AppColors.neutralWhite),
        ),
      ),
    );
  }
}
