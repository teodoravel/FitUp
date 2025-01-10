import 'package:flutter/material.dart';

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
                  // "Upcoming Workouts"
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 42, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _titleSeeMoreRow('Upcoming Workouts'),
                        const SizedBox(height: 10),
                        // Tapping "Fullbody Workout" in upcoming should go to /workoutDetails
                        _upcomingCard(
                          title: 'Fullbody Workout',
                          subtitle: 'Today, 03:00pm',
                          onTap: () {
                            Navigator.pushNamed(context, '/workoutDetails');
                          },
                        ),
                        const SizedBox(height: 16),
                        _upcomingCard(
                          title: 'Upperbody Workout',
                          subtitle: 'June 05, 02:00pm',
                          onTap: () {
                            Navigator.pushNamed(context, '/workoutDetails');
                          },
                        ),
                      ],
                    ),
                  ),

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
                        _workoutCard(
                          context,
                          title: 'Cycling',
                          subtitle: 'Duration: 30min',
                        ),
                        const SizedBox(height: 20),
                        _workoutCard(
                          context,
                          title: 'Running',
                          subtitle: 'Duration: 1h',
                        ),
                        const SizedBox(height: 20),
                        _workoutCard(
                          context,
                          title: 'Swimming',
                          subtitle: 'Duration: 20min',
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

  // Title + see more
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

  // An “upcoming” card
  Widget _upcomingCard({
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
        onTap: onTap,
        child: Container(
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
    ),
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
                color: isOutdoor ? const Color(0xFF1D1517) : const Color(0xFFCC6DCA),
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
                color: isOutdoor ? const Color(0xFFCC6DCA) : const Color(0xFF1D1517),
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

  // The big “outdoor” workout card
  Widget _workoutCard(
      BuildContext context, {
        required String title,
        required String subtitle,
      }) {
    return InkWell(
      onTap: () {
        // For now, if they tap on any main outdoor workout, route them to /workoutDetails
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