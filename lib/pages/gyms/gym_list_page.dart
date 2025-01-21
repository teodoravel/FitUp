// gym_list_page.dart
import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../../custom_card.dart';
=======

import '../../widgets/custom_card.dart';
>>>>>>> 749e1343f1c35b30465549d45fe685bc124b4d5b

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
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 16),
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
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
                        _upcomingCard(title: 'Your gym', subtitle: ''),
                        const SizedBox(height: 16),
                        _upcomingCard(title: 'Local gym', subtitle: ''),
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
                        const SizedBox(height: 10),
                        // The custom workout cards
                        _customCard(
                          context,
                          title: 'Gym 1',
                          subtitle: 'Location',
                          buttonText: 'See on map',
                          onButtonPressed: () {
                            Navigator.pushNamed(context, '/gymMap');
                          },
                        ),
                        const SizedBox(height: 20),
                        _customCard(
                          context,
                          title: 'Gym 2',
                          subtitle: 'Location',
                          buttonText: 'See on map',
                          onButtonPressed: () {
                            Navigator.pushNamed(context, '/gymMap');
                          },
                        ),
                        const SizedBox(height: 20),
                        _customCard(
                          context,
                          title: 'Gym 3',
                          subtitle: 'Location',
                          buttonText: 'See on map',
                          onButtonPressed: () {
                            Navigator.pushNamed(context, '/gymMap');
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
                        _titleSeeMoreRow('Personal Trainers'),
                        const SizedBox(height: 10),
                        _customCard(
                          context,
                          title: 'Trainer 1',
                          subtitle: '4.5 K',
                          buttonText: 'Contact',
                          onButtonPressed: () {
                            Navigator.pushNamed(context, '/trainerDetails');
                          },
                        ),
                        const SizedBox(height: 20),
                        _customCard(
                          context,
                          title: 'Trainer 2',
                          subtitle: '4.5 K',
                          buttonText: 'Contact',
                          onButtonPressed: () {
                            Navigator.pushNamed(context, '/trainerDetails');
                          },
                        ),
                        const SizedBox(height: 20),
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

  // Replacing "CustomCard" usage with direct code or you can still import your custom_card.dart
  Widget _customCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required String buttonText,
        required VoidCallback onButtonPressed,
      }) {
    return Container(
      width: double.infinity,
      height: 132,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF5C315B).withOpacity(0.20),
      ),
      child: Stack(
        children: [
          // Title + Subtitle
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
          // White circle on right
          Positioned(
            right: 20,
            top: 20,
            child: Opacity(
              opacity: 0.50,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          // Button
          Positioned(
            left: 20,
            bottom: 15,
            child: GestureDetector(
              onTap: onButtonPressed,
              child: Container(
                width: 94,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Color(0xFF5C315B),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
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