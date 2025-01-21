import 'package:flutter/material.dart';

// A regex enforcing:
// - at least one uppercase [A-Z]
// - at least one digit \d
// - at least one special char [^A-Za-z0-9] or a curated set
// - at least 8 chars total
// - no whitespace
final RegExp _passwordRegex =
    RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9])[^\s]{8,}$');
// Basic email check
final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({super.key});

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onRegisterPressed() {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Simple checks
    if (fullName.isEmpty) {
      _showSnackBar('Please enter your full name');
      return;
    }
    if (email.isEmpty) {
      _showSnackBar('Please enter your email');
      return;
    }
    if (!_emailRegex.hasMatch(email)) {
      _showSnackBar('Invalid email format');
      return;
    }
    if (!_passwordRegex.hasMatch(password)) {
      _showSnackBar(
        'Password must be >=8 chars, contain uppercase, digit, special char, and no spaces.',
      );
      return;
    }

    Navigator.pushNamed(context, '/register2');
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: const Text(
                  'Create an Account',
                  style: TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Full Name
              TextField(
                controller: _fullNameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline),
                  hintText: 'Full Name',
                  filled: true,
                  fillColor: const Color(0xFFF7F8F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: 'Email',
                  filled: true,
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
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color(0xFFF7F8F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Register button
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
                    onPressed: _onRegisterPressed,
                    child: const Text(
                      'Register',
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
              const SizedBox(height: 20),

              // Or
              const Center(child: Text('Or')),
              const SizedBox(height: 20),

              // Google sign in icon placeholder
              Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 0.8, color: const Color(0xFFDDD9DA)),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.g_mobiledata, size: 32),
                ),
              ),
              const SizedBox(height: 20),

              // Already have an account?
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            color: Color(0xFF1D1517),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        TextSpan(
                          text: 'Login',
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
    );
  }
}
