import 'package:flutter/material.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Check Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
