// success_registration_page.dart
import 'package:flutter/material.dart';
import 'package:fitup/user_session.dart';

class SuccessRegistrationPage extends StatelessWidget {
  const SuccessRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = UserSession.fullName ?? "User";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Text(
                  'Welcome, $userName',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 214,
                  child: Text(
                    'You are all set now, let’s reach your goals together with us',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF7B6F72),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 250),
                SizedBox(
                  width: 315,
                  height: 60,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF5C315B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: const Text(
                      'Go To Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
