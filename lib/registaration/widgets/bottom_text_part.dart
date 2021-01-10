import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';

class BottomTextPart extends StatelessWidget {
  const BottomTextPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: size(context, 0.05)),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Нажимая на кнопку, я соглашаюсь с условиями ',
                style: style3(context).copyWith(color: Colors.grey[600])),
            TextSpan(
                text: 'Публичной оферты',
                style: style3(context).copyWith(color: cPink),
                //TODO make link to Public offers
                recognizer: TapGestureRecognizer()..onTap = () => null),
          ],
        ),
      ),
    );
  }
}
