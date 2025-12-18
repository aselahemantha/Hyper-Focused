import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralWhite,
       body: SafeArea(
        bottom: false,
        child: Center(
          child: Text(
            'Map Page',
            style: TextStyle(color: AppColors.neutralDark),
          ),
        ),
      ),
    );
  }
}
