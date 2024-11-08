import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:assesment_elt/features/books/widgets/rating_bottomsheet.dart';
import 'package:assesment_elt/features/books/widgets/star_rating.dart';
import 'package:flutter/material.dart';

enum ScreenType {
  phone,
  tablet,
  desktop,
}

enum OrientationType {
  portrait,
  landscape,
}

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key});

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

    final double containerHeight = ResponsiveHelper.getResponsiveValue(
      context: context,
      phone: 300.0,
      tablet: 400.0,
      desktop: 450.0,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
          ),
          Padding(
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star,
                              color: Colors.yellow[700], size: fontSize),
                          SizedBox(width: padding / 4),
                          Text(
                            "4.0",
                            style: TextStyle(
                                color: Colors.black, fontSize: fontSize),
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
                  style: TextStyle(color: Colors.grey[700], fontSize: fontSize),
                ),
                SizedBox(height: padding),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: SingleChildScrollView(
                child: Text(
                  "It’s been nearly 25 years since Robert Kiyosaki’s Rich Dad Poor Dad first made waves in the Personal Finance arena. "
                  "It has since become the #1 Personal Finance book of all time... translated into dozens of languages and sold around the world.\n\n"
                  "Rich Dad Poor Dad is Robert’s story of growing up with two dads—his real father and the father of his best friend, "
                  "his rich dad—and the ways in which both men shaped his thoughts about money and investing. The book explodes "
                  "the myth that you need to earn a high income to be rich and explains the difference between working for money "
                  "and having your money work for you.",
                  style: TextStyle(
                      color: Colors.grey[800], fontSize: fontSize, height: 1.5),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: padding, vertical: padding / 2),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
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
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(
                        horizontal: padding * 1.5, vertical: padding / 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Add rating",
                    style: TextStyle(fontSize: fontSize, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
