import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fitup/user_session.dart';

class RegisterPage2 extends StatefulWidget {
  final String fullName;
  final String email;
  final String password;

  const RegisterPage2({
    Key? key,
    required this.fullName,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final _genderOptions = ['Man', 'Woman', 'Prefer not to answer'];
  String _selectedGender = 'Man';

  DateTime? _selectedDOB;
  final _dobController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  bool _isLoading = false;

  Future<void> _onRegisterPressed() async {
    if (_selectedDOB == null) {
      _showSnackBar('Please pick a date of birth');
      return;
    }
    final heightText = _heightController.text.trim();
    final weightText = _weightController.text.trim();
    if (heightText.isEmpty || weightText.isEmpty) {
      _showSnackBar('Please enter height & weight');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final url = Uri.parse('http://localhost:3000/api/register');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': widget.fullName,
          'email': widget.email,
          'password': widget.password,
          'gender': _selectedGender,
          'dob': _selectedDOB!.toIso8601String().split('T').first,
          'height_cm': int.parse(heightText),
          'weight_kg': int.parse(weightText),
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true) {
          // They returned userId, fullName, etc. Let's store in UserSession:
          UserSession.userId = result['userId'];
          UserSession.fullName = result['fullName'] ?? widget.fullName;
          UserSession.gender = result['gender'] ?? _selectedGender;
          UserSession.dob = result['dob'] ?? _selectedDOB!.toIso8601String();
          UserSession.heightCm = result['height_cm'] ?? int.parse(heightText);
          UserSession.weightKg = result['weight_kg'] ?? int.parse(weightText);

          // Now go to /success or directly /home, your choice:
          Navigator.pushNamed(context, '/success');
        } else {
          _showSnackBar('Registration failed: ${result['error'] ?? '???'}');
        }
      } else {
        _showSnackBar('Error from server: ${response.statusCode}');
      }
    } catch (e) {
      _showSnackBar('Server not reachable? $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _pickDOB() async {
    final now = DateTime.now();
    final oldestAllowed = DateTime(now.year - 100);
    final youngestAllowed = DateTime(now.year - 5);
    final init = DateTime(now.year - 18);

    final picked = await showDatePicker(
      context: context,
      initialDate: init,
      firstDate: oldestAllowed,
      lastDate: youngestAllowed,
    );
    if (picked != null) {
      setState(() {
        _selectedDOB = picked;
        _dobController.text = picked.toIso8601String().split('T').first;
      });
    }
  }

  @override
  void dispose() {
    _dobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Complete Profile (Step 2)',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Center(
                      child: Text(
                        'Help us to know more about you!',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF7B6F72)),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Gender
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      items: _genderOptions.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedGender = val!;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.people_outline),
                        labelText: 'Gender',
                        fillColor: const Color(0xFFF7F8F8),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // DOB
                    TextField(
                      controller: _dobController,
                      readOnly: true,
                      onTap: _pickDOB,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_month),
                        labelText: 'Date of Birth',
                        filled: true,
                        fillColor: const Color(0xFFF7F8F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Height
                    TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.swap_vert),
                        labelText: 'Height (cm)',
                        filled: true,
                        fillColor: const Color(0xFFF7F8F8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Weight
                    TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.fitness_center),
                        labelText: 'Weight (kg)',
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
                  ],
                ),
              ),
      ),
    );
  }
}
