import 'dart:math';
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/constants/app_strings.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthorsScreen extends StatelessWidget {
  const AuthorsScreen({super.key});

  // Static description text for all authors
  static const String descriptionText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum';

  @override
  Widget build(BuildContext context) {
    double w = ResponsiveHelper.getWidth(context);
    double h = ResponsiveHelper.getHeight(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h / 60),
          _buildTitle(w),
          SizedBox(height: h / 60),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                String authorName = "Author $index";
                return _buildAuthorTile(authorName, w, h);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Builds the "Authors" title at the top
  Widget _buildTitle(double w) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w / 30),
      child: Text(
        AppStrings.authorsPageTitle,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Builds a tile for each author with a colored circle and description
  Widget _buildAuthorTile(String authorName, double w, double h) {
    Color randomColor = generateRandomColor();
    Color darkShadeColor = getDarkerShade(randomColor);

    return Container(
      margin: EdgeInsets.symmetric(vertical: h / 100, horizontal: w / 30),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.liteGrey, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(w / 40),
        child: Row(
          children: [
            _buildAuthorCircle(authorName, randomColor, darkShadeColor, w),
            SizedBox(width: w / 30),
            _buildAuthorDetails(authorName, descriptionText, w),
          ],
        ),
      ),
    );
  }

  // Builds the circular avatar with the author's initial
  Widget _buildAuthorCircle(
      String authorName, Color bgColor, Color textColor, double w) {
    return Container(
      width: w / 8,
      height: w / 8,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          authorName[0],
          style: TextStyle(
            color: textColor,
            fontSize: w / 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Builds the column with the author's name and description
  Widget _buildAuthorDetails(String authorName, String description, double w) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            authorName,
            style: TextStyle(
              fontSize: w / 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: w / 30,
              color: AppColors.textGrey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Generates a random color with a fixed opacity
Color generateRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    0.3,
  );
}

// Returns a darker shade of the given color
Color getDarkerShade(Color color) {
  int red = (color.red * 0.5).toInt();
  int green = (color.green * 0.5).toInt();
  int blue = (color.blue * 0.5).toInt();
  return Color.fromRGBO(red, green, blue, 1);
}
