// logo section
import 'package:assesment_elt/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class LogoSection extends StatelessWidget {
  final double height;
  final double width;

  const LogoSection({required this.height, required this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height / 5,
        width: width / 5,
        child: Image.asset(
          AppAssets.logoAuthPage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
