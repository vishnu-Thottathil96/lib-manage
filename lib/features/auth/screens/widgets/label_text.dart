// Label text widget
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String label;
  final bool isFocused;

  const LabelText({required this.label, required this.isFocused, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: isFocused ? AppColors.primaryOrange : AppColors.textGrey,
        fontSize: 16,
      ),
    );
  }
}
