import 'package:assesment_elt/config/app_router.dart';
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/constants/app_strings.dart';
import 'package:assesment_elt/core/util/custom_spacer.dart';
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
          SpaceWidget(size: h / 60),
          const AppName(),
          SpaceWidget(size: h / 35),
          const SearchBar(),
          SpaceWidget(size: h / 35),
          Expanded(
            child: BookGrid(width: w, height: h),
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

class BookGrid extends StatelessWidget {
  final double width;
  final double height;

  const BookGrid({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: width / 30),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemCount: 20, // Number of items in the grid
      itemBuilder: (context, index) {
        return BookCard(
          width: width,
          height: height,
          isLeftColumn: index % 2 == 0,
        );
      },
    );
  }
}

class BookCard extends StatelessWidget {
  final double width;
  final double height;
  final bool isLeftColumn;

  const BookCard({
    required this.width,
    required this.height,
    required this.isLeftColumn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => AppRouter().goToBookDetail(context),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                BookCover(width: width, height: height),
                BookDetails(width: width, height: height),
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

  const BookCover({required this.width, required this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(width / 60),
        child: Center(
          child: Container(
            width: width / 3,
            height: height / 4,
            color: Colors.blueAccent, // Placeholder for book cover
          ),
        ),
      ),
    );
  }
}

class BookDetails extends StatelessWidget {
  final double width;
  final double height;

  const BookDetails({required this.width, required this.height, super.key});

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
              "Book Title",
              style: TextStyle(
                fontSize: width / 27,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Author Name",
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
                  "4.5",
                  style: TextStyle(fontSize: width / 32),
                ),
              ],
            ),
            Text(
              "\$15.99",
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
