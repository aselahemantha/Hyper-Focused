import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class EditTemplatePage extends StatelessWidget {
  const EditTemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.neutralDark),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Edit Template',
          style: TextStyle(
            color: AppColors.neutralDark,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Edit Template Placeholder'),
      ),
    );
  }
}
