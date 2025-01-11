import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static bool justRegistered = false;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// The same password regex used in register_page1
final RegExp _passwordRegex =
    RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9])[^\s]{8,}$');
// Basic email check
final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePass = true;

  void _onLoginPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (!_emailRegex.hasMatch(email)) {
      _showSnackBar('Please enter a valid email');
      return;
    }
    if (!_passwordRegex.hasMatch(password)) {
      _showSnackBar(
        'Password must be >=8 chars, contain uppercase, digit, special char, and no spaces.',
      );
      return;
    }

    if (LoginPage.justRegistered) {
      LoginPage.justRegistered = false;
      Navigator.pushNamed(context, '/success');
    } else {
      Navigator.pushNamed(context, '/home');
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Color(0xFF1D1517),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: 'Email',
                    filled: true,
                    hintStyle: const TextStyle(
                      color: Color(0xFFB0B0B0), // Lighter gray for fainter hint text
                      fontWeight: FontWeight.w400, // Thinner font weight
                    ),
                    fillColor: const Color(0xFFF7F8F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePass,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePass
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscurePass = !_obscurePass;
                        });
                      },
                    ),
                    hintText: 'Password',
                    filled: true,
                    hintStyle: const TextStyle(
                      color: Color(0xFFB0B0B0), // Lighter gray for fainter hint text
                      fontWeight: FontWeight.w400, // Thinner font weight
                    ),
                    fillColor: const Color(0xFFF7F8F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      _showSnackBar('Forgot password tapped');
                    },
                    child: const Text(
                      'Forgot your password?',
                      style: TextStyle(
                        color: Color(0xFFACA3A5),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 300),

                // Login button
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
                      onPressed: _onLoginPressed,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Login',
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
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600, // Bolder text
                          fontFamily: 'Poppins',
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Handle Google sign-in action here
                      print('Google sign-in clicked');
                    },
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.8, color: const Color(0xFFDDD9DA)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Image.asset('assets/Login-Social-Media.jpg')
                    ),
                  ),
                ),

                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register1');
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don’t have an account yet? ',
                            style: TextStyle(
                              color: Color(0xFF1D1517),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              color: Color(0xFF5C315B),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
