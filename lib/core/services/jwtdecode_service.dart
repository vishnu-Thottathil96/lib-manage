import 'package:jwt_decoder/jwt_decoder.dart';

class JWTDecoderService {
  // Method to decode the JWT token and return the user ID
  static String? getUserIdFromToken(String token) {
    try {
      // Decode the token to get the payload
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      // Return the user ID if it exists in the token payload
      return decodedToken['id'] as String?;
    } catch (e) {
      print('Error decoding token: $e');
      return null;
    }
  }
}
