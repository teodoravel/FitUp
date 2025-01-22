// trainer_details_page.dart
import 'package:flutter/material.dart';

class TrainerDetailsPage extends StatelessWidget {
  const TrainerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Purple top
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xB65C315B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
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
                    'Trainer 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20, // Increased size
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            // Body
            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Left alignment for all text
                  children: [
                    SizedBox(height: 20),
                    // Center the CircleAvatar
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person_outline,
                          size: 80,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur\n'
                          'adipiscing elit, sed do eiusmod tempor\n'
                          'incididunt ut labore et dolore magna\n'
                          'aliqua. Ut enim ad minim veniam, quis\n'
                          'nostrud exercitation ullamco laboris nisi\n'
                          'ut aliquip ex ea commodo consequat.\n'
                          'Duis aute irure dolor in',
                      style: TextStyle(
                        fontSize: 18, // Increased font size for all text
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Rating: ★★★★☆',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold, // Bold rating
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Contact: 555 555 555\n\ttrainer@email.com',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold, // Bold contact info
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
