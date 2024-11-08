import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:assesment_elt/features/books/widgets/rating_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:assesment_elt/config/app_router.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {
            AppRouter().goToLanding(context);
          },
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookImageContainer(),
          BookInfoSection(),
          Expanded(child: BookDescriptionSection()),
          BottomPriceRatingSection(),
        ],
      ),
    );
  }
}

//bottom section
class BottomPriceRatingSection extends StatelessWidget {
  const BottomPriceRatingSection({super.key});

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
            "₹ 850.00",
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
  const BookDescriptionSection({super.key});

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
          "It’s been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena... "
          "explains the difference between working for money and having your money work for you.",
          style: TextStyle(
              color: AppColors.textGrey, fontSize: fontSize, height: 1.5),
        ),
      ),
    );
  }
}

//
class BookInfoSection extends StatelessWidget {
  const BookInfoSection({super.key});

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
                "Rich Dad Poor Dad",
                style: TextStyle(
                  fontSize: fontSize + 6,
                  fontWeight: FontWeight.bold,
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
                      "4.0",
                      style: TextStyle(color: Colors.black, fontSize: fontSize),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: padding / 2),
          Text(
            "by Robert T. Kiyosaki",
            style: TextStyle(color: Colors.black, fontSize: fontSize),
          ),
          SizedBox(height: padding / 4),
          Text(
            "Published date: April 11, 2017",
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
  const BookImageContainer({super.key});

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
      color: Colors.pink[100],
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: containerHeight / 17),
          child: Container(
            height: containerHeight,
            width: containerHeight * 0.7,
            color: Colors.purpleAccent,
          ),
        ),
      ),
    );
  }
}
