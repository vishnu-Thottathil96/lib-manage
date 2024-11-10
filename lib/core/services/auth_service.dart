import 'dart:convert';
import 'package:assesment_elt/config/api_config.dart';
import 'package:assesment_elt/core/services/user_data.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = ApiConfig.baseUrl;
  static const String registerEndpoint =
      ApiConfig.register; // The endpoint for registration
  static const String loginEndpoint = ApiConfig.login; // The endpoint for login

  // Method for user registration
  Future<Map<String, dynamic>> registerUser(
      String username, String password) async {
    final Uri registerUrl = Uri.parse(baseUrl + registerEndpoint);
    final Uri loginrUrl = Uri.parse(baseUrl + loginEndpoint);

    // Prepare the request body
    final Map<String, String> body = {
      'username': username,
      'password': password,
    };

    try {
      // Make the POST request
      final response = await http.post(
        registerUrl,
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
      } else if (response.statusCode == 400) {
        //
        try {
          // Make the POST request for login
          final response = await http.post(
            loginrUrl,
            headers: {
              'Content-Type':
                  'application/json', // Set the content type to JSON
            },
            body: json.encode(body), // Convert the body to JSON
          );

          // Check if the response is successful
          if (response.statusCode == 201) {
            // Parse the JSON response
            final Map<String, dynamic> data = json.decode(response.body);

            // Log the access token to the console
            String accessToken = data['result']['access_token'];
            print('login successful! Access token: $accessToken');

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
        //
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

// import 'dart:convert';
// import 'dart:developer';
// import 'package:assesment_elt/config/api_config.dart';
// import 'package:assesment_elt/core/services/user_data.dart';
// import 'package:http/http.dart' as http;

// class AuthService {
//   static const String baseUrl = ApiConfig.baseUrl;
//   static const String registerEndpoint =
//       ApiConfig.register; // Registration endpoint
//   static const String loginEndpoint = ApiConfig.login; // Login endpoint

//   // Method for user registration
//   Future<Map<String, dynamic>> registerUser(
//       String username, String password) async {
//     final Uri url = Uri.parse(baseUrl + registerEndpoint);

//     // Prepare the request body
//     final Map<String, String> body = {
//       'username': username,
//       'password': password,
//     };

//     try {
//       // Make the POST request for registration
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(body),
//       );

//       // Check if the response is successful
//       if (response.statusCode == 201) {
//         // Registration successful, return the access token
//         final Map<String, dynamic> data = json.decode(response.body);
//         String accessToken = data['result']['access_token'];
//         print('Registration successful! Access token: $accessToken');
//         return {
//           'status': 'success',
//           'access_token': accessToken, // Return the access token
//         };
//       } else if (response.statusCode == 400) {
//         // If username is already taken, attempt to log in
//         final Map<String, dynamic> data = json.decode(response.body);
//         if (data['message'].contains('has been taken')) {
//           // Try to log in with the same credentials
//           return await loginUser(username, password);
//         }
//         // Handle other error cases
//         return {
//           'status': 'error',
//           'message': data['message'] ?? 'Unknown error',
//         };
//       } else {
//         // Handle unexpected status codes
//         final Map<String, dynamic> data = json.decode(response.body);
//         return {
//           'status': 'error',
//           'message': data['message'] ?? 'Unknown error',
//         };
//       }
//     } catch (e) {
//       // Catch any errors during the API call
//       return {
//         'status': 'error',
//         'message': 'Failed to connect to the server',
//       };
//     }
//   }

//   // Method for user login (with the same username and password)
//   Future<Map<String, dynamic>> loginUser(
//       String username, String password) async {
//     final Uri url = Uri.parse(baseUrl + loginEndpoint);

//     // Prepare the request body
//     final Map<String, String> body = {
//       'username': username,
//       'password': password,
//     };

//     try {
//       // Make the POST request for login
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(body),
//       );

//       // Check if the response is successful
//       if (response.statusCode == 200) {
//         // Login successful, return the access token
//         final Map<String, dynamic> data = json.decode(response.body);
//         String accessToken = data['result']['access_token'];
//         log('Login successful! Access token: $accessToken');
//         return {
//           'status': 'success',
//           'access_token': accessToken, // Return the access token
//         };
//       } else {
//         // Handle login failure
//         final Map<String, dynamic> data = json.decode(response.body);
//         return {
//           'status': 'error',
//           'message': data['message'] ?? 'Unknown error',
//         };
//       }
//     } catch (e) {
//       // Catch any errors during the API call
//       return {
//         'status': 'error',
//         'message': 'Failed to connect to the server',
//       };
//     }
//   }
// }




















///
// import 'dart:convert';
// import 'package:assesment_elt/config/api_config.dart';
// import 'package:assesment_elt/core/services/user_data.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;

// // Authentication service
// class AuthService {
//   static const String baseUrl = ApiConfig.baseUrl;
//   static const String registerEndpoint = ApiConfig.register;

//   // Register user method
//   Future<Map<String, dynamic>> registerUser(
//       String username, String password) async {
//     final Uri url = Uri.parse(baseUrl + registerEndpoint);
//     final Map<String, String> body = {
//       'username': username,
//       'password': password,
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(body),
//       );

//       if (response.statusCode == 201) {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return {
//           'status': 'success',
//           'access_token': data['result']['access_token'],
//         };
//       } else {
//         final Map<String, dynamic> data = json.decode(response.body);
//         return {
//           'status': 'error',
//           'message': data['message'] ?? 'Unknown error'
//         };
//       }
//     } catch (e) {
//       return {'status': 'error', 'message': 'Failed to connect to the server'};
//     }
//   }
// }

// // State management for registration
// class RegistrationNotifier extends StateNotifier<AsyncValue<void>> {
//   final AuthService _authService;

//   RegistrationNotifier(this._authService) : super(const AsyncValue.data(null));

//   Future<void> register(String username, String password) async {
//     state = const AsyncValue.loading();
//     final result = await _authService.registerUser(username, password);

//     if (result['status'] == 'success') {
//       // Save session or token if registration succeeds
//       await SecureStorageService.saveAccessToken(result['access_token']);
//       state = const AsyncValue.data(null);
//     } else {
//       state = AsyncValue.error(
//           result['message'] ?? 'Registration failed', StackTrace.current);
//     }
//   }
// }

// // Provider for the auth service and registration state
// final authServiceProvider = Provider((ref) => AuthService());
// final registrationProvider =
//     StateNotifierProvider<RegistrationNotifier, AsyncValue<void>>(
//   (ref) => RegistrationNotifier(ref.watch(authServiceProvider)),
// );
