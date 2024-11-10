import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:flutter/material.dart';

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
              // Wrap the title text in a Flexible widget
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: fontSize + 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: padding), // Add a gap between the two widgets

              // Wrap the rating container in a Flexible widget to avoid overflow
              Flexible(
                flex:
                    0, // Keeps the container at its intrinsic size but still flexible
                child: Container(
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
                        style:
                            TextStyle(color: Colors.black, fontSize: fontSize),
                      ),
                    ],
                  ),
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
