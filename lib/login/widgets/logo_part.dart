import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoPart extends StatelessWidget {
  const LogoPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: SvgPicture.asset(
        'assets/svg/logo.svg',
        fit: BoxFit.contain,
      ),
    );
  }
}
