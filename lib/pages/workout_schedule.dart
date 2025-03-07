// lib/pages/workout_schedule.dart

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkoutSchedulePage extends StatefulWidget {
  const WorkoutSchedulePage({super.key});

  @override
  State<WorkoutSchedulePage> createState() => _WorkoutSchedulePageState();
}

class _WorkoutSchedulePageState extends State<WorkoutSchedulePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // hold the workoutName & difficulty passed from the details page
  String? _passedWorkoutName;
  String? _passedDifficulty;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _passedWorkoutName = args['workoutName'] as String?;
      _passedDifficulty = args['difficulty'] as String?;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Calendar
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2021, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xFF5C315B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            // Example schedule item
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFF5C315B),
                      radius: 10,
                      child: Icon(Icons.fitness_center,
                          size: 12, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Text('14:00 - 15:00\nFull body workout',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5C315B),
        onPressed: () {
          if (_selectedDay == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select a day first')),
            );
            return;
          }

          Navigator.pushNamed(
            context,
            '/addSchedule',
            arguments: {
              'selectedDate': _selectedDay,
              'workoutName': _passedWorkoutName,
              'difficulty': _passedDifficulty,
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
