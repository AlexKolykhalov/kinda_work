import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//TODO delete all "c"
//https://dart.dev/guides/language/effective-dart/style#dont-use-prefix-letters

//padding
const double cLoginPageHorizontal = 0.1;
const double cLoginPageVertical = 0.05;

const double cHorizont = 0.05;
const double cVertical = 0.025;
const double hor = 0.02;
const double vert = 0.025;

//color
const cGrey = Color(0xFFE0E0E0);
const cPink = Color(0xFFE91E63);
const cIndigo = Color(0xFF3F51B5);

//buttons & textField
const double cHeight = 0.07;

//grid
double cConstantWidth = 0.0; //see Login.dart
const double cRatioSmallSize = 0.9;
const double cRatioMediumSize = 0.84; //with prices
const double cRatioLargeSize = 1.65;
const double cMainAxisSpacing = 10.0;
const double cCrossAxisSpacing = 10.0;

//fontSize percents
const double scaleLightText = 0.075;
const double scaleBoltText = 0.085;

//svg icons
Widget cLeftArrow = SvgPicture.asset('assets/svg/left_arrow.svg');
Widget cSearchIcon = SvgPicture.asset('assets/svg/search.svg');
Widget cQrCodeIcon = SvgPicture.asset('assets/svg/qrcode.svg');
Widget cLocationIcon = SvgPicture.asset('assets/svg/location.svg');
Widget cScanBarCodeIcon = SvgPicture.asset('assets/svg/codescan.svg');
Widget cService =
    SvgPicture.asset('assets/svg/restaurant_icons/restaurant.svg');
Widget cKitchen = SvgPicture.asset('assets/svg/restaurant_icons/fork.svg');
Widget cPriceQuality =
    SvgPicture.asset('assets/svg/restaurant_icons/invoice.svg');
Widget cAmbiance =
    SvgPicture.asset('assets/svg/restaurant_icons/happiness.svg');
