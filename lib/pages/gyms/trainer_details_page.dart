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
                color: Color(0xFF5C315B),
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
                      fontSize: 16,
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
                  children: [
                    SizedBox(height: 20),
                    // Big icon placeholder
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 60),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et...',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Rating: ★★★★☆\nContact: 555 555 555\ntrainer@email.com',
                      textAlign: TextAlign.center,
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