import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fitup/user_session.dart';

class TrainerDetailsPage extends StatefulWidget {
  const TrainerDetailsPage({super.key});

  @override
  State<TrainerDetailsPage> createState() => _TrainerDetailsPageState();
}

class _TrainerDetailsPageState extends State<TrainerDetailsPage> {
  int _trainerId = 0;
  String _trainerName = "Trainer 1";
  bool _isFavorite = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _trainerId = args["trainerId"] ?? 0;
      _trainerName = args["trainerName"] ?? "Trainer 1";
      _checkIfFavorite();
    }
  }

  Future<void> _checkIfFavorite() async {
    if (!UserSession.isLoggedIn) return;

    try {
      final userId = UserSession.userId!;
      final url = Uri.parse('http://localhost:3000/api/favorites/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List favorites = jsonDecode(response.body);
        final isFav = favorites.any((fav) =>
            fav['favorite_type'] == 'trainer' &&
            fav['favorite_id'] == _trainerId);
        setState(() => _isFavorite = isFav);
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _toggleFavorite() async {
    if (!UserSession.isLoggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in first")),
      );
      return;
    }

    setState(() => _isLoading = true);

    final userId = UserSession.userId!;
    try {
      final url = Uri.parse('http://localhost:3000/api/favorites/toggle');
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": userId,
          "favoriteType": "trainer",
          "favoriteId": _trainerId,
        }),
      );

      if (resp.statusCode == 200) {
        final j = jsonDecode(resp.body);
        if (j["success"] == true) {
          setState(() {
            _isFavorite = j["action"] == "added";
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(j["action"] == "added"
                    ? "Added to favorites!"
                    : "Removed from favorites!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${j['error']}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server error: ${resp.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Network error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_trainerName),
        backgroundColor: const Color(0xB65C315B),
        actions: [
          IconButton(
            icon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : Colors.white,
                  ),
            onPressed: _isLoading ? null : _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // ... your older trainer design
            Text(
              _trainerName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1517),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Expert fitness trainer with years of experience in helping clients achieve their fitness goals.",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFA5A3AF),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Add more trainer details here as needed
          ],
        ),
      ),
    );
  }
}
