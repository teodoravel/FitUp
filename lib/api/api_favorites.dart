import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoritesAPI {
  static Future<Map<String, dynamic>> toggleFavorite(
      int userId, String favType, int favId) async {
    final url = Uri.parse('http://localhost:3000/api/favorites/toggle');
    try {
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'favoriteType': favType, // 'workout'/'gym'/'trainer'
          'favoriteId': favId
        }),
      );
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      }
      return {'success': false, 'error': 'Server error: ${resp.statusCode}'};
    } catch (e) {
      return {'success': false, 'error': 'Network error: $e'};
    }
  }

  static Future<bool> addFavorite(int userId, String favType, int favId) async {
    final url = Uri.parse('http://localhost:3000/api/favorites');
    try {
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'favoriteType': favType, // 'workout'/'gym'/'trainer'
          'favoriteId': favId
        }),
      );
      if (resp.statusCode == 200) {
        // We can parse JSON if we want
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> removeFavorite(
      int userId, String favType, int favId) async {
    final url = Uri.parse('http://localhost:3000/api/favorites');
    try {
      final resp = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'userId': userId, 'favoriteType': favType, 'favoriteId': favId}),
      );
      if (resp.statusCode == 200) {
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getFavorites(int userId) async {
    final url = Uri.parse('http://localhost:3000/api/favorites/$userId');
    try {
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final List data = jsonDecode(resp.body);
        // each item is { 'favorite_type':..., 'favorite_id':... }
        return data.map((e) => e as Map<String, dynamic>).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }
}
