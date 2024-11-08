import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double width;
  final double size;
  final Color color;
  final ValueChanged<double> onRatingChanged;

  const StarRating({
    super.key,
    required this.rating,
    required this.width,
    required this.onRatingChanged,
    this.size = 24.0,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    double starSize = ResponsiveHelper.getResponsiveValue(
      context: context,
      phone: width / 15,
      tablet: width / 13,
      desktop: width / 10,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            onRatingChanged(index + 1.0);
          },
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            size: starSize,
            color: color,
          ),
        );
      }),
    );
  }
}
