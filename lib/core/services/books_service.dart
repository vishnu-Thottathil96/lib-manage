import 'dart:convert';
import 'package:assesment_elt/config/api_config.dart';
import 'package:assesment_elt/core/models/book.dart';
import 'package:assesment_elt/core/models/author.dart';
import 'package:http/http.dart' as http;

class BookService {
  final String baseUrl = ApiConfig.baseUrl + ApiConfig.fetchBooks;

  // Fetches a list of books
  Future<List<Book>> fetchBooks({required int page, required int limit}) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl?page=$page&limit=$limit'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['result'];
        return data.map((bookJson) => Book.fromJson(bookJson)).toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  //
  Future<Book> fetchBookById(String bookId) async {
    final response = await http.get(Uri.parse('$baseUrl/$bookId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Book.fromJson(data['result']);
    } else {
      throw Exception('Failed to load book');
    }
  }
  //

  Future<Author> fetchAuthorById(String authorId) async {
    final authorUrl = '${ApiConfig.baseUrl}${ApiConfig.fetchAuthors}/$authorId';
    final response = await http.get(Uri.parse(authorUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print('Author data: $data'); // Debug line to verify response structure
      return Author.fromJson(data);
    } else {
      throw Exception('Failed to load author');
    }
  }
}
