// introduction_page.dart
import 'package:flutter/material.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Tapping goes to /start
          Navigator.pushNamed(context, '/start');
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "FitUp!",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5C315B),
                ),
              ),
              // Example image (make sure you have this asset in your pubspec)
              Image.asset(
                "assets/Saly-34.png",
                width: 246,
                height: 331,
              ),
            ],
          ),
        ),
      ),
    );
  }
}