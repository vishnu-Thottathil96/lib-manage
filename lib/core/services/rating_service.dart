import 'dart:convert';
import 'package:assesment_elt/config/api_config.dart';
import 'package:http/http.dart' as http;

class RatingService {
  static Future<Map<String, dynamic>> addRating({
    required String bookId,
    required int rating,
    required String jwtToken,
  }) async {
    const String baseUrl = ApiConfig.baseUrl;
    final String endpoint = 'api/books/$bookId/ratings:add';
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode({
          'rating': rating,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'statusCode': response.statusCode,
          'message': 'Failed to add rating',
          'error': response.body,
        };
      }
    } catch (error) {
      return {
        'statusCode': 500,
        'message': 'An error occurred',
        'error': error.toString(),
      };
    }
  }
}
