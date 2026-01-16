import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // Router redirect logic will handle where to go (Landing or Home)
        // We just need to trigger a report or go to a route that redirects.
        // Since initialLocation in router might be splash, we need to explicitly go.
        // However, usually Splash screens are handled by checking auth state.
        // For simplicity with go_router redirects, we can just context.go('/landing');
        // and the redirect logic in router will send to Home if logged in.
        
        context.go('/landing'); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEFE93D), // Yellowish Green
              Color(0xFF00AA88), // Primary Green
            ],
            // Adjust stops or angle to match the curved look if possible, 
            // but standard linear gradient is requested for now.
            // The image shows a curved overlay, which might be an image background or complex shape.
            // For now we use a gradient + potentially an image asset if user provided one for BG.
            // User said "Create splash screen like this. The image can add by me." which likely refers to the LOGO.
            // But the background has curves. I will use a gradient for now.
          ),
        ),
        child: Stack(
          children: [
             // Center Content
             Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   // Logo
                   // Placeholder for user's logo or existing one
                   Image.asset(
                     'assets/images/logo_full.png', // Assuming a full logo exists or use the one we saw before
                     height: 120.h, // Adjust size
                     errorBuilder: (context, error, stackTrace) => Column(
                       children: [
                         Icon(Icons.inventory_2_outlined, size: 80.w, color: Colors.white), // Placeholder icon
                         SizedBox(height: 16.h),
                         // If image fails, show text logic here or just the text below
                       ],
                     ),
                   ),
                   SizedBox(height: 16.h),
                   Text(
                     AppStrings.appTitle,
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: const Color(0xFF005544), // Darker green text based on image
                       fontSize: 32.sp,
                       fontWeight: FontWeight.w900,
                       letterSpacing: 2.0,
                       height: 1.0,
                     ),
                   ),
                 ],
               ),
             ),
             
             // Copyright at bottom
             Align(
               alignment: Alignment.bottomCenter,
               child: Padding(
                 padding: EdgeInsets.only(bottom: 40.0.h),
                 child: Text(
                   AppStrings.copyright,
                   style: TextStyle(
                     color: AppColors.primaryExtDark,
                     fontSize: 12.sp,
                   ),
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }
}
