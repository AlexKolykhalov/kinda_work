import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Size
double size(BuildContext context, double value) {
  // print('SIZE');
  return MediaQuery.of(context).size.height * value;
}

double appBarHeight(BuildContext context) {
  return MediaQuery.of(context).size.height > 550 ? 50 : 41;
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
