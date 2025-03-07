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
  List<int> _favWorkouts = [];
  List<int> _favGyms = [];
  List<int> _favTrainers = [];
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
          final w = j["workouts"] as List<dynamic>;
          final g = j["gyms"] as List<dynamic>;
          final t = j["trainers"] as List<dynamic>;
          setState(() {
            _favWorkouts = w.map((x) => x as int).toList();
            _favGyms = g.map((x) => x as int).toList();
            _favTrainers = t.map((x) => x as int).toList();
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
                            const SizedBox(height: 6),
                            if (_favWorkouts.isEmpty)
                              const Text("No favorites here"),
                            ..._favWorkouts
                                .map((wid) => Text("Workout ID $wid")),
                            const SizedBox(height: 20),
                            const Text("Gyms",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(height: 6),
                            if (_favGyms.isEmpty)
                              const Text("No favorites here"),
                            ..._favGyms.map((gid) => Text("Gym ID $gid")),
                            const SizedBox(height: 20),
                            const Text("Trainers",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(height: 6),
                            if (_favTrainers.isEmpty)
                              const Text("No favorites here"),
                            ..._favTrainers
                                .map((tid) => Text("Trainer ID $tid")),
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
}
