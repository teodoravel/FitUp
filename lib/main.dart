// lib/main.dart
import 'package:flutter/material.dart';

// add "user_session.dart" if needed
import 'user_session.dart';

// Auth
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page1.dart';
import 'pages/auth/register_page2.dart';
import 'pages/auth/success_registration_page.dart';

// Home / Profile / Account
import 'pages/home_and_profile/home_page.dart';
import 'pages/home_and_profile/profile_page.dart';
import 'pages/home_and_profile/account_page.dart';

// Start
import 'pages/start/introduction_page.dart';
import 'pages/start/start_page.dart';

// Workout Details
import 'pages/workout_details/workout_details_page.dart';
import 'pages/workout_details/workout_details2.dart';
import 'pages/workout_details/start_workout.dart';

// Workout Tracker
import 'pages/workout_tracker/workout_tracker_indoor.dart';
import 'pages/workout_tracker/workout_tracker_outdoor.dart';
import 'pages/workout_tracker/workout_tracker_favorite.dart';

// Gyms
import 'pages/gyms/gym_list_page.dart';
import 'pages/gyms/gym_map_page.dart';
import 'pages/gyms/trainer_details_page.dart';

// Schedule
import 'pages/workout_schedule.dart';
import 'pages/add_workout_schedule.dart';

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
      home: const Introduction(),
      routes: {
        '/introduction': (context) => const Introduction(),
        '/start': (context) => const StartPage(),

        // Auth
        '/login': (context) => const LoginPage(),
        '/register1': (context) => const RegisterPage1(),
        '/register2': (context) => const RegisterPage2(
              fullName: '',
              email: '',
              password: '',
            ),
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

        // Workout details
        '/workoutDetails': (context) => const WorkoutDetailsPage(),
        '/workoutDetails2': (context) => const WorkoutDetails2Page(),
        '/startWorkout': (context) => const StartWorkoutPage(),

        // Schedule
        '/workoutSchedule': (context) => const WorkoutSchedulePage(),
        '/addSchedule': (context) => const AddWorkoutSchedulePage(),
      },
    );
  }
}
