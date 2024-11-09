import 'package:intl/intl.dart';

class Book {
  final String id;
  final String title;
  final String description;
  final String authorId;
  final String coverPictureURL;
  final double price;
  final int starCount;
  final List<dynamic> ratings;
  final String publishedDate;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    required this.coverPictureURL,
    required this.price,
    required this.starCount,
    required this.ratings,
    required this.publishedDate,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Untitled',
      description: json['description'] ?? 'No description',
      authorId: json['authorId'] ?? '',
      coverPictureURL: json['coverPictureURL'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      starCount: json['starCount'] ?? 0,
      ratings:
          (json['ratings'] as List<dynamic>?)?.map((e) => e).toList() ?? [],
      publishedDate: json['publishedDate'] ?? 'N/A',
    );
  }
  String get formattedPublishedDate {
    try {
      DateTime date = DateTime.parse(publishedDate);
      return DateFormat('yyyy-MM-dd')
          .format(date); // Format to display only date
    } catch (e) {
      return 'Invalid Date'; // In case of an invalid date format
    }
  }
}
