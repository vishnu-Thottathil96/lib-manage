import 'dart:async';
import 'package:assesment_elt/config/app_router.dart';
import 'package:assesment_elt/core/constants/app_assets.dart';
import 'package:assesment_elt/core/constants/app_colors.dart';
import 'package:assesment_elt/core/services/session_service.dart';
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
    // Start a timer to wait for two seconds and then check login status
    Timer(const Duration(seconds: 2), _checkLoginStatus);
  }

  Future<void> _checkLoginStatus() async {
    bool isLoggedIn = await UserSessionService
        .isLoggedIn(); // Assuming this checks the login status

    if (isLoggedIn) {
      AppRouter().goToLanding(context); // Go to the landing page if logged in
    } else {
      AppRouter().goToRegister(
          context); // Go to the registration page if not logged in
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = ResponsiveHelper.getWidth(context);
    double h = ResponsiveHelper.getHeight(context);
    return Scaffold(
      backgroundColor: AppColors.primaryOrange,
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
      ),
    );
  }
}
