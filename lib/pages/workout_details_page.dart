import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/exercise_card.dart';

class WorkoutDetailsPage extends StatefulWidget {
  const WorkoutDetailsPage({super.key});

  @override
  State<WorkoutDetailsPage> createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  String _selectedDifficulty = 'Beginner';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1) Purple top area with back arrow
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 40, bottom: 20),
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
                    // Real arrow IconButton
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, size: 16),
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),

            // 2) White container with workout details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Workout title and details
                  const Text(
                    "Fullbody workout",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "11 Exercises | 32mins | 320 Calories Burn",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Schedule workout butto
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Color(0x8000ff66), // Reduced opacity green
                          Color(0x8000efff), // Reduced opacity blue
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Color(0xFF6B6B6B),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Schedule Workout",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B6B6B),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "5/27, 09:00 AM",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B6B6B)
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF6B6B6B),
                          size: 18,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Difficulty button
                  // Container with DropdownButton for difficulty
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0x805c315b), // Reduced opacity purple
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.swap_vert,
                              color: Color(0xFF6B6B6B),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Difficulty",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B6B6B),
                              ),
                            ),
                          ],
                        ),
                        DropdownButton<String>(
                          value: _selectedDifficulty,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedDifficulty = newValue!;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF6B6B6B),
                            size: 18,
                          ),
                          dropdownColor: const Color(0xFFF7F8F8), // Background color of dropdown
                          items: <String>['Beginner', 'Intermediate', 'Advanced']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Color(0xFF6B6B6B),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Row with "You’ll Need" and "5 Items"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "You’ll Need",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "5 Items",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),

                  // Row of containers with images and titles
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,  // Square width
                                height: 100, // Square height
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[300], // Gray background
                                ),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/barbel.jpg', // Replace with actual image URLs
                                      fit: BoxFit.contain,  // Ensures the image fits inside the square
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Item Title", // Replace with dynamic titles
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Exercises",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "3 Sets",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),

                  const Text(
                    "Set 1",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),


                  //Exercise cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      children: [
                        ExerciseCard(
                          imageUrl: 'assets/pushup.jpg',
                          exerciseName: 'Push Ups',
                          reps: '10 reps',
                          onTap: () {
                            // Handle tap, navigate to details page
                          },
                        ),
                        ExerciseCard(
                          imageUrl: 'assets/squat.jpg',
                          exerciseName: 'Squats',
                          reps: '15 reps',
                          onTap: () {
                            // Handle tap, navigate to details page
                          },
                        ),
                        ExerciseCard(
                          imageUrl: 'assets/plank.jpg',
                          exerciseName: 'Plank',
                          reps: '1 min',
                          onTap: () {
                            // Handle tap, navigate to details page
                          },
                        ),
                      ],
                    ),
                  ),

                  const Text(
                    "Set 2",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      children: [
                        ExerciseCard(
                          imageUrl: 'assets/pushup.jpg',
                          exerciseName: 'Push Ups',
                          reps: '10 reps',
                          onTap: () {
                            // Handle tap, navigate to details page
                          },
                        ),
                        ExerciseCard(
                          imageUrl: 'assets/squat.jpg',
                          exerciseName: 'Squats',
                          reps: '15 reps',
                          onTap: () {
                            // Handle tap, navigate to details page
                          },
                        ),
                        ExerciseCard(
                          imageUrl: 'assets/plank.jpg',
                          exerciseName: 'Plank',
                          reps: '1 min',
                          onTap: () {
                            // Handle tap, navigate to details page
                          },
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 315,
                      height: 60,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF5C315B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                        onPressed: () =>{

                        },
                        child: const Text(
                          'Start',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
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
}
