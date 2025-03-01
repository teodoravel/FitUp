import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fitup/widgets/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dayName = DateFormat('EEE').format(now).toUpperCase();
    final dayNumber = DateFormat('d').format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
              onTap: () {},
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
                      '“The body achieves what the mind believes.” — Napoleon Hill',
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
              const SizedBox(height: 20),
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
              CustomCard(
                title: 'Fullbody Workout',
                subtitle: '11 Exercises | 32 minutes',
                buttonText: 'View more',
                imagePath: 'assets/barbel.jpg',
                onButtonPressed: () {
                  Navigator.pushNamed(context, '/workoutDetails');
                },
              ),
              const SizedBox(height: 30),
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
              CustomCard(
                title: 'Gym 1',
                subtitle: 'Location',
                buttonText: 'See on map',
                imagePath: 'assets/barbel.jpg',
                onButtonPressed: () {
                  Navigator.pushNamed(context, '/gymMap');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

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
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(days.length, (index) {
                        final ex = exerciseDose[index];
                        final dg = dailyGoal[index];
                        const chartH = 140.0;
                        final exH = (ex / maxHours) * chartH;
                        final dgH = (dg / maxHours) * chartH;
                        return Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
