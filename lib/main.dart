import 'package:flutter/material.dart';
import 'pages/register_page1.dart';
import 'pages/register_page2.dart';
import 'pages/login_page.dart';
import 'pages/success_registration_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/account_page.dart';

// Import your new tracker pages:
import 'pages/workout_tracker_indoor.dart';
import 'pages/workout_tracker_outdoor.dart';
import 'pages/workout_tracker_favorite.dart';

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
      // whichever initial screen you prefer
      home: const RegisterPage1(),
      routes: {
        '/register1': (context) => const RegisterPage1(),
        '/register2': (context) => const RegisterPage2(),
        '/login': (context) => const LoginPage(),
        '/success': (context) => const SuccessRegistrationPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/account': (context) => const AccountPage(),

        // IMPORTANT
        '/workoutIndoor': (context) => const WorkoutTrackerIndoorPage(),
        '/workoutOutdoor': (context) => const WorkoutTrackerOutdoorPage(),
        '/workoutFavorite': (context) => const WorkoutTrackerFavoritePage(),
      },
    );
  }
}
