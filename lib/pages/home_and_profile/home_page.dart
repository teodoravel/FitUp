import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fitup/widgets/custom_card.dart';
import 'package:fitup/user_session.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _upcomingWorkouts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchUpcomingWorkouts();
  }

  Future<void> _fetchUpcomingWorkouts() async {
    if (!UserSession.isLoggedIn) return;

    setState(() => _isLoading = true);
    final userId = UserSession.userId!;

    try {
      final url =
          Uri.parse('http://localhost:3000/api/upcoming-workouts/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          setState(() {
            _upcomingWorkouts =
                List<Map<String, dynamic>>.from(result['workouts']);
          });
        }
      }
    } catch (e) {
      // Handle error silently for now
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dayName = DateFormat('EEE').format(now).toUpperCase();
    final dayNumber = DateFormat('d').format(now);

    // Use the real user name from user_session
    final userName = UserSession.fullName ?? "User";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Welcome back, $userName',
          style: const TextStyle(
            color: Color(0xFF1D1517),
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: const Color(0xFFF4F5FB),
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavIconLabel(
              icon: Icons.home,
              label: 'Home',
              onTap: () {
                // Already on Home
              },
            ),
            _NavIconLabel(
              icon: Icons.fitness_center,
              label: 'Work out',
              onTap: () {
                Navigator.pushNamed(context, '/workoutOutdoor');
              },
            ),
            _NavIconLabel(
              icon: Icons.location_city,
              label: 'Gyms',
              onTap: () {
                Navigator.pushNamed(context, '/gyms');
              },
            ),
            _NavIconLabel(
              icon: Icons.favorite_border,
              label: 'Favourites',
              onTap: () {
                Navigator.pushNamed(context, '/workoutFavorite');
              },
            ),
            _NavIconLabel(
              icon: Icons.calendar_month,
              label: 'Calendar',
              onTap: () {
                Navigator.pushNamed(context, '/workoutSchedule');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDC2DF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          dayNumber,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      '"The body achieves what the mind believes." — Napoleon Hill',
                      style: TextStyle(
                        color: Color(0xFF5C315B),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Upcoming Workouts',
                style: TextStyle(
                  color: Color(0xFFCC6DCA),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_upcomingWorkouts.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'No upcoming workouts scheduled',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                )
              else
                Column(
                  children: _upcomingWorkouts.map((workout) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildUpcomingWorkoutCard(
                        workoutName:
                            workout['workout_name'] ?? 'Unknown Workout',
                        difficulty: workout['difficulty'] ?? 'Beginner',
                        startTime: workout['start_time'] ?? '00:00',
                        endTime: workout['end_time'] ?? '00:00',
                        date: workout['scheduled_date'] ?? '',
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingWorkoutCard({
    required String workoutName,
    required String difficulty,
    required String startTime,
    required String endTime,
    required String date,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x111D1617),
            blurRadius: 40,
            offset: Offset(0, 10),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF5C315B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.fitness_center,
              color: Color(0xFF5C315B),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$workoutName - $difficulty',
                  style: const TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$date • $startTime - $endTime',
                  style: const TextStyle(
                    color: Color(0xFFA5A3AF),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFFA5A3AF),
            size: 16,
          ),
        ],
      ),
    );
  }
}

class _NavIconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _NavIconLabel({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
