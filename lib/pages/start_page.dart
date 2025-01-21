// lib/pages/start_page.dart

import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Centers content vertically
            children: [
              // Main heading
              const Text(
                "Get your\nFitness Up!",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5C315B),
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 108),

              // Subheading
              const Text(
                "Already have an\naccount?",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 21),

              // Log in button
              SizedBox(
                width: 315,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF9552A1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  onPressed: () {
                    // Takes user to login
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),

              // "Or" text
              const Text(
                "Or",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 22),

              // Create account button
              SizedBox(
                width: 315,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF9552A1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  onPressed: () {
                    // Takes user to the first register page
                    Navigator.pushNamed(context, '/register1');
                  },
                  child: const Text(
                    'Create account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}