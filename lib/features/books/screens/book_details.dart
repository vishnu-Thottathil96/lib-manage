import 'package:assesment_elt/core/models/author.dart';
import 'package:assesment_elt/core/models/book.dart';
import 'package:assesment_elt/core/services/books_service.dart';
import 'package:flutter/material.dart';
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:assesment_elt/features/books/widgets/rating_bottomsheet.dart';
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

//bottom section
class BottomPriceRatingSection extends StatelessWidget {
  final double price;

  const BottomPriceRatingSection({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final double padding = ResponsiveHelper.getResponsiveValue(
      context: context,
      phone: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    final double fontSize = ResponsiveHelper.getResponsiveValue(
      context: context,
      phone: 14.0,
      tablet: 16.0,
      desktop: 18.0,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.liteGrey, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "₹ $price",
            style: TextStyle(
              fontSize: fontSize + 6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showRatingPopup(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              padding: EdgeInsets.symmetric(
                  horizontal: padding * 1.5, vertical: padding / 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Add rating",
              style: TextStyle(fontSize: fontSize, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  void showRatingPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const RatingBottomSheet();
      },
    );
  }
}

//
class BookDescriptionSection extends StatelessWidget {
  final String description;
  const BookDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final double padding = ResponsiveHelper.getResponsiveValue(
      context: context,
      phone: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    final double fontSize = ResponsiveHelper.getResponsiveValue(
      context: context,
      phone: 14.0,
      tablet: 16.0,
      desktop: 18.0,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: SingleChildScrollView(
        child: Text(
          description,
          style: TextStyle(fontSize: fontSize, height: 1.5),
        ),
      ),
    );
  }
}

//
class BookInfoSection extends StatelessWidget {
  final String title;
  final String author;
  final String publishedDate;
  final String rating;
  final double price;

  const BookInfoSection({
    super.key,
    required this.title,
    required this.author,
    required this.publishedDate,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final double padding = ResponsiveHelper.getResponsiveValue(
      context: context,
      phone: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    final double fontSize = ResponsiveHelper.getResponsiveValue(
      context: context,
      phone: 14.0,
      tablet: 16.0,
      desktop: 18.0,
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: padding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                maxLines: 1,
                style: TextStyle(
                  fontSize: fontSize + 5,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: padding / 2, vertical: padding / 4),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.liteGrey),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: AppColors.golden, size: fontSize),
                    SizedBox(width: padding / 4),
                    Text(
                      rating,
                      style: TextStyle(color: Colors.black, fontSize: fontSize),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: padding / 2),
          Text(
            "by $author",
            style: TextStyle(fontSize: fontSize),
          ),
          SizedBox(height: padding / 4),
          Text(
            "Published date: $publishedDate",
            style: TextStyle(color: AppColors.textGrey, fontSize: fontSize),
          ),
          SizedBox(height: padding),
        ],
      ),
    );
  }
}

//
class BookImageContainer extends StatelessWidget {
  final String coverImageUrl;

  const BookImageContainer({super.key, required this.coverImageUrl});

  @override
  Widget build(BuildContext context) {
    final double containerHeight = ResponsiveHelper.getResponsiveValue(
      context: context,
      phone: 300.0,
      tablet: 400.0,
      desktop: 450.0,
    );

    return Container(
      height: containerHeight,
      color: AppColors.bookBg,
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: containerHeight / 17),
          child: Container(
            height: containerHeight,
            width: containerHeight * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(coverImageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
