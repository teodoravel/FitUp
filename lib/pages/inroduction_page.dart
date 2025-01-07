import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/start'); // Replace with your target route
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "FitUp!",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF5C315B),
                ),
              ),
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