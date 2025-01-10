// workout_tracker_indoor.dart
import 'package:flutter/material.dart';

class WorkoutTrackerIndoorPage extends StatelessWidget {
  const WorkoutTrackerIndoorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1) Purple top area
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xB65C315B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
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
                    'Workout Tracker',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
            ),

            // 2) White container area
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  // "Upcoming Workouts"
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 42, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _titleSeeMoreRow('Upcoming Workouts'),
                        const SizedBox(height: 10),
                        _upcomingCard(title: 'Fullbody Workout', subtitle: 'Today, 03:00pm'),
                        const SizedBox(height: 16),
                        _upcomingCard(title: 'Upperbody Workout', subtitle: 'June 05, 02:00pm'),
                      ],
                    ),
                  ),

                  // "Indoor | Outdoor" toggle + workouts
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 42, 30, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _indoorOutdoorToggle(isIndoor: true, context: context),
                        const SizedBox(height: 16),
                        _workoutCard(
                          context,
                          title: 'Fullbody Workout',
                          subtitle: '11 Exercises | 32mins',
                        ),
                        const SizedBox(height: 20),
                        _workoutCard(
                          context,
                          title: 'Lowebody Workout',
                          subtitle: '12 Exercises | 40mins',
                        ),
                        const SizedBox(height: 20),
                        _workoutCard(
                          context,
                          title: 'AB Workout',
                          subtitle: '14 Exercises | 20mins',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleSeeMoreRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1D1517),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 1.50,
          ),
        ),
        const Text(
          'See more',
          style: TextStyle(
            color: Color(0xFFA5A3AF),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 1.50,
          ),
        ),
      ],
    );
  }

  Widget _upcomingCard({required String title, required String subtitle}) {
    return Container(
      width: double.infinity,
      height: 80,
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
          const SizedBox(width: 15),
          Opacity(
            opacity: 0.30,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1D1517),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 1.50,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
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
        ],
      ),
    );
  }

  Widget _indoorOutdoorToggle({required bool isIndoor, required BuildContext context}) {
    return SizedBox(
        width: 166,
        child: Row(
            children: [
            InkWell(
            onTap: () {
        // Already on Indoor
    },
        child: Text(
            'Indoor',
            style: TextStyle(
            color: isIndoor ? const Color(0xFFCC6DCA) : const Color(0xFF1D1517),fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: isIndoor ? FontWeight.w600 : FontWeight.w300,
              height: 1.50,
            ),
        ),
            ),
              const SizedBox(width: 13),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/workoutOutdoor');
                },
                child: Text(
                  'Outdoor',
                  style: TextStyle(
                    color: isIndoor ? const Color(0xFF1D1517) : const Color(0xFFCC6DCA),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: isIndoor ? FontWeight.w300 : FontWeight.w600,
                    height: 1.50,
                  ),
                ),
              ),
            ],
        ),
    );
  }

  Widget _workoutCard(BuildContext context, {required String title, required String subtitle}) {
    return InkWell(
      onTap: () {
        // Tapping a workout => '/workoutDetails'
        Navigator.pushNamed(context, '/workoutDetails');
      },
      child: Container(
        width: double.infinity,
        height: 132,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF5C315B).withOpacity(0.20),
        ),
        child: Stack(
          children: [
            // White circle top right
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
            // Title + subtitle
            Positioned(
              left: 20,
              top: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF1D1517),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF6B6B6B),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ],
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
                alignment: Alignment.center,
                child: const Text(
                  'View more',
                  style: TextStyle(
                    color: Color(0xFF5C315B),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}