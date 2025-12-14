
import 'package:flutter/material.dart';

class AuthLandingBackground extends StatelessWidget {
  const AuthLandingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/auth_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      // Adding a gradient overlay to ensure text contrast if strictly needed,
      // but based on design the card handles the contrast.
      // However, the top status bar area might need some protection or
      // the image itself is dark enough.
      // For now, simple image.
    );
  }
}
