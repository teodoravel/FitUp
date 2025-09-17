import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fitup/user_session.dart';

class WorkoutTrackerFavoritePage extends StatefulWidget {
  const WorkoutTrackerFavoritePage({super.key});

  @override
  State<WorkoutTrackerFavoritePage> createState() =>
      _WorkoutTrackerFavoritePageState();
}

class _WorkoutTrackerFavoritePageState
    extends State<WorkoutTrackerFavoritePage> {
  bool _notLoggedIn = false;
  bool _isLoading = false;
  List<Map<String, dynamic>> _favWorkouts = [];
  List<Map<String, dynamic>> _favGyms = [];
  List<Map<String, dynamic>> _favTrainers = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    if (!UserSession.isLoggedIn) {
      setState(() => _notLoggedIn = true);
      return;
    }
    setState(() => _isLoading = true);
    final userId = UserSession.userId!;
    try {
      final url = Uri.parse("http://localhost:3000/api/favorites/$userId");
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final j = jsonDecode(resp.body);
        if (j["success"] == true) {
          setState(() {
            _favWorkouts = List<Map<String, dynamic>>.from(j["workouts"] ?? []);
            _favGyms = List<Map<String, dynamic>>.from(j["gyms"] ?? []);
            _favTrainers = List<Map<String, dynamic>>.from(j["trainers"] ?? []);
            _isLoading = false;
          });
        } else {
          setState(() {
            _error = j["error"];
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _error = "Server error: ${resp.statusCode}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = "Network error: $e";
        _isLoading = false;
      });
    }
  }

  Future<void> _removeFavorite(String type, int id) async {
    final userId = UserSession.userId;
    if (userId == null) return;

    try {
      final url = Uri.parse('http://localhost:3000/api/favorites/toggle');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userId,
          "favoriteType": type,
          "favoriteId": id,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result["success"] == true) {
          // Refresh the favorites list
          _fetchFavorites();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("${type.capitalize()} removed from favorites!")),
          );
        }
      }
    } catch (e) {
      // Handle error silently
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_notLoggedIn) {
      return Scaffold(
        body: SafeArea(
          child: Center(child: Text("No user logged in")),
        ),
      );
    }
    if (_isLoading) {
      return const Scaffold(
        body: SafeArea(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
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
                    'Favourites',
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
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: _error != null
                    ? Center(child: Text(_error!))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Workouts",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(height: 12),
                            if (_favWorkouts.isEmpty)
                              _buildEmptyState("No favorite workouts yet")
                            else
                              ..._favWorkouts.map((workout) =>
                                  _buildFavoriteCard(
                                    title: workout['name'] ?? 'Unknown Workout',
                                    subtitle: workout['details'] ?? '',
                                    icon: Icons.fitness_center,
                                    onRemove: () => _removeFavorite(
                                        'workout', workout['id']),
                                  )),
                            const SizedBox(height: 24),
                            const Text("Gyms",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(height: 12),
                            if (_favGyms.isEmpty)
                              _buildEmptyState("No favorite gyms yet")
                            else
                              ..._favGyms.map((gym) => _buildFavoriteCard(
                                    title: gym['name'] ?? 'Unknown Gym',
                                    subtitle: gym['details'] ?? '',
                                    icon: Icons.location_city,
                                    onRemove: () =>
                                        _removeFavorite('gym', gym['id']),
                                  )),
                            const SizedBox(height: 24),
                            const Text("Trainers",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(height: 12),
                            if (_favTrainers.isEmpty)
                              _buildEmptyState("No favorite trainers yet")
                            else
                              ..._favTrainers.map((trainer) =>
                                  _buildFavoriteCard(
                                    title: trainer['name'] ?? 'Unknown Trainer',
                                    subtitle:
                                        "Rating: ${trainer['details'] ?? 'N/A'}",
                                    icon: Icons.person,
                                    onRemove: () => _removeFavorite(
                                        'trainer', trainer['id']),
                                  )),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildFavoriteCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onRemove,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x111D1617),
            blurRadius: 20,
            offset: Offset(0, 5),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF5C315B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF5C315B),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1D1517),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFFA5A3AF),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
