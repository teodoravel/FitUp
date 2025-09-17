import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fitup/user_session.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? _name;
  String? _email;
  String? _gender;
  String? _dob; // "YYYY-MM-DD"
  int? _heightCm;
  int? _weightKg;

  bool _isLoading = false;
  bool _notLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    if (!UserSession.isLoggedIn) {
      setState(() => _notLoggedIn = true);
      return;
    }
    setState(() => _isLoading = true);

    final userId = UserSession.userId!;
    try {
      final url = Uri.parse('http://localhost:3000/api/userdetails/$userId');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['error'] != null) {
          setState(() {
            _notLoggedIn = true;
            _isLoading = false;
          });
        } else {
          setState(() {
            _name = result['fullName'] as String?;
            _email = result['email'] as String?;
            _gender = result['gender'] as String?;
            _dob = result['dob'] as String?;
            _heightCm = result['height_cm'] as int?;
            _weightKg = result['weight_kg'] as int?;
            _isLoading = false;
          });
        }
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_notLoggedIn) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Text("No user logged in."),
          ),
        ),
      );
    }
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // Compute an Age if you want:
    String ageString = "Not set";
    if (_dob != null && _dob!.isNotEmpty) {
      try {
        final parsed = DateTime.parse(_dob!);
        final now = DateTime.now();
        int age = now.year - parsed.year;
        final hadBirthday = (now.month > parsed.month) ||
            (now.month == parsed.month && now.day >= parsed.day);
        if (!hadBirthday) age--;
        ageString = "$age";
      } catch (_) {}
    }

    final showName = _name ?? "Unknown";
    final showEmail = _email ?? "Unknown";
    final showGender = _gender ?? "Unknown";
    final showHeight = _heightCm ?? 0;
    final showWeight = _weightKg ?? 0;

    // Example older design with ListTiles:
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                // Top row
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
                  title: const Text('Name'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(showName),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),

                ListTile(
                  title: const Text('Email'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(showEmail),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),

                ListTile(
                  title: const Text('Gender'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(showGender),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),

                ListTile(
                  title: const Text('Age'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(ageString),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),

                ListTile(
                  title: const Text('Height'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("$showHeight cm"),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),

                ListTile(
                  title: const Text('Weight'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("$showWeight kg"),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
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
