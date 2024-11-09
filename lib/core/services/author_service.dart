import 'dart:convert';
import 'package:assesment_elt/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:assesment_elt/core/models/author.dart';

class AuthorService {
  final String apiUrl = ApiConfig.baseUrl +
      ApiConfig.fetchAuthors; // API URL to fetch the authors

  Future<List<AuthorModel>> fetchAuthors() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the JSON data from the API response
      final List<dynamic> data = json.decode(response.body)['result'];
      return data.map((json) => AuthorModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load authors');
    }
  }
}
