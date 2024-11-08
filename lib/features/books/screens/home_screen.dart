import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double w = ResponsiveHelper.getWidth(context);
    double h = ResponsiveHelper.getHeight(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h / 60),

          // App Name
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w / 30),
            child: const Text(
              "App Name",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: h / 35),

          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w / 30),
            child: const CupertinoSearchTextField(),
          ),
          SizedBox(height: h / 35),

          // Grid View
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: w / 30),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
              itemCount: 20, // Number of items in the grid
              itemBuilder: (context, index) {
                bool isLeftColumn = index % 2 == 0;

                return Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          // Responsive green container for the "image" placeholder
                          Expanded(
                            flex: 2,
                            child: Container(
                              // color: Colors.green,
                              margin: EdgeInsets.all(w / 60),
                              child: Center(
                                child: Container(
                                  width: w / 3,
                                  height: h / 4,
                                  color: Colors.blueAccent, // Book cover color
                                ),
                              ),
                            ),
                          ),
                          // Responsive yellow container for book details
                          Expanded(
                            flex: 1,
                            child: Container(
                              // color: Colors.yellow,
                              padding: EdgeInsets.all(w / 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Book title
                                  Text(
                                    "Book Title",
                                    style: TextStyle(
                                      fontSize: w / 27,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  // Author name
                                  Text(
                                    "Author Name",
                                    style: TextStyle(
                                      fontSize: w / 32,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  // Rating
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: w / 32,
                                      ),
                                      SizedBox(width: w / 100),
                                      Text(
                                        "4.5",
                                        style: TextStyle(fontSize: w / 32),
                                      ),
                                    ],
                                  ),

                                  // Price
                                  Text(
                                    "\$15.99",
                                    style: TextStyle(
                                      fontSize: w / 27,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Vertical separator (middle line)
                    if (isLeftColumn)
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                    // Horizontal separator (bottom line)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
