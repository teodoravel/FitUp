import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({super.key});

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final _genderOptions = ['Woman', 'Man', 'Prefer not to answer'];
  String _selectedGender = 'Woman';

  DateTime? _selectedDOB;
  final _dobController = TextEditingController();

  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  static const double minHeight = 50;
  static const double maxHeight = 250;
  static const double minWeight = 3;
  static const double maxWeight = 300;

  Future<void> _pickDOB() async {
    final now = DateTime.now();
    final oldestYoung = DateTime(now.year - 13, now.month, now.day);
    final oldestAllowed = DateTime(now.year - 100, now.month, now.day);

    final init = _selectedDOB ?? DateTime(now.year - 20);
    final picked = await showDatePicker(
      context: context,
      initialDate: init,
      firstDate: oldestAllowed,
      lastDate: oldestYoung,
    );
    if (picked != null) {
      setState(() {
        _selectedDOB = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _onNextPressed() {
    if (_selectedDOB == null) {
      _showSnackBar('Please select your date of birth');
      return;
    }

    final weightText = _weightController.text.trim();
    final heightText = _heightController.text.trim();

    if (!_isNumeric(weightText)) {
      _showSnackBar('Please enter a valid weight');
      return;
    }
    if (!_isNumeric(heightText)) {
      _showSnackBar('Please enter a valid height');
      return;
    }

    final weightVal = double.parse(weightText);
    final heightVal = double.parse(heightText);

    if (weightVal < minWeight || weightVal > maxWeight) {
      _showSnackBar('Weight must be between $minWeight kg and $maxWeight kg');
      return;
    }
    if (heightVal < minHeight || heightVal > maxHeight) {
      _showSnackBar('Height must be between $minHeight cm and $maxHeight cm');
      return;
    }

    Navigator.pushNamed(context, '/success');
  }

  bool _isNumeric(String s) {
    final val = double.tryParse(s);
    return (val != null && val > 0);
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  bool _isMetric = true;

  @override
  void dispose() {
    _dobController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                'Let’s complete your profile',
                style: TextStyle(
                  color: Color(0xFF1D1517),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'It will help us to know more about you!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7B6F72),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),

              // Gender
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: _genderOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    _selectedGender = newVal!;
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
                  labelText: 'Date of Birth',
                  prefixIcon: const Icon(Icons.calendar_month),
                  fillColor: const Color(0xFFF7F8F8),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Weight
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.scale_outlined),
                        labelText: _isMetric ? 'Weight (kg)' : 'Weight (lbs)',
                        fillColor: const Color(0xFFF7F8F8),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isMetric = !_isMetric;
                      });
                    },
                    icon: const Icon(Icons.swap_horiz),
                    color: Colors.white,
                    iconSize: 20,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF8D35B6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Height
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.swap_vert),
                        labelText: _isMetric ? 'Height (cm)' : 'Height (in)',
                        fillColor: const Color(0xFFF7F8F8),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isMetric = !_isMetric;
                      });
                    },
                    icon: const Icon(Icons.swap_horiz),
                    color: Colors.white,
                    iconSize: 20,
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF8D35B6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 350),

              // Next
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
                  onPressed: _onNextPressed,
                  child: const Text(
                    'Next',
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
    );
  }
}
