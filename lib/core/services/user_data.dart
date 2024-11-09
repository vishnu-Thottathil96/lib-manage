import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Initialize secure storage
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Method to save the access token to secure storage
  static Future<void> saveAccessToken(String token) async {
    try {
      await _secureStorage.write(key: 'access_token', value: token);
      print('Successfully stored the token');
    } catch (e) {
      print("Error saving access token: $e");
    }
  }

  // Method to retrieve the access token from secure storage
  static Future<String?> getAccessToken() async {
    try {
      return await _secureStorage.read(key: 'access_token');
    } catch (e) {
      print("Error retrieving access token: $e");
      return null;
    }
  }

  // Method to delete the access token from secure storage
  static Future<void> deleteAccessToken() async {
    try {
      await _secureStorage.delete(key: 'access_token');
    } catch (e) {
      print("Error deleting access token: $e");
    }
  }
}
