// lib/pages/home_and_profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:fitup/user_session.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = UserSession.fullName ?? "No name yet";

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
                // top row
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
                const SizedBox(height: 10),

                // Centered user name
                Center(
                  child: Text(
                    userName,
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 40,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Profile Picture Placeholder
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(
                      Icons.person_outline_rounded,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Example menu items
                _menuTile(
                  icon: Icons.fitness_center,
                  title: 'Trainings',
                  onTap: () {},
                ),
                Divider(color: Colors.grey.shade300),
                _menuTile(
                  icon: Icons.person_outline,
                  title: 'Account',
                  onTap: () {
                    Navigator.pushNamed(context, '/account');
                  },
                ),
                Divider(color: Colors.grey.shade300),
                _menuTile(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {},
                ),
                Divider(color: Colors.grey.shade300),
                _menuTile(
                  icon: Icons.support_agent,
                  title: 'Support',
                  onTap: () {},
                ),
                Divider(color: Colors.grey.shade300),
                _menuTile(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  onTap: () {},
                ),
                Divider(color: Colors.grey.shade300),

                const Spacer(),
                Center(
                  child: InkWell(
                    onTap: () {
                      // Log out
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        color: Color(0xFFD3180C),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
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

  Widget _menuTile(
      {required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF202325),
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
