import 'package:assesment_elt/core/models/author.dart';
import 'package:assesment_elt/core/models/book.dart';
import 'package:assesment_elt/core/services/books_service.dart';
import 'package:assesment_elt/features/books/widgets/book_description.dart';
import 'package:assesment_elt/features/books/widgets/book_image.dart';
import 'package:assesment_elt/features/books/widgets/book_info.dart';
import 'package:assesment_elt/features/books/widgets/bottom_section.dart';
import 'package:flutter/material.dart';
import 'package:assesment_elt/config/app_router.dart';

class BookDetailScreen extends StatelessWidget {
  final String bookId; // Pass the bookId to fetch the correct book details
  final String starCount;
  const BookDetailScreen({
    super.key,
    required this.bookId,
    required this.starCount,
  });
  Future<Author> _fetchAuthorName(Book book) async {
    return await BookService().fetchAuthorById(book.authorId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            AppRouter().goToLanding(context);
          },
        ),
      ),
      body: FutureBuilder<Book>(
        future: BookService().fetchBookById(bookId),
        builder: (context, bookSnapshot) {
          if (bookSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (bookSnapshot.hasError) {
            return Center(child: Text('Error: ${bookSnapshot.error}'));
          } else if (bookSnapshot.hasData) {
            final book = bookSnapshot.data!;
            return FutureBuilder<Author>(
              future: _fetchAuthorName(book),
              builder: (context, authorSnapshot) {
                if (authorSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (authorSnapshot.hasError) {
                  return Center(child: Text('Error: ${authorSnapshot.error}'));
                } else if (authorSnapshot.hasData) {
                  final author = authorSnapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BookImageContainer(coverImageUrl: book.coverPictureURL),
                      BookInfoSection(
                        title: book.title,
                        author: author.name, // Display author's name
                        publishedDate:
                            book.formattedPublishedDate, // Use formatted date,
                        price: book.price,
                        rating: starCount,
                      ),
                      Expanded(
                          child: BookDescriptionSection(
                              description: book.description)),
                      BottomPriceRatingSection(price: book.price),
                    ],
                  );
                } else {
                  return const Center(child: Text('No author data available'));
                }
              },
            );
          } else {
            return const Center(child: Text('No book data available'));
          }
        },
      ),
    );
  }
}
