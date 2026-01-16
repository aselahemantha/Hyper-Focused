import 'package:flutter/material.dart';
import 'package:hyper_focused/core/constants/app_strings.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Welcome Pill
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.neutralWhite,
              borderRadius: BorderRadius.circular(30.h),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neutralDark.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Profile Image
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/user_avatar_placeholder.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: AppColors.neutral200,
                    child: Icon(Icons.person, color: AppColors.neutralDark),
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${AppStrings.welcomeBack}!",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textBody,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Jesse Doe',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.neutralDark,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 16.w),

        // Notification Bell
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.neutralDark.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.notifications,
                color: AppColors.statusNotifyBell,
                size: 28.w,
              ),
              Positioned(
                top: 12.h,
                right: 14.w,
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: const BoxDecoration(
                    color: AppColors.statusNotify,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: AppColors.neutralWhite, width: 1.5),
                    ),
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
