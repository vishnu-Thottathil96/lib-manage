import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.dark:
        return ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          useMaterial3: true,
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        );
      case ThemeMode.light:
      default:
        return ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          useMaterial3: true,
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        );
    }
  }
}
