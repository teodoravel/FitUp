// lib/pages/workout_details/start_workout.dart

import 'package:flutter/material.dart';

class StartWorkoutPage extends StatelessWidget {
  const StartWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Example design for "Start Workout" page
      body: SafeArea(
        child: Column(
          children: [
            // Some heading
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Start Workout',
                  style: TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            // Body content
            const Text(
              'Jumping Jack\n\nRepetitions: 30\nDuration: 40s',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1D1517),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              '“Remember to warm up before every work out!”',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF5C315B),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Spacer(),

            // Next or "Done" button
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                width: 200,
                height: 60,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF5C315B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Finish',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}