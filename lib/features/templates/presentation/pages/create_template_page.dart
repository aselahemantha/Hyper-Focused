import 'dart:ui'; // Add import for ImageFilter

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class CreateTemplatePage extends StatelessWidget {
  const CreateTemplatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: CircleAvatar(
            backgroundColor: AppColors.neutralWhite,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, size: 18.w, color: AppColors.neutralDark),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        title: Column(
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.neutralDark,
                ),
                children: [
                  const TextSpan(text: 'Create a New Template '),
                  WidgetSpan(
                    child: Icon(Icons.arrow_forward, size: 12.w, color: AppColors.neutralDark),
                    alignment: PlaceholderAlignment.middle,
                  ),
                  const TextSpan(text: ' Step 1'),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Template Information',
              style: TextStyle(
                color: AppColors.neutralDark,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 14.w,
              child: Icon(Icons.info_outline, color: Colors.white, size: 18.w),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.3, 1.0],
            colors: [
              Color(0xFFE0F7FA), // Light cyan/blue at top
              Color(0xFFF5F5F5), // Fade to white-ish
              Color(0xFFF5F5F5),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
                children: [
                  // Primary Details Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Primary Details',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.neutralDark,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildTextField('Template Name'),
                        SizedBox(height: 12.h),
                        _buildTextField('Description'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  // Defect Categories Card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.neutralWhite,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Defect Categories (Names)',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.neutralDark,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'You can manage your services here. These services will be shown on your website.',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.neutral500,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _buildCategoryItem(Icons.style_outlined, 'Default - Monitor', Colors.blue),
                        SizedBox(height: 12.h),
                        _buildCategoryItem(Icons.handyman_outlined, 'Default - Deficiency', Colors.orange),
                        SizedBox(height: 12.h),
                        _buildCategoryItem(Icons.warning_amber_rounded, 'Default - Priority', Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
              
              
              // Bottom Bar
              Positioned(
                bottom: 24.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35.w), // Rounded capsule
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 70.h, // Match design height
                            padding: EdgeInsets.symmetric(horizontal: 24.w), // Adjust padding
                            decoration: BoxDecoration(
                              color: AppColors.neutralWhite.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(35.w),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.neutralDark.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back, color: AppColors.neutralDark, size: 28.w),
                                  onPressed: () => context.pop(),
                                ),
                                IconButton(
                                  icon: Icon(Icons.save_outlined, color: AppColors.neutralDark, size: 28.w),
                                  onPressed: () {
                                    // Save placeholder
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    GestureDetector(
                      onTap: () {
                        context.push('/create-template/step-2');
                      },
                      child: Container(
                        width: 70.w,
                        height: 70.w,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Icon(Icons.arrow_forward, color: Colors.white, size: 30.w),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.neutral500),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String title, Color iconColor) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24.w),
          SizedBox(width: 16.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.neutralDark,
            ),
          ),
        ],
      ),
    );
  }
}
