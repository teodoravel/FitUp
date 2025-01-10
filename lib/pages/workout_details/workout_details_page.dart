import 'package:flutter/material.dart';

class WorkoutDetailsPage extends StatelessWidget {
  const WorkoutDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Purple top bar
        body: Stack(
        children: [
        // 1) Purple top background
        Container(
        width: double.infinity,
        height: 300,
        decoration: const BoxDecoration(
        color: Color(0xFF5C315B),
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(40),
    bottomRight: Radius.circular(40),
    ),
    ),
    ),
    // 2) Scroll content
    SafeArea(
    child: Column(
    children: [
    // Top row: back arrow + page name
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
    children: [
    // back arrow
    Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
    color: Colors.white.withOpacity(0.8),
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
    'Fullbody Workout',
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    ),
    ),
    const Spacer(),
    // Possibly a 3-dot menu or heart icon
    IconButton(
    icon: const Icon(Icons.favorite_border, color: Colors.white),
    onPressed: () {},
    ),
    ],
    ),
    ),
    // 3) White area with details
    Expanded(
    child: Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 10),
    decoration: const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40),
    topRight: Radius.circular(40),
    ),
    ),
    child: SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // Some row with “Schedule Workout” & “Difficulty”
    Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
    children: [
    Expanded(
    child: ElevatedButton(
    onPressed: () {
    // e.g. Navigator.pushNamed(context, '/addSchedule');
    },
    style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFE9FFE9),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(14),
    ),
    ),
    child: const Text(
    'Schedule Workout',
    style: TextStyle(
    color: Color(0xFF5C315B),
    fontWeight: FontWeight.w600,
    ),
    ),
    ),
    ),
    const SizedBox(width: 10),
    Expanded(
    child: ElevatedButton(
    onPressed: () {
    // e.g. Difficulty pressed
    },
    style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFF7F8F8),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(14),
    ),
    ),
    child: const Text(
    'Difficulty: Beginner',
    style: TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w500,
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    const SizedBox(height: 8),

    // "You’ll Need" section
    const Text(
    'You’ll Need',
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Poppins',
    ),
    ),
    const SizedBox(height: 8),
    SizedBox(
    height: 80,
    child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
    // Example item
    _needItem(
    icon: Icons.sports_gymnastics,
    label: 'Barbell',
    ),
    _needItem(
    icon: Icons.shop_2_outlined,
    label: 'Skipping Rope',
    ),
    _needItem(
      icon: Icons.local_drink,
      label: 'Bottle',
    ),
    ],
    ),
    ),
      const SizedBox(height: 20),

      // "Exercises" section
      const Text(
        'Exercises',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
      const SizedBox(height: 8),
      // For mock: we’ll do two sets.
      const Text(
        'Set 1',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      const SizedBox(height: 8),
      _exerciseItem('Warm Up', '5min'),
      _exerciseItem('Jumping Jack', '30sec'),
      _exerciseItem('Skipping', '1min'),
      _exerciseItem('Squats', '12x'),
      _exerciseItem('Arm Raises', '10x'),
      _exerciseItem('Rest and Drink', '30sec'),
      const SizedBox(height: 16),
      const Text(
        'Set 2',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        ),
      ),
      const SizedBox(height: 8),
      _exerciseItem('Incline Push-Ups', '10x'),
      _exerciseItem('Push-Ups', '10x'),
      _exerciseItem('Skipping', '30sec'),
      _exerciseItem('Cobra Stretch', '20sec'),
      const SizedBox(height: 40),

      // "Start Workout" big button
      SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5C315B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          onPressed: () {
            // Possibly go to /startWorkout
            Navigator.pushNamed(context, '/startWorkout');
          },
          child: const Text(
            'Start Workout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
    ],
    ),
    ),
    ),
    ),
    ],
    ),
    ),
        ],
        ),
    );
  }

  // "You’ll Need" widget
  Widget _needItem({required IconData icon, required String label}) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: Colors.black54),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Single exercise item in the list
  Widget _exerciseItem(String name, String detail) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          // image placeholder:
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 10),
            color: Colors.grey.shade300,
            child: const Icon(Icons.image, color: Colors.grey),
          ),
          // name + detail
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Checkbox or circle?
          const Icon(Icons.radio_button_off, color: Colors.grey),
        ],
      ),
    );
  }
}