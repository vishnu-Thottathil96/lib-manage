import 'package:assesment_elt/config/currency_config.dart';
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:assesment_elt/features/books/widgets/rating_bottomsheet.dart';
import 'package:flutter/material.dart';

class BottomPriceRatingSection extends StatelessWidget {
  final double price;
  final String bookId;

  const BottomPriceRatingSection(
      {super.key, required this.price, required this.bookId});

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
            "${CurrencyConfig.currencySymbol} $price",
            style: TextStyle(
              fontSize: fontSize + 6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              showRatingPopup(context, bookId);
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

  void showRatingPopup(BuildContext context, String id) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return RatingBottomSheet(
          bookId: id,
        );
      },
    );
  }
}
