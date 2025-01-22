import 'package:flutter/material.dart';

class WorkoutTrackerFavoritePage extends StatelessWidget {
  const WorkoutTrackerFavoritePage({super.key});

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
                  // Box for the back arrow
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
                    'Favourites',
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

            // 2) White container with favorites
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Workouts
                  _sectionTitle('Workouts'),
                  const SizedBox(height: 10),
                  _favoriteCard(
                    title: 'Fullbody Workout',
                    subtitle: 'Today, 03:00pm',
                    onTap: () {
                      Navigator.pushNamed(context, '/workoutDetails');
                    },
                  ),
                  const SizedBox(height: 12),
                  _favoriteCard(
                    title: 'Upperbody Workout',
                    subtitle: 'June 05, 02:00pm',
                  ),

                  const SizedBox(height: 24),
                  // Gyms
                  _sectionTitle('Gyms'),
                  const SizedBox(height: 10),
                  _favoriteCard(title: 'Gym 1'),
                  const SizedBox(height: 12),
                  _favoriteCard(title: 'Gym 2'),

                  const SizedBox(height: 24),
                  // Trainers
                  _sectionTitle('Trainers'),
                  const SizedBox(height: 10),
                  _favoriteCard(title: 'Trainer 1'),
                  const SizedBox(height: 12),
                  _favoriteCard(title: 'Trainer 2'),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A re-usable section title row with "See more"
  Widget _sectionTitle(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
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

  // Re-usable “favorite” card
  Widget _favoriteCard({
    required String title,
    String subtitle = '',
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
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
            // circle
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
            const SizedBox(width: 12),
            // Titles
            Column(
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
                if (subtitle.isNotEmpty) ...[
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
              ],
            ),
            const Spacer(), // To push the heart icon to the right
            const Icon(
              Icons.favorite,
              color: Colors.red, // Red color for the heart icon
              size: 20, // Adjust size as needed
            ),
          ],
        ),
      ),
    );
  }
}
