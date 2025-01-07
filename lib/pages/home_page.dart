import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1) For the top "Calendar" block
    final now = DateTime.now();
    final dayName = DateFormat('EEE').format(now).toUpperCase(); // e.g. "SUN"
    final dayNumber = DateFormat('d').format(now); // e.g. "5"

    return Scaffold(
      // 2) Top AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Welcome back, Stefani',
          style: TextStyle(
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

      // 3) Bottom nav bar
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
                // Already on Home? Could do nothing or re-push
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
                // Placeholder
              },
            ),
          ],
        ),
      ),

      // 4) Main body content in a scroll view
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The top row with date + quote
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Purple date box
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
                          dayName, // e.g. "SUN"
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          dayNumber, // e.g. "5"
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
                      '“The body achieves what the mind believes.” — Napoleon Hill',
                      style: TextStyle(
                        color: Color(0xFF5C315B),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 1) Stats this week with the bar chart
              const Text(
                'Stats this week',
                style: TextStyle(
                  color: Color(0xFF1D1517),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildTwoBarChart(),

              const SizedBox(height: 30),

              // 2) Today’s workout
              const Text(
                'Today’s workout',
                style: TextStyle(
                  color: Color(0xFFCC6DCA),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildWorkoutBox(),

              const SizedBox(height: 30),

              // 3) Recommended Gym
              const Text(
                'Recommended Gym',
                style: TextStyle(
                  color: Color(0xFF1D1517),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              _buildGymBox(),
            ],
          ),
        ),
      ),
    );
  }

  // =============== Chart code ===============
  Widget _buildTwoBarChart() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final exerciseDose = [2.5, 2.0, 2.3, 1.0, 0.5, 2.0, 0.3];
    final dailyGoal = [2.5, 2.5, 2.5, 2.0, 2.0, 2.5, 1.5];
    const maxHours = 2.5;
    final yLabels = [
      '2.5 h',
      '2 h',
      '1.5 h',
      '1 h',
      '30 min',
      '10 min',
      '0 min'
    ];

    return SizedBox(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // chart area
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis (labels)
                SizedBox(
                  width: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: yLabels.map((label) {
                      return Text(label, style: const TextStyle(fontSize: 12));
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 8),
                // bars horizontally
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(days.length, (index) {
                        final ex = exerciseDose[index]; // e.g. 2.5
                        final dg = dailyGoal[index]; // e.g. 2.0
                        const chartH = 140.0;
                        final exH = (ex / maxHours) * chartH;
                        final dgH = (dg / maxHours) * chartH;

                        return Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Two bars side by side
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 10,
                                    height: exH,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF9552A0),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 10,
                                    height: dgH,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8EAFB),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(days[index],
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Legend
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF9552A0),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text('Exercise dose', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 20),
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8EAFB),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text('Daily Goal', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  // =============== "Today's workout" box code ===============
  Widget _buildWorkoutBox() {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Purple background with 20% opacity
          Opacity(
            opacity: 0.20,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5C315B),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // Title + subtitle
          const Positioned(
            left: 20,
            top: 20,
            child: SizedBox(
              width: 123,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fullbody Workout',
                    style: TextStyle(
                      color: Color(0xFF1D1517),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '11 Exercises | 32mins',
                    style: TextStyle(
                      color: Color(0xFF6B6B6B),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // White circle on the right
          Positioned(
            right: 20,
            top: 20,
            child: Opacity(
              opacity: 0.50,
              child: Container(
                width: 92,
                height: 92,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // "View more" button
          Positioned(
            left: 20,
            bottom: 15,
            child: Container(
              width: 94,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: Text(
                  'View more',
                  style: TextStyle(
                    color: Color(0xFF5C315B),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =============== "Recommended Gym" box code ===============
  Widget _buildGymBox() {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Purple background with 20% opacity
          Opacity(
            opacity: 0.20,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5C315B),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          // Title + subtitle
          const Positioned(
            left: 20,
            top: 20,
            child: SizedBox(
              width: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gym 1',
                    style: TextStyle(
                      color: Color(0xFF1D1517),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Location',
                    style: TextStyle(
                      color: Color(0xFF6B6B6B),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // White circle on the right
          Positioned(
            right: 20,
            top: 20,
            child: Opacity(
              opacity: 0.50,
              child: Container(
                width: 92,
                height: 92,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // "See on map" button
          Positioned(
            left: 20,
            bottom: 15,
            child: Container(
              width: 94,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: Text(
                  'See on map',
                  style: TextStyle(
                    color: Color(0xFF5C315B),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// A small helper for the bottom nav icons
class _NavIconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavIconLabel({
    required this.icon,
    required this.label,
    required this.onTap,
    // ignore: unused_element
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
