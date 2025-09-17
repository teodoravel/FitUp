import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fitup/user_session.dart';

class WorkoutDetailsPage extends StatefulWidget {
  final int? workoutId;
  final String? workoutName;

  const WorkoutDetailsPage({super.key, this.workoutId, this.workoutName});

  @override
  State<WorkoutDetailsPage> createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  String _selectedDifficulty = 'Beginner';
  bool _isLoadingFav = false;
  bool _isFavorite = false;
  bool _isLoadingWorkout = false;

  Map<String, dynamic>? _workoutData;
  List<dynamic> _exercises = [];
  List<dynamic> _equipment = [];

  @override
  void initState() {
    super.initState();
    _loadWorkoutData();
    _checkFavoriteStatus();
  }

  Future<void> _loadWorkoutData() async {
    setState(() => _isLoadingWorkout = true);

    final workoutName = widget.workoutName ?? "Fullbody Workout";

    try {
      final url = Uri.parse(
          'http://localhost:3000/api/workout/${Uri.encodeComponent(workoutName)}/$_selectedDifficulty');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          setState(() {
            _workoutData = result['workout'];
            _exercises = result['workout']['exercises'] ?? [];
            _equipment = result['workout']['equipment'] ?? [];
          });
        }
      }
    } catch (e) {
      _showSnackBar("Error loading workout data: $e");
    } finally {
      setState(() => _isLoadingWorkout = false);
    }
  }

  Future<void> _checkFavoriteStatus() async {
    final userId = UserSession.userId;
    if (userId == null) return;

    final workoutId = widget.workoutId ?? 1;

    try {
      final url = Uri.parse(
          'http://localhost:3000/api/favorites/check/$userId/workout/$workoutId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          setState(() {
            _isFavorite = result['isFavorite'] ?? false;
          });
        }
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _toggleFavorite() async {
    final userId = UserSession.userId;
    if (userId == null) {
      _showSnackBar("Please log in first");
      return;
    }

    setState(() => _isLoadingFav = true);
    final workoutId = widget.workoutId ?? 1;

    try {
      final url = Uri.parse('http://localhost:3000/api/favorites/toggle');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userId,
          "favoriteType": "workout",
          "favoriteId": workoutId,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result["success"] == true) {
          setState(() {
            _isFavorite = result['isFavorite'] ?? false;
          });
          _showSnackBar(result['action'] == 'added'
              ? "Workout added to favorites!"
              : "Workout removed from favorites!");
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
    final workoutId = widget.workoutId ?? 1;
    final workoutName = widget.workoutName ?? "Fullbody workout";
    final difficultyOptions = ['Beginner', 'Intermediate', 'Advanced'];

    final displayName = _workoutData?['name'] ?? workoutName;
    final exerciseCount = _workoutData?['exerciseCount'] ?? 11;
    final duration = _workoutData?['duration'] ?? "32min";
    final caloriesBurn = _workoutData?['caloriesBurn'] ?? 320;
    final sets = _workoutData?['sets'] ?? 3;

    return Scaffold(
      body: SafeArea(
        child: _isLoadingWorkout
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                          Expanded(
                            child: Text(
                              displayName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 16),
                          if (_isLoadingFav)
                            const SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          else
                            InkWell(
                              onTap: _toggleFavorite,
                              child: Icon(
                                _isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _isFavorite ? Colors.red : Colors.white,
                                size: 28,
                              ),
                            ),
                        ],
                      ),
                    ),
                    // 2) White container with workout details
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title & Sub
                          Text(
                            displayName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "$exerciseCount Exercises | $duration | $caloriesBurn Calories Burn",
                            style: const TextStyle(
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
                                      'workoutName': displayName,
                                      'difficulty': _selectedDifficulty,
                                    });
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                                    _loadWorkoutData(); // Reload data for new difficulty
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios,
                                      color: Color(0xFF6B6B6B), size: 18),
                                  dropdownColor: const Color(0xFFF7F8F8),
                                  items: difficultyOptions
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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

                          // "You'll Need"
                          const Text(
                            "You'll Need",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: _equipment.isEmpty
                                  ? [
                                      // Fallback equipment items
                                      _buildEquipmentItem(
                                          "Dumbbells", Icons.fitness_center),
                                      _buildEquipmentItem(
                                          "Yoga Mat", Icons.sports_gymnastics),
                                      _buildEquipmentItem(
                                          "Resistance Bands", Icons.sports),
                                    ]
                                  : _equipment.map<Widget>((equipment) {
                                      return _buildEquipmentItem(
                                        equipment['equipment_name'] ??
                                            'Equipment',
                                        Icons.fitness_center,
                                      );
                                    }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // "Exercises"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Exercises",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "$sets Sets",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          if (_exercises.isEmpty) ...[
                            // Fallback exercises
                            const Text("Set 1",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)),
                            _exerciseCard("Jumping Jacks", "10 reps"),
                            _exerciseCard("Squats", "15 reps"),
                            _exerciseCard("Plank", "1 min"),
                          ] else ...[
                            // Group exercises by set
                            for (int setNum = 1; setNum <= sets; setNum++) ...[
                              Text(
                                "Set $setNum",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ..._exercises
                                  .where((ex) => ex['set_number'] == setNum)
                                  .map((exercise) => _exerciseCard(
                                        exercise['exercise_name'] ?? 'Exercise',
                                        "${exercise['default_reps'] ?? 10} reps",
                                      )),
                              const SizedBox(height: 16),
                            ],
                          ],

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

  Widget _buildEquipmentItem(String name, IconData icon) {
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
            child: Icon(icon, size: 40),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 100,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
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
