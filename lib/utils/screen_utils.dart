import 'package:flutter/material.dart';

class ScreenUtils {
  static double resizeHeight(BuildContext context, double value) {
    var screenWidth = MediaQuery.of(context).size.height;
    var screenDesignHeight = 812; // TODO: Update your design height
    return (screenWidth * value) / screenDesignHeight;
  }

  static double resizeWidth(BuildContext context, double value) {
    var screenHeight = MediaQuery.of(context).size.width;
    var screenDesignWidth = 375; // TODO: Update your design width
    return (screenHeight * value) / screenDesignWidth;
  }
}
