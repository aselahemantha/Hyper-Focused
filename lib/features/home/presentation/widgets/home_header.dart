import 'package:flutter/material.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Welcome Pill
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/user_avatar_placeholder.png'), // Placeholder
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Fallback if asset missing
                  child: const CircleAvatar(
                    backgroundColor: AppColors.neutral200,
                    child: Icon(Icons.person, color: AppColors.neutralDark),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textBody,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Jesse Doe',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.neutralDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Notification Bell
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.notifications,
                color: Color(0xFFFFB300), // Yellow/Orange bell
                size: 28,
              ),
              Positioned(
                top: 12,
                right: 14,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 1.5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
