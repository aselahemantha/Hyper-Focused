
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthLandingCard extends StatelessWidget {
  const AuthLandingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        // Height controls how much of the screen it takes.
        // Based on image, it looks like roughly 40-45% of screen height
        // or content based.
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 34,
          top: 30, // giving some space for the logo overlap if we were doing that style
        ),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo area
            // Assuming logo is an image for now as described in plan
            Row(
              children: [
                Image.asset(
                  'assets/images/logo_white.png',
                   height: 48, // approximate size
                   // width: 48,
                ),
                // If the logo image doesn't include text, we'd add Text widget here.
                // Assuming the asset "logo_white.png" is the icon+text combo from the design
              ],
            ),
            const SizedBox(height: 24),
            
            // Description Text
            const Text(
              'The modern home inspection platform designed for professionals who value precision, efficiency, and exceptional client experiences.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Sign In Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                   context.push('/login'); // Assuming /login route
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00AA88), // Teal color from design
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Register Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/signup'); // Assuming /signup route
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Register Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
             const SizedBox(height: 20), // Bottom safe area padding approximation
          ],
        ),
      ),
    );
  }
}
