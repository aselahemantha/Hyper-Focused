
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';
import 'package:hyper_focused/core/utils/responsive_size.dart';

class SocialSignInButton extends StatelessWidget {
  final String text;
  final String assetName;
  final VoidCallback onPressed;

  const SocialSignInButton({
    super.key,
    required this.text,
    required this.assetName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          side: BorderSide(color: AppColors.neutral200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.h),
          ),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: SvgPicture.asset(
                assetName,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error_outline, size: 20.w),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              text,
              style: TextStyle(
                color: AppColors.neutralDark,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
