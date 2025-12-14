
import 'package:flutter/material.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/auth_landing_background.dart';
import 'package:hyper_focused/features/auth/presentation/widgets/auth_landing_card.dart';

class AuthLandingPage extends StatelessWidget {
  const AuthLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          AuthLandingBackground(),
          AuthLandingCard(),
        ],
      ),
    );
  }
}
