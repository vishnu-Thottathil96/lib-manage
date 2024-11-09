import 'dart:convert';
import 'package:assesment_elt/config/api_config.dart';
import 'package:assesment_elt/core/services/user_data.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = ApiConfig.baseUrl;
  static const String registerEndpoint =
      ApiConfig.register; // The endpoint for registration

  // Method for user registration
  Future<Map<String, dynamic>> registerUser(
      String username, String password) async {
    final Uri url = Uri.parse(baseUrl + registerEndpoint);

    // Prepare the request body
    final Map<String, String> body = {
      'username': username,
      'password': password,
    };

    try {
      // Make the POST request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: json.encode(body), // Convert the body to JSON
      );

      // Check if the response is successful
      if (response.statusCode == 201) {
        // Parse the JSON response
        final Map<String, dynamic> data = json.decode(response.body);

        // Log the access token to the console
        String accessToken = data['result']['access_token'];
        print('Registration successful! Access token: $accessToken');

        return {
          'status': 'success',
          'access_token':
              accessToken, // Return the access token in case it's needed elsewhere
        };
      } else {
        // Handle error
        final Map<String, dynamic> data = json.decode(response.body);
        return {
          'status': 'error',
          'message': data['message'] ?? 'Unknown error',
        };
      }
    } catch (e) {
      // Catch any errors during the API call
      return {
        'status': 'error',
        'message': 'Failed to connect to the server',
      };
    }
  }
}
