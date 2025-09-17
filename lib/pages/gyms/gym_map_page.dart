import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitup/user_session.dart';

class GymMapPage extends StatefulWidget {
  const GymMapPage({super.key});

  @override
  State<GymMapPage> createState() => _GymMapPageState();
}

class _GymMapPageState extends State<GymMapPage> {
  final MapController _mapController = MapController();
  int _gymId = 0;
  String _gymName = "Gym X";
  bool _isFavorite = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _gymId = args["gymId"] ?? 0;
      _gymName = args["gymName"] ?? "Gym X";
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
            fav['favorite_type'] == 'gym' && fav['favorite_id'] == _gymId);
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
          "favoriteType": "gym",
          "favoriteId": _gymId,
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
      // We show the gym name, heart, etc.
      appBar: AppBar(
        title: Text(_gymName),
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(42.00378, 21.41103),
                  zoom: 16.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                    userAgentPackageName: 'com.example.fitup',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(42.00378, 21.41103),
                        width: 40,
                        height: 40,
                        builder: (context) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
