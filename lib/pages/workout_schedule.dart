// lib/pages/workout_schedule.dart

import 'package:flutter/material.dart';

class WorkoutSchedulePage extends StatelessWidget {
  const WorkoutSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Example design
      appBar: AppBar(
        title: const Text('Workout Schedule'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Fake "Calendar"
            const SizedBox(height: 20),
            const Text(
              'September 2025',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: 300,
              color: Colors.grey.shade200,
              child: const Center(
                child: Text('Calendar widget placeholder'),
              ),
            ),
            // Example: Show a schedule item
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('14:00 - 15:00  |  Full body workout'),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5C315B),
        onPressed: () {
          // Go to add schedule page
          Navigator.pushNamed(context, '/addSchedule');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}