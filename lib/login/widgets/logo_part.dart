import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinda_work/styles.dart';

class LogoPart extends StatelessWidget {
  const LogoPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->LogoPart');
    return Container(
      height: size(context, 0.2),
      child: SvgPicture.asset(
        'assets/svg/logo.svg',
        fit: BoxFit.contain,
      ),
    );
  }
}
