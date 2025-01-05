import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Properly formatted times:
  final List<String> _workoutOptions = [
    '10 min',
    '30 min',
    '1h',
    '1h 30min',
    '2h',
    '2h 30min',
    '3h',
    '3h 30min',
    '4h',
  ];
  String _selectedWorkout = '1h'; // default choice

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // Same style as Profile: fill screen, white background, round corners
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: back arrow + "Account Details"
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text(
                      'Account Details',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
                const SizedBox(height: 10),

                Divider(color: Colors.grey.shade300),
                ListTile(
                  title: const Text(
                    'Name',
                    style: TextStyle(
                      color: Color(0xFF202325),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Stefani Warren',
                        style: TextStyle(
                          color: Color(0xFF202325),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),

                ListTile(
                  title: const Text(
                    'Gender',
                    style: TextStyle(
                      color: Color(0xFF202325),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Female',
                        style: TextStyle(
                          color: Color(0xFF202325),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),

                ListTile(
                  title: const Text(
                    'Age',
                    style: TextStyle(
                      color: Color(0xFF202325),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        '27',
                        style: TextStyle(
                          color: Color(0xFF202325),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),

                ListTile(
                  title: const Text(
                    'Height',
                    style: TextStyle(
                      color: Color(0xFF202325),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        '173 cm',
                        style: TextStyle(
                          color: Color(0xFF202325),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),

                ListTile(
                  title: const Text(
                    'Weight',
                    style: TextStyle(
                      color: Color(0xFF202325),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        '53 kg',
                        style: TextStyle(
                          color: Color(0xFF202325),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),

                // The updated "Work out goal" dropdown
                ListTile(
                  title: const Text(
                    'Work out goal',
                    style: TextStyle(
                      color: Color(0xFF202325),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedWorkout,
                      items: _workoutOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Color(0xFF202325),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _selectedWorkout = newVal!;
                        });
                      },
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                ),
                Divider(color: Colors.grey.shade300),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
