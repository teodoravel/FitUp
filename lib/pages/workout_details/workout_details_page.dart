// lib/pages/workout_details/workout_details_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fitup/user_session.dart';

class WorkoutDetailsPage extends StatefulWidget {
  const WorkoutDetailsPage({super.key});

  @override
  State<WorkoutDetailsPage> createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  // we restore the old design with “11 Exercises | 32mins | 320 Calories Burn,”
  // plus difficulty dropdown, plus “You’ll need,” plus “Exercises”
  // plus the heart in the top right
  String _selectedDifficulty = 'Beginner';
  bool _isLoadingFav = false;

  Future<void> _addFavoriteWorkout(int workoutId) async {
    final userId = UserSession.userId;
    if (userId == null) {
      _showSnackBar("Please log in first");
      return;
    }
    setState(() => _isLoadingFav = true);
    try {
      final url = Uri.parse('http://localhost:3000/api/favorites');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": userId,
          "favorite_type": "workout",
          "favorite_id": workoutId, // e.g. 1 for Fullbody
        }),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result["success"] == true) {
          _showSnackBar("Workout added to favorites!");
        } else {
          _showSnackBar("Server error: ${result['error'] ?? 'unknown'}");
        }
      } else {
        _showSnackBar("Server error: ${response.statusCode}");
      }
    } catch (e) {
      _showSnackBar("Error: $e");
    } finally {
      setState(() => _isLoadingFav = false);
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Suppose we always show “Fullbody Workout” with ID=1
    // In a real app, you might pass arguments or fetch from server
    final workoutId = 1;
    final workoutName = "Fullbody workout";
    final difficultyOptions = ['Beginner', 'Intermediate', 'Advanced'];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1) Purple top area with back arrow & heart
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                decoration: const BoxDecoration(
                  color: Color(0xB65C315B),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      workoutName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    // Heart icon
                    if (_isLoadingFav)
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    else
                      InkWell(
                        onTap: () => _addFavoriteWorkout(workoutId),
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                  ],
                ),
              ),
              // 2) White container with workout details
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Sub
                    Text(
                      workoutName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "11 Exercises | 32mins | 320 Calories Burn",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // "Schedule Workout" button
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Color(0x8000ff66),
                            Color(0x8000efff),
                          ],
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          // go to /workoutSchedule
                          Navigator.pushNamed(context, '/workoutSchedule',
                              arguments: {
                                'workoutName': workoutName,
                                'difficulty': _selectedDifficulty,
                              });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            SizedBox(width: 16),
                            Icon(Icons.calendar_today,
                                color: Color(0xFF6B6B6B), size: 18),
                            SizedBox(width: 8),
                            Text(
                              "Schedule Workout",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B6B6B),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios,
                                color: Color(0xFF6B6B6B), size: 18),
                            SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Difficulty
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0x805c315b),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.swap_vert,
                                  color: Color(0xFF6B6B6B), size: 18),
                              SizedBox(width: 8),
                              Text(
                                "Difficulty",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF6B6B6B),
                                ),
                              ),
                            ],
                          ),
                          DropdownButton<String>(
                            value: _selectedDifficulty,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedDifficulty = newValue!;
                              });
                            },
                            icon: const Icon(Icons.arrow_forward_ios,
                                color: Color(0xFF6B6B6B), size: 18),
                            dropdownColor: const Color(0xFFF7F8F8),
                            items: difficultyOptions
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    color: Color(0xFF6B6B6B),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // "You’ll Need"
                    const Text(
                      "You’ll Need",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // row of 5 items placeholders
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[300],
                                  ),
                                  child: const Icon(Icons.fitness_center,
                                      size: 40),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Item Title",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // "Exercises"
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Exercises",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "3 Sets",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Set 1",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Example exercise cards
                    _exerciseCard("Jumping Jacks", "10 reps"),
                    _exerciseCard("Squats", "15 reps"),
                    _exerciseCard("Plank", "1 min"),

                    const SizedBox(height: 20),
                    const Text(
                      "Set 2",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    _exerciseCard("Jumping Jacks", "10 reps"),
                    _exerciseCard("Squats", "15 reps"),
                    _exerciseCard("Plank", "1 min"),
                    const SizedBox(height: 20),

                    // Start button
                    Center(
                      child: SizedBox(
                        width: 315,
                        height: 60,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF5C315B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/startWorkout');
                          },
                          child: const Text(
                            'Start',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _exerciseCard(String name, String reps) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff7f8f8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[300],
            ),
            child: const Icon(Icons.fitness_center),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reps,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
