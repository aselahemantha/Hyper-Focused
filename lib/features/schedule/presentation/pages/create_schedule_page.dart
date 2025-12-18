import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class CreateSchedulePage extends StatelessWidget {
  const CreateSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Schedule'),
        backgroundColor: AppColors.neutralWhite,
        foregroundColor: AppColors.neutralDark,
        elevation: 0,
      ),
      backgroundColor: AppColors.neutralWhite,
      body: const Center(
        child: Text('Create Schedule Screen'),
      ),
    );
  }
}
