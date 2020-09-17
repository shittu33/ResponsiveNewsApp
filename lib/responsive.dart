import 'package:flutter/material.dart';

class Responsive {
  static const smallSize = 800;
  static const largeSize = 980;
  static const extraLargeSize = 1200;

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > largeSize &&
        MediaQuery.of(context).size.width < extraLargeSize;
  }

  //Large screen is any screen whose width is more than 1200 pixels
  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > extraLargeSize;
  }

//Small screen is any screen whose width is less than 800 pixels
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < smallSize;
  }

//Medium screen is any screen whose width is less than 1200 pixels,
  //and more than 800 pixels
  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > smallSize &&
        MediaQuery.of(context).size.width < largeSize;
  }
}
