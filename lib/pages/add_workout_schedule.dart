import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddWorkoutSchedulePage extends StatefulWidget {
  const AddWorkoutSchedulePage({super.key});

  @override
  State<AddWorkoutSchedulePage> createState() => _AddWorkoutSchedulePageState();
}

class _AddWorkoutSchedulePageState extends State<AddWorkoutSchedulePage> {
  DateTime _selectedTime = DateTime.now();

  // Dropdown options:
  final List<String> _workoutOptions = [
    'Fullbody Workout',
    'Upperbody Workout',
    'Lowerbody Workout',
  ];
  final List<String> _difficultyOptions = [
    'Beginner',
    'Intermediate',
    'Advanced',
  ];

  // Selected values for the dropdowns:
  String _selectedWorkout = 'Upperbody Workout';
  String _selectedDifficulty = 'Beginner';

  // For Custom Repetitions text field:
  // ignore: unused_field
  String _customReps = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Schedule'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
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
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: _selectedTime,
                  use24hFormat: true,
                  onDateTimeChanged: (DateTime newTime) {
                    setState(() {
                      _selectedTime = newTime;
                    });
                  },
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
    // We will conditionally build different widgets based on the 'title'.
    if (title == 'Choose Workout') {
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
            DropdownButton<String>(
              value: _selectedWorkout,
              underline: const SizedBox(), // Remove default underline
              items: _workoutOptions.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(
                      color: Color(0xFFA5A3AF),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedWorkout = newValue!;
                });
              },
            ),
          ],
        ),
      );
    } else if (title == 'Difficulty') {
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
            DropdownButton<String>(
              value: _selectedDifficulty,
              underline: const SizedBox(),
              items: _difficultyOptions.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(
                      color: Color(0xFFA5A3AF),
                      fontSize: 10,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedDifficulty = newValue!;
                });
              },
            ),
          ],
        ),
      );
    } else if (title == 'Custom Repetitions') {
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
            SizedBox(
              width: 60,
              child: TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Color(0xFFA5A3AF),
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
                decoration: const InputDecoration(
                  hintText: '0',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    _customReps = value;
                  });
                },
              ),
            ),
          ],
        ),
      );
    } else {
      // Default: for any other title not specified above
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
}
