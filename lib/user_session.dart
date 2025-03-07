// lib/user_session.dart
class UserSession {
  static int? userId;
  static String? fullName;
  static String? gender;
  static String? dob; // "YYYY-MM-DD"
  static int? heightCm;
  static int? weightKg;

  static bool get isLoggedIn => userId != null;
  static void clear() {
    userId = null;
    fullName = null;
    gender = null;
    dob = null;
    heightCm = null;
    weightKg = null;
  }
}
