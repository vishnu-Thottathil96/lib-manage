import 'dart:math';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthorsScreen extends StatelessWidget {
  const AuthorsScreen({super.key});

  // Function to generate a random color
  Color generateRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256), // Random Red value (0-255)
      random.nextInt(256), // Random Green value (0-255)
      random.nextInt(256), // Random Blue value (0-255)
      0.3, // Alpha channel (opacity), 1 is fully opaque
    );
  }

  // Function to generate a darker shade of the color
  Color getDarkerShade(Color color) {
    int red = (color.red * 0.7).toInt();
    int green = (color.green * 0.7).toInt();
    int blue = (color.blue * 0.7).toInt();

    return Color.fromRGBO(red, green, blue, 1); // Return a darker shade
  }

  @override
  Widget build(BuildContext context) {
    double w = ResponsiveHelper.getWidth(context);
    double h = ResponsiveHelper.getHeight(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h / 60),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w / 30),
            child: const Text(
              "Authors",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: h / 60),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                String authorName = "Author $index"; // Example author name
                String description = descr; // Use the provided description

                // Generate a random color for the circle
                Color randomColor = generateRandomColor();
                Color darkShadeColor =
                    getDarkerShade(randomColor); // Darker shade for the text

                return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: h / 100, horizontal: w / 30),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1, // Border width
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(w / 40),
                    child: Row(
                      children: [
                        // Circle with the first letter of the author's name
                        Container(
                          width: w / 8,
                          height: w / 8,
                          decoration: BoxDecoration(
                            color: randomColor, // Direct use of random color
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              authorName[
                                  0], // First letter of the author's name
                              style: TextStyle(
                                color:
                                    darkShadeColor, // Darker shade for the text
                                fontSize: w / 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: w / 30),
                        // Author name and description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Author name
                              Text(
                                authorName,
                                style: TextStyle(
                                  fontSize: w / 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // Description (max 2 lines, ellipsis after)
                              Text(
                                description,
                                style: TextStyle(
                                  fontSize: w / 30,
                                  color: Colors.grey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String descr =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum';
