import 'package:flutter/material.dart';

class ApprovedPage extends StatelessWidget {
  const ApprovedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Approved Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
