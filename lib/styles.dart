// text styles
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Size
double size(BuildContext context, double value) {
  print('SIZE');
  return MediaQuery.of(context).size.height * value;
}

// TextStyle
TextStyle style1(BuildContext context) {
  return TextStyle(fontSize: size(context, 0.03));
}

TextStyle style2(BuildContext context) {
  return TextStyle(fontSize: size(context, 0.023));
}

TextStyle style3(BuildContext context) {
  return TextStyle(fontSize: size(context, 0.02));
}

TextStyle style4(BuildContext context) {
  return TextStyle(fontSize: size(context, 0.018));
}

// Padding

paddingHor(BuildContext context, double value) {}

class CustomPadding {
  static const double hor = 0.05; //0.02 of height
  static const double vert = 0.025;

  static EdgeInsets constHor(BuildContext context) {
    return EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * hor);
  }

  static EdgeInsets constVert(BuildContext context) {
    return EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * vert);
  }

  static EdgeInsets constHorVert(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * hor,
      vertical: MediaQuery.of(context).size.height * vert,
    );
  }

  static EdgeInsets customHor(
    BuildContext context,
    double percentWidth,
  ) {
    return EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * percentWidth);
  }

  static EdgeInsets customVert(
    BuildContext context,
    double percentHeight,
  ) {
    return EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * percentHeight);
  }

  static EdgeInsets customHorVert(
    BuildContext context,
    double percentWidth,
    double percentHeight,
  ) {
    return EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.height * percentWidth,
      vertical: MediaQuery.of(context).size.height * percentHeight,
    );
  }
}
