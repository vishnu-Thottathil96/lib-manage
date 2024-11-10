import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:flutter/material.dart';

class BookDescriptionSection extends StatelessWidget {
  final String description;
  const BookDescriptionSection({super.key, required this.description});

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
          description,
          style: TextStyle(fontSize: fontSize, height: 1.5),
        ),
      ),
    );
  }
}
