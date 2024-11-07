import 'package:flutter/material.dart';

enum ScreenType {
  phone,
  tablet,
  desktop,
}

enum OrientationType {
  portrait,
  landscape,
}

class ResponsiveHelper {
  // Get screen type based on width
  static ScreenType getScreenType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1024) {
      return ScreenType.desktop;
    } else if (width >= 600) {
      return ScreenType.tablet;
    } else {
      return ScreenType.phone;
    }
  }

  // Get orientation type
  static OrientationType getOrientationType(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return OrientationType.portrait;
    } else {
      return OrientationType.landscape;
    }
  }

  // Get responsive value based on screen type
  static double getResponsiveValue({
    required BuildContext context,
    required double phone,
    double? tablet,
    double? desktop,
  }) {
    ScreenType screenType = getScreenType(context);
    switch (screenType) {
      case ScreenType.tablet:
        return tablet ?? phone;
      case ScreenType.desktop:
        return desktop ?? tablet ?? phone;
      default:
        return phone;
    }
  }

  // Check if device is phone
  static bool isPhone(BuildContext context) =>
      getScreenType(context) == ScreenType.phone;

  // Check if device is tablet
  static bool isTablet(BuildContext context) =>
      getScreenType(context) == ScreenType.tablet;

  // Check if device is desktop
  static bool isDesktop(BuildContext context) =>
      getScreenType(context) == ScreenType.desktop;

  // Check if orientation is portrait
  static bool isPortrait(BuildContext context) =>
      getOrientationType(context) == OrientationType.portrait;

  // Check if orientation is landscape
  static bool isLandscape(BuildContext context) =>
      getOrientationType(context) == OrientationType.landscape;

  // Get screen width
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get screen height
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Get text size based on screen width
  static double getTextSize(BuildContext context, {double scale = 0.03}) {
    final screenWidth = getWidth(context);
    return screenWidth * scale;
  }
}
