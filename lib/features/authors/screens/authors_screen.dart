import 'dart:math';
import 'package:flutter/material.dart';
import 'package:assesment_elt/core/services/author_service.dart';
import 'package:assesment_elt/core/models/author.dart';
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/constants/app_strings.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

class AuthorsScreen extends StatelessWidget {
  const AuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double w = ResponsiveHelper.getWidth(context);
    double h = ResponsiveHelper.getHeight(context);

    return SafeArea(
      child: FutureBuilder<List<AuthorModel>>(
        future: AuthorService().fetchAuthors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show shimmer effect while loading
            return _buildShimmer(w, h);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final authors = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h / 60),
                _buildTitle(w),
                SizedBox(height: h / 60),
                Expanded(
                  child: ListView.builder(
                    itemCount: authors.length,
                    itemBuilder: (context, index) {
                      return _buildAuthorTile(authors[index], w, h);
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No authors available'));
          }
        },
      ),
    );
  }

  Widget _buildShimmer(double w, double h) {
    // Return a shimmer effect for the loading state
    return ListView.builder(
      itemCount: 10, // Simulate 10 loading authors
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: h / 100, horizontal: w / 30),
          child: Shimmer.fromColors(
            baseColor: AppColors.liteGrey,
            highlightColor: AppColors.textGrey,
            child: Container(
              height: h / 8,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    width: w / 8,
                    height: w / 8,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: w / 30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: w / 2,
                          height: h / 20,
                          color: AppColors.white,
                        ),
                        SizedBox(height: h / 60),
                        Container(
                          width: w / 2,
                          height: h / 30,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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

  Widget _buildAuthorTile(AuthorModel author, double w, double h) {
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
            _buildAuthorCircle(author.name, randomColor, darkShadeColor, w),
            SizedBox(width: w / 30),
            _buildAuthorDetails(author, w),
          ],
        ),
      ),
    );
  }

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

  Widget _buildAuthorDetails(AuthorModel author, double w) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            author.name,
            style: TextStyle(
              fontSize: w / 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            author.biography,
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

Color generateRandomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    0.3,
  );
}

Color getDarkerShade(Color color) {
  int red = (color.red * 0.5).toInt();
  int green = (color.green * 0.5).toInt();
  int blue = (color.blue * 0.5).toInt();
  return Color.fromRGBO(red, green, blue, 1);
}
