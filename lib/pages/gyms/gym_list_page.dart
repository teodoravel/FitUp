import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_card.dart';

class GymListPage extends StatelessWidget {
  const GymListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A scroll view to avoid unbounded constraints
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
                    // Now an IconButton for the back arrow:
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 16),
                      color: Colors.black,
                      onPressed: () =>
                          Navigator.pop(context), // pop to previous page
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Gyms',
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
                  // "Gyms near you"
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 42, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _titleSeeMoreRow('Gyms near you'),
                        const SizedBox(height: 10),
                        _upcomingCard(
                            title: 'Gym 1',
                            subtitle: ''),
                        const SizedBox(height: 16),
                        _upcomingCard(
                            title: 'Gym 2',
                            subtitle: ''),
                      ],
                    ),
                  ),
                  // All gyms
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        _titleSeeMoreRow('All gyms'),
                        // The custom workout cards
                        CustomCard(
                          title: 'Gym 1',
                          subtitle: 'Location',
                          buttonText: 'See on map',
                          imagePath: 'assets/Saly-34.png', // Path to your image
                          onButtonPressed: () {
                            // Handle button navigation
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GymDetailsPage(gymId: 1),
                              ),
                            );*/
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomCard(
                          title: 'Gym 2',
                          subtitle: 'Location',
                          buttonText: 'See on map',
                          imagePath: 'assets/Saly-34.png', // Path to your image
                          onButtonPressed: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GymDetailsPage(gymId: 2),
                              ),
                            );*/
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomCard(
                          title: 'Gym 3',
                          subtitle: 'Location',
                          buttonText: 'See on map',
                          imagePath: 'assets/Saly-34.png', // Path to your image
                          onButtonPressed: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GymDetailsPage(gymId: 3),
                              ),
                            );*/
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        _titleSeeMoreRow('Trainers'),
                        // The custom workout cards for trainers
                        CustomCard(
                          title: 'Trainer 1',
                          subtitle: 'Rating: 4.5',
                          buttonText: 'View Profile',
                          imagePath: 'assets/Saly-34.png', // Path to your image
                          onButtonPressed: () {
                            // Handle button navigation
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrainerDetailsPage(trainerId: 1),
                              ),
                            );*/
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomCard(
                          title: 'Trainer 2',
                          subtitle: 'Rating: 4.0',
                          buttonText: 'View Profile',
                          imagePath: 'assets/Saly-34.png', // Path to your image
                          onButtonPressed: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrainerDetailsPage(trainerId: 2),
                              ),
                            );*/
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomCard(
                          title: 'Trainer 3',
                          subtitle: 'Rating: 4.8',
                          buttonText: 'View Profile',
                          imagePath: 'assets/Saly-34.png', // Path to your image
                          onButtonPressed: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TrainerDetailsPage(trainerId: 3),
                              ),
                            );*/
                          },
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

  // "Upcoming Workouts" + "See more"
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

  // A small "upcoming" card
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
}
