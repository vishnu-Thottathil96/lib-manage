import 'dart:async';
import 'package:assesment_elt/core/constants/app_assets.dart';
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/util/responsive_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer to wait for two seconds
    Timer(const Duration(seconds: 3), () {
      // Redirect to the authentication page using GetX
      // Get.offNamed('/auth');
      // Get.offNamedUntil(AppRoutes.landing, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = ResponsiveHelper.getWidth(context);
    double h = ResponsiveHelper.getHeight(context);
    return Scaffold(
        backgroundColor: AppColors.splashScreedBg,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: h / 4,
                  width: w / 4,
                  child: Image.asset(
                    AppAssets.logo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
