import 'package:flutter/material.dart';
import 'package:fitup/widgets/custom_card.dart';

class WorkoutTrackerOutdoorPage extends StatelessWidget {
  const WorkoutTrackerOutdoorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1) Purple top area
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
                  // small box for back arrow
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F8F8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Real back arrow IconButton
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
                  // "Indoor | Outdoor" toggle + workouts
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 42, 30, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // isOutdoor = true
                        _indoorOutdoorToggle(isOutdoor: true, context: context),
                        const SizedBox(height: 16),

                        // The "outdoor" workout cards
                        CustomCard(
                            title: 'Cycling',
                            subtitle: 'Duration: 30min',
                            buttonText: 'View more',
                            imagePath: 'assets/barbel.jpg',
                            onButtonPressed: () {}),
                        const SizedBox(height: 20),
                        CustomCard(
                            title: 'Swimming',
                            subtitle: 'Duration: 20min',
                            buttonText: 'View more',
                            imagePath: 'assets/barbel.jpg',
                            onButtonPressed: () {}),
                        const SizedBox(height: 20),
                        CustomCard(
                            title: 'Running',
                            subtitle: 'Duration: 1h',
                            buttonText: 'View more',
                            imagePath: 'assets/barbel.jpg',
                            onButtonPressed: () {})
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

  // A row "Indoor" / "Outdoor"
  Widget _indoorOutdoorToggle({
    required bool isOutdoor,
    required BuildContext context,
  }) {
    return SizedBox(
      width: 166,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              // user taps "Indoor"
              Navigator.pushNamed(context, '/workoutIndoor');
            },
            child: Text(
              'Indoor',
              style: TextStyle(
                color: isOutdoor
                    ? const Color(0xFF1D1517)
                    : const Color(0xFFCC6DCA),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: isOutdoor ? FontWeight.w300 : FontWeight.w600,
                height: 1.50,
              ),
            ),
          ),
          const SizedBox(width: 13),
          InkWell(
            onTap: () {
              // user taps "Outdoor" – do nothing if we are already on Outdoor
            },
            child: Text(
              'Outdoor',
              style: TextStyle(
                color: isOutdoor
                    ? const Color(0xFFCC6DCA)
                    : const Color(0xFF1D1517),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: isOutdoor ? FontWeight.w600 : FontWeight.w300,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
