// Modular text field
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/features/auth/screens/widgets/label_text.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final FocusNode focusNode;
  final bool obscureText;
  final double height;
  final TextEditingController controller;
  final String? Function(String?)? validator; // Add validator
  final VoidCallback? onVisibilityToggle;

  const CustomTextField({
    required this.label,
    required this.focusNode,
    required this.obscureText,
    required this.height,
    required this.controller,
    this.validator,
    this.onVisibilityToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelText(label: label, isFocused: focusNode.hasFocus),
        SizedBox(height: height / 100),
        TextFormField(
          focusNode: focusNode,
          obscureText: obscureText,
          controller: controller,
          validator: validator, // Apply validator
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: AppColors.primaryOrange,
                width: 2.0,
              ),
            ),
            suffixIcon: onVisibilityToggle != null
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: onVisibilityToggle,
                  )
                : null,
          ),
        ),
        SizedBox(height: height / 50),
      ],
    );
  }
}
