import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    useMaterial3: true,
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    useMaterial3: true,
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData of(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.dark:
        return darkTheme;
      case Brightness.light:
        return lightTheme;
    }
  }
}
