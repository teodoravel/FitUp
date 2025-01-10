// workout_details2.dart
import 'package:flutter/material.dart';

class WorkoutDetails2Page extends StatelessWidget {
  const WorkoutDetails2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Top bar
        body: SafeArea(
        child: SingleChildScrollView(
        child: Column(
        children: [
        // Purple top bar
        Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
    decoration: const BoxDecoration(
    color: Color(0xFF5C315B),
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(40),
    bottomRight: Radius.circular(40),
    ),
    ),
    child: Row(
    children: [
    // back arrow
    Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
    color: const Color(0xFFF7F8F8),
    borderRadius: BorderRadius.circular(8),
    ),
    child: IconButton(
    icon: const Icon(Icons.arrow_back_ios, size: 16),
    color: Colors.black,
    onPressed: () => Navigator.pop(context),
    ),
    ),
    const SizedBox(width: 16),
    const Text(
    'Jumping Jack',
    style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    ),
    ),
    const Spacer(),
    ],
    ),
    ),

    // Body
    Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // Gray box as image placeholder
    Container(
    width: double.infinity,
    height: 180,
    color: Colors.grey.shade300,
    child: const Center(child: Text("Video/Image\nPlaceholder")),
    ),
    const SizedBox(height: 20),
    const Text(
    'Jumping Jack',
    style: TextStyle(
    color: Color(0xFF1D1517),
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    ),
    ),
    const SizedBox(height: 4),
    const Text(
    'Easy | 390 Calories Burn',
    style: TextStyle(
    color: Color(0xFFB6B4C1),
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    ),
    ),
    const SizedBox(height: 20),
    const Text(
    'Descriptions',
    style: TextStyle(
    color: Color(0xFF1D1517),
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    ),
    ),
    const SizedBox(height: 8),
    const Text(
    'A jumping jack, also known as a star jump... \nRead More...',
    style: TextStyle(
    color: Color(0xFFB6B4C1),
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    ),
    ),
    const SizedBox(height: 20),
    const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    'How To Do It',
    style: TextStyle(
    color: Color(0xFF1D1517),
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    ),
    ),
    Text(
    '4 Steps',
    style: TextStyle(
    color: Color(0xFFA5A3AF),
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    ),
    ),
    ],
    ),
    const SizedBox(height: 12),
    _stepItem(
    stepNumber: '01',
    title: 'Spread Your Arms',
    description: 'Stretch arms, no bending of hands.',
    ),
    _stepItem(
    stepNumber: '02',
    title: 'Rest at The Toe',
    description: 'Use tips of feet for jumping basis.',
    ),
    _stepItem(
    stepNumber: '03',
    title: 'Adjust Foot Movement',
    description: 'Pay attention to leg movement, keep rhythm.',
    ),
    _stepItem(
    stepNumber: '04',
    title: 'Clapping Both Hands',
    description: 'Helps keep your rhythm for Jumping Jack.',
    ),
    const SizedBox(height: 20),
    const Text(
    'Custom Repetitions',
    style: TextStyle(
    color: Color(0xFF1D1517),
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    ),
    ),
    const SizedBox(height: 8),
    Row(
    children: [
    _repBox('29'),
    const SizedBox(width: 10),
    _repBox('30'),
    const SizedBox(width: 10),
    _repBox('31'),
    ],
    ),
    const SizedBox(height: 40),
    SizedBox(
    width: double.infinity,
    height: 60,
    child: TextButton(style: TextButton.styleFrom(
      backgroundColor: const Color(0xFF5C315B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(99),
      ),
    ),
      onPressed: () {
        Navigator.pushNamed(context, '/startWorkout');
      },
      child: const Text(
        'Save',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          height: 1.50,
        ),
      ),
    ),
    ),
    ],
    ),
    ),
        ],
        ),
        ),
        ),
    );
  }

  Widget _stepItem({
    required String stepNumber,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stepNumber,
            style: const TextStyle(
              color: Color(0xFF5C315B),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFFB6B4C1),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _repBox(String text) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8F8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(child: Text(text)),
    );
  }
}