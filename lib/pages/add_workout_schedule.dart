// lib/pages/add_workout_schedule.dart

import 'package:flutter/material.dart';

class AddWorkoutSchedulePage extends StatelessWidget {
  const AddWorkoutSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Example design
      appBar: AppBar(
        title: const Text('Add Schedule'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // 3-dot placeholder
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Example date
              const Text(
                'Thu, 27 May 2025',
                style: TextStyle(
                  color: Color(0xFFB6B4C1),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),

              // Time
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 120,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Text('Time picker placeholder'),
                ),
              ),
              const SizedBox(height: 20),

              // Details
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Details Workout',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _detailItem('Choose Workout', 'Upperbody Workout'),
              const SizedBox(height: 10),
              _detailItem('Difficulty', 'Beginner'),
              const SizedBox(height: 10),
              _detailItem('Custom Repetitions', ''),

              const SizedBox(height: 40),

              // Save
              SizedBox(
                width: double.infinity,
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
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailItem(String title, String value) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F8),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFB6B4C1),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFFA5A3AF),
              fontSize: 10,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
        ],
      ),
    );
  }
}