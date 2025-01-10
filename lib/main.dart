<<<<<<< HEAD
import 'package:flutter/material.dart';

// Introduction & Start
import 'pages/introduction_page.dart';    // class Introduction
import 'pages/start_page.dart';          // class StartPage

// Auth
import 'pages/login_page.dart';
import 'pages/register_page1.dart';
import 'pages/register_page2.dart';
import 'pages/success_registration_page.dart';

// Home / Profile / Account
=======
import 'package:fitup/pages/gyms/gym_list_page.dart';
import 'package:fitup/pages/register_page1.dart';
import 'package:fitup/pages/inroduction_page.dart';
import 'package:fitup/pages/register_page2.dart';
import 'package:fitup/pages/start_page.dart';
import 'package:fitup/pages/success_registration_page.dart';
import 'package:fitup/pages/workout_details_page.dart';
import 'package:fitup/pages/workout_tracker/workout_tracker_outdoor.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
>>>>>>> 749e1343f1c35b30465549d45fe685bc124b4d5b
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/account_page.dart';

// Workout Tracker
import 'pages/workout_tracker/workout_tracker_indoor.dart';
import 'pages/workout_tracker/workout_tracker_outdoor.dart';
import 'pages/workout_tracker/workout_tracker_favorite.dart';

// Gyms
import 'pages/gyms/gym_list_page.dart';
import 'pages/gyms/gym_map_page.dart';
import 'pages/gyms/trainer_details_page.dart';

// Workout Details
import 'pages/workout_details/workout_details_page.dart';  // class WorkoutDetailsPage
import 'pages/workout_details/workout_details2.dart';      // class WorkoutDetails2Page
import 'pages/workout_details/start_workout.dart';         // class StartWorkoutPage

// Workout Schedule
// (NOTE: these two are NOT in the workout_tracker subfolder, but at the same pages/ level)
import 'pages/workout_schedule.dart';           // class WorkoutSchedulePage
import 'pages/add_workout_schedule.dart';       // class AddWorkoutSchedulePage

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
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
<<<<<<< HEAD
      // Start with the introduction page
      home: const Introduction(),

=======
      // whichever initial screen you prefer
      home: const WorkoutDetailsPage(),
>>>>>>> 749e1343f1c35b30465549d45fe685bc124b4d5b
      routes: {
        // Intro & Start
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
        '/workoutDetails': (context) => const WorkoutDetailsPage(),

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