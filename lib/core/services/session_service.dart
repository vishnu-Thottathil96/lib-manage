import 'package:assesment_elt/core/services/jwtdecode_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSessionService {
  // Keys for storing data in SharedPreferences
  static const String _userIdKey = 'user_id';
  static const String _isLoggedInKey = 'is_logged_in';

  // Method to save the user session
  static Future<void> saveUserSession(String token) async {
    String? userId = JWTDecoderService.getUserIdFromToken(token);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId ?? '');
    await prefs.setBool(_isLoggedInKey, true);
  }

  // Method to check if user is logged in
  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Method to get the stored user ID
  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Method to clear the user session data (logout)
  static Future<void> clearUserSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.setBool(_isLoggedInKey, false);
  }
}
