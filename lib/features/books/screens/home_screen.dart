import 'package:assesment_elt/config/app_router.dart';
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/constants/app_strings.dart';
import 'package:assesment_elt/core/models/author.dart';
import 'package:assesment_elt/core/models/book.dart';
import 'package:assesment_elt/core/services/books_service.dart';
import 'package:assesment_elt/core/services/session_service.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Assume Book and Author models and BookService are defined elsewhere.

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.appName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () async {
                    // Show a confirmation dialog before logging out
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm Logout"),
                          content:
                              const Text("Are you sure you want to log out?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close dialog without logout
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await UserSessionService
                                    .clearUserSession(); // Clear session
                                AppRouter().goToRegister(
                                    context); // Navigate to landing page
                                Navigator.pop(
                                    context); // Confirm logout and close dialog
                              },
                              child: const Text("Logout"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CupertinoSearchTextField(),
          ),
          Expanded(
            child: BookGrid(width: width, height: height),
          ),
        ],
      ),
    );
  }
}

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    double w = ResponsiveHelper.getWidth(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w / 30),
      child: Text(
        AppStrings.appName,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    double w = ResponsiveHelper.getWidth(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w / 30),
      child: const CupertinoSearchTextField(),
    );
  }
}

class BookGrid extends StatefulWidget {
  final double width;
  final double height;

  const BookGrid({required this.width, required this.height, super.key});

  @override
  _BookGridState createState() => _BookGridState();
}

class _BookGridState extends State<BookGrid> {
  late List<Book> books = [];
  bool isLoading = true;
  final BookService _bookService = BookService();
  final Map<String, Future<Author>> _authorCache = {}; // Cache for author data

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  // Fetch books from the service
  Future<void> fetchBooks() async {
    try {
      final fetchedBooks = await _bookService.fetchBooks(page: 1, limit: 10);
      setState(() {
        books = fetchedBooks;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching books: $e');
    }
  }

  // Fetch author by ID with caching
  Future<Author> getAuthorById(String authorId) {
    // Only fetch author if not already in cache
    if (!_authorCache.containsKey(authorId)) {
      _authorCache[authorId] = _bookService.fetchAuthorById(authorId);
    }
    return _authorCache[authorId]!;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: widget.width / 30),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemCount: isLoading ? 6 : books.length,
      itemBuilder: (context, index) {
        if (isLoading) {
          // Show shimmer effect while loading
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: EdgeInsets.all(widget.width / 30),
              color: Colors.white,
              height: widget.height / 4,
            ),
          );
        }

        final book = books[index];
        return FutureBuilder<Author>(
          future: getAuthorById(book.authorId), // Fetch author using cache
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return BookCard(
                width: widget.width,
                height: widget.height,
                book: book,
                authorName: 'Loading...',
                isLeftColumn: index % 2 == 0,
              );
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}'); // Log any error message
              return BookCard(
                width: widget.width,
                height: widget.height,
                book: book,
                authorName: 'Error loading author',
                isLeftColumn: index % 2 == 0,
              );
            } else if (snapshot.hasData) {
              final authorName = snapshot.data?.name ?? 'Unknown Author';
              return BookCard(
                width: widget.width,
                height: widget.height,
                book: book,
                authorName: authorName,
                isLeftColumn: index % 2 == 0,
              );
            } else {
              return BookCard(
                width: widget.width,
                height: widget.height,
                book: book,
                authorName: 'No author found',
                isLeftColumn: index % 2 == 0,
              );
            }
          },
        );
      },
    );
  }
}

//
class BookCardShimmer extends StatelessWidget {
  final double width;
  final double height;

  const BookCardShimmer({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(width / 30),
      child: Column(
        children: [
          // Shimmer for the book cover
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: width / 3,
              height: height / 4,
              color: Colors.white,
            ),
          ),
          SizedBox(height: height / 40),
          // Shimmer for the book title
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final double width;
  final double height;
  final bool isLeftColumn;
  final Book book;
  final String authorName;

  const BookCard({
    required this.width,
    required this.height,
    required this.isLeftColumn,
    required this.book,
    required this.authorName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => AppRouter()
              .goToBookDetail(context, book.id, book.starCount.toString()),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                BookCover(
                    width: width,
                    height: height,
                    coverImageUrl: book.coverPictureURL),
                BookDetails(
                  width: width,
                  height: height,
                  book: book,
                  authorName: authorName,
                ),
              ],
            ),
          ),
        ),
        if (isLeftColumn) const VerticalSeparator(),
        const HorizontalSeparator(),
      ],
    );
  }
}

class BookCover extends StatelessWidget {
  final double width;
  final double height;
  final String coverImageUrl;

  const BookCover(
      {required this.width,
      required this.height,
      required this.coverImageUrl,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(width / 60),
        child: Center(
          child: Image.network(
            coverImageUrl,
            width: width / 3,
            height: height / 4,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class BookDetails extends StatelessWidget {
  final double width;
  final double height;
  final Book book;
  final String authorName;

  const BookDetails(
      {required this.width,
      required this.height,
      super.key,
      required this.book,
      required this.authorName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(width / 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: TextStyle(
                fontSize: width / 27,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              authorName,
              style: TextStyle(
                fontSize: width / 32,
                color: AppColors.textGrey,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: AppColors.golden,
                  size: width / 32,
                ),
                SizedBox(width: width / 100),
                Text(
                  book.starCount != 0
                      ? book.starCount.toString()
                      : 'No reviews',
                  style: TextStyle(fontSize: width / 32),
                ),
              ],
            ),
            Text(
              "\$ ${book.price}",
              style: TextStyle(
                fontSize: width / 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalSeparator extends StatelessWidget {
  const VerticalSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      child: Container(
        width: 1,
        color: AppColors.liteGrey,
      ),
    );
  }
}

class HorizontalSeparator extends StatelessWidget {
  const HorizontalSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 1,
        color: AppColors.liteGrey,
      ),
    );
  }
}
