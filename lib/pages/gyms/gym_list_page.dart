import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fitup/user_session.dart';
import '../gyms/gym_map_page.dart';
import '../gyms/trainer_details_page.dart';

class GymListPage extends StatefulWidget {
  const GymListPage({Key? key}) : super(key: key);

  @override
  State<GymListPage> createState() => _GymListPageState();
}

class _GymListPageState extends State<GymListPage> {
  bool _isLoading = false;
  Map<String, bool> _gymFavorites = {};
  Map<String, bool> _trainerFavorites = {};

  // Example: default local lists
  final List<Map<String, dynamic>> _gymsNearYou = [
    {"id": -1, "name": "Your gym"},
    {"id": -2, "name": "Local gym"},
  ];

  final List<Map<String, dynamic>> _allGyms = [
    {"id": 1, "name": "Gym 1", "location": "Location A"},
    {"id": 2, "name": "Gym 2", "location": "Location B"},
    {"id": 3, "name": "Gym 3", "location": "Location"},
  ];

  final List<Map<String, dynamic>> _trainers = [
    {"id": 1, "name": "Trainer 1", "rating": 4.5},
    {"id": 2, "name": "Trainer 2", "rating": 4.0},
  ];

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatuses();
  }

  Future<void> _loadFavoriteStatuses() async {
    final userId = UserSession.userId;
    if (userId == null) return;

    try {
      // Check gym favorites
      for (var gym in _allGyms) {
        final gymId = gym["id"] as int;
        final url = Uri.parse(
            'http://localhost:3000/api/favorites/check/$userId/gym/$gymId');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          if (result['success'] == true) {
            setState(() {
              _gymFavorites['gym_$gymId'] = result['isFavorite'] ?? false;
            });
          }
        }
      }

      // Check trainer favorites
      for (var trainer in _trainers) {
        final trainerId = trainer["id"] as int;
        final url = Uri.parse(
            'http://localhost:3000/api/favorites/check/$userId/trainer/$trainerId');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          if (result['success'] == true) {
            setState(() {
              _trainerFavorites['trainer_$trainerId'] =
                  result['isFavorite'] ?? false;
            });
          }
        }
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _toggleGymFavorite(int gymId) async {
    final userId = UserSession.userId;
    if (userId == null) {
      _showSnackBar("Please log in first");
      return;
    }
    setState(() => _isLoading = true);
    try {
      final url = Uri.parse('http://localhost:3000/api/favorites/toggle');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userId,
          "favoriteType": "gym",
          "favoriteId": gymId,
        }),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result["success"] == true) {
          setState(() {
            _gymFavorites['gym_$gymId'] = result['isFavorite'] ?? false;
          });
          _showSnackBar(result['action'] == 'added'
              ? "Gym added to favorites!"
              : "Gym removed from favorites!");
        } else {
          _showSnackBar("Server error: ${result['error'] ?? 'unknown'}");
        }
      } else {
        _showSnackBar("Server error: ${response.statusCode}");
      }
    } catch (e) {
      _showSnackBar("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleTrainerFavorite(int trainerId) async {
    final userId = UserSession.userId;
    if (userId == null) {
      _showSnackBar("Please log in first");
      return;
    }
    setState(() => _isLoading = true);
    try {
      final url = Uri.parse('http://localhost:3000/api/favorites/toggle');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userId,
          "favoriteType": "trainer",
          "favoriteId": trainerId,
        }),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result["success"] == true) {
          setState(() {
            _trainerFavorites['trainer_$trainerId'] =
                result['isFavorite'] ?? false;
          });
          _showSnackBar(result['action'] == 'added'
              ? "Trainer added to favorites!"
              : "Trainer removed from favorites!");
        } else {
          _showSnackBar("Server error: ${result['error'] ?? 'unknown'}");
        }
      } else {
        _showSnackBar("Server error: ${response.statusCode}");
      }
    } catch (e) {
      _showSnackBar("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 40, bottom: 20),
                    decoration: const BoxDecoration(
                      color: Color(0xB65C315B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F8F8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios, size: 16),
                            color: Colors.black,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Gyms',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            height: 1.50,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // White container area
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      children: [
                        // "Gyms near you"
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 42, 30, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _titleSeeMoreRow('Gyms near you'),
                              const SizedBox(height: 10),
                              // placeholder
                              for (var nearGym in _gymsNearYou) ...[
                                _upcomingCard(
                                  title: nearGym["name"],
                                  subtitle: "",
                                  onTap: () {},
                                ),
                                const SizedBox(height: 16),
                              ],
                            ],
                          ),
                        ),
                        // All gyms
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _titleSeeMoreRow('All gyms'),
                              const SizedBox(height: 10),
                              // Each gym
                              for (var g in _allGyms) ...[
                                _customGymCard(
                                  gymId: g["id"] as int,
                                  gymName: g["name"] as String,
                                  location: g["location"] as String,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ],
                          ),
                        ),
                        // Personal Trainers
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _titleSeeMoreRow('Personal Trainers'),
                              const SizedBox(height: 10),
                              for (var t in _trainers) ...[
                                _customTrainerCard(
                                  trainerId: t["id"] as int,
                                  trainerName: t["name"] as String,
                                  rating: t["rating"] as double,
                                ),
                                const SizedBox(height: 20),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _customGymCard({
    required int gymId,
    required String gymName,
    required String location,
  }) {
    final isFavorite = _gymFavorites['gym_$gymId'] ?? false;

    return Container(
      width: double.infinity,
      height: 132,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF5C315B).withOpacity(0.20),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gymName,
                  style: const TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  location,
                  style: const TextStyle(
                    color: Color(0xFF6B6B6B),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: Opacity(
              opacity: 0.50,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GymMapPage()),
                );
              },
              child: Container(
                width: 94,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "See on map",
                  style: TextStyle(
                    color: Color(0xFF5C315B),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 15,
            child: GestureDetector(
              onTap: () => _toggleGymFavorite(gymId),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customTrainerCard({
    required int trainerId,
    required String trainerName,
    required double rating,
  }) {
    final isFavorite = _trainerFavorites['trainer_$trainerId'] ?? false;

    return Container(
      width: double.infinity,
      height: 132,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF5C315B).withOpacity(0.20),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trainerName,
                  style: const TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "$rating ☆",
                  style: const TextStyle(
                    color: Color(0xFF6B6B6B),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: Opacity(
              opacity: 0.50,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TrainerDetailsPage(),
                    settings: RouteSettings(
                      arguments: {
                        'trainerId': trainerId,
                        'trainerName': trainerName,
                      },
                    ),
                  ),
                );
              },
              child: Container(
                width: 94,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Contact",
                  style: TextStyle(
                    color: Color(0xFF5C315B),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 15,
            child: GestureDetector(
              onTap: () => _toggleTrainerFavorite(trainerId),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ... existing helper methods ...
  Widget _titleSeeMoreRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1D1517),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 1.50,
          ),
        ),
        const Text(
          'See more',
          style: TextStyle(
            color: Color(0xFFA5A3AF),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            height: 1.50,
          ),
        ),
      ],
    );
  }

  Widget _upcomingCard({
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x111D1617),
              blurRadius: 40,
              offset: Offset(0, 10),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Opacity(
              opacity: 0.30,
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFFA5A3AF),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
