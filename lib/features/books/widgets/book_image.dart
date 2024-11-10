import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:flutter/material.dart';

class BookImageContainer extends StatelessWidget {
  final String coverImageUrl;

  const BookImageContainer({super.key, required this.coverImageUrl});

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
      color: AppColors.bookBg,
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: containerHeight / 17),
          child: Container(
            height: containerHeight,
            width: containerHeight * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(coverImageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
