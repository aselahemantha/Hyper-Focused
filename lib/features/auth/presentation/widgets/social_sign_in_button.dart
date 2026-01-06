
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hyper_focused/core/theme/app_colors.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(color: AppColors.neutral200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                assetName,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error_outline, size: 20),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: AppColors.neutralDark,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
