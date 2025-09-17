import 'package:flutter/material.dart';
import 'package:fitup/widgets/custom_card.dart';

class WorkoutTrackerIndoorPage extends StatelessWidget {
  const WorkoutTrackerIndoorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 40, bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xB65C315B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
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

            // White container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  // "Indoor | Outdoor" toggle
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 42, 30, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _indoorOutdoorToggle(isIndoor: true, context: context),
                        const SizedBox(height: 16),
                        // Fullbody
                        CustomCard(
                          title: 'Fullbody workout',
                          subtitle: '11 Exercises | 32min',
                          buttonText: 'View more',
                          imagePath: 'assets/barbel.jpg',
                          onButtonPressed: () {
                            Navigator.pushNamed(context, '/workoutDetails');
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomCard(
                          title: 'Lowerbody workout',
                          subtitle: '11 Exercises | 32min',
                          buttonText: 'View more',
                          imagePath: 'assets/barbel.jpg',
                          onButtonPressed: () {},
                        ),
                        const SizedBox(height: 20),
                        CustomCard(
                          title: 'AB workout',
                          subtitle: '11 Exercises | 32min',
                          buttonText: 'View more',
                          imagePath: 'assets/barbel.jpg',
                          onButtonPressed: () {},
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

  Widget _indoorOutdoorToggle({
    required bool isIndoor,
    required BuildContext context,
  }) {
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
                color: isIndoor
                    ? const Color(0xFFCC6DCA)
                    : const Color(0xFF1D1517),
                fontSize: 16,
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
                color: isIndoor
                    ? const Color(0xFF1D1517)
                    : const Color(0xFFCC6DCA),
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
}
