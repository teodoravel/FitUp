import 'package:flutter/material.dart';
// Import any pages you use below:
import 'package:fitup/pages/introduction.dart';
import 'package:fitup/pages/start_page.dart';
import 'package:fitup/pages/login_page.dart';
import 'package:fitup/pages/register_page_1.dart';
import 'package:fitup/pages/register_page_2.dart';
import 'package:fitup/pages/success_registration_page.dart';
import 'package:fitup/pages/home_page.dart';
import 'package:fitup/pages/profile_page.dart';
import 'package:fitup/pages/account_page.dart';
import 'package:fitup/pages/workout_tracker_indoor_page.dart';
import 'package:fitup/pages/workout_tracker_outdoor_page.dart';
import 'package:fitup/pages/workout_tracker_favorite_page.dart';
import 'package:fitup/pages/gym_list_page.dart';
import 'package:fitup/pages/gym_map_page.dart';
import 'package:fitup/pages/trainer_details_page.dart';
import 'package:fitup/pages/workout_details_page.dart';
import 'package:fitup/pages/workout_details2_page.dart';
import 'package:fitup/pages/start_workout_page.dart';
import 'package:fitup/pages/workout_schedule.dart';
import 'package:fitup/pages/add_workout_schedule.dart';

void main() {
  runApp(const FitUpApp());
}

class FitUpApp extends StatelessWidget {
  const FitUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitUp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      // Start with the introduction page
      home: const Introduction(),
      routes: {
        // Basic
        '/introduction': (context) => const Introduction(),
        '/start': (context) => const StartPage(),

        // Auth
        '/login': (context) => const LoginPage(),
        '/register1': (context) => const RegisterPage1(),
        '/register2': (context) => const RegisterPage2(),
        '/success': (context) => const SuccessRegistrationPage(),

        // Main
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/account': (context) => const AccountPage(),

        // Workout Tracker
        '/workoutIndoor': (context) => const WorkoutTrackerIndoorPage(),
        '/workoutOutdoor': (context) => const WorkoutTrackerOutdoorPage(),
        '/workoutFavorite': (context) => const WorkoutTrackerFavoritePage(),

        // Gyms
        '/gyms': (context) => const GymListPage(),
        '/gymMap': (context) => const GymMapPage(),
        '/trainerDetails': (context) => const TrainerDetailsPage(),

        // Workout Details
        '/workoutDetails': (context) => const WorkoutDetailsPage(),
        '/workoutDetails2': (context) => const WorkoutDetails2Page(),
        '/startWorkout': (context) => const StartWorkoutPage(),

        // Workout schedule
        '/workoutSchedule': (context) => const WorkoutSchedulePage(),
        '/addSchedule': (context) => const AddWorkoutSchedulePage(),
      },
    );
  }
}
