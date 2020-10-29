import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BottomTextPart extends StatelessWidget {
  const BottomTextPart({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.7,
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Нажимая на кнопку, я соглашаюсь с условиями ',
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    color: Colors.grey,
                  )),
              TextSpan(
                  text: 'Публичной оферты',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: size.height * 0.02,
                  ),
                  //TODO make link to Public offers
                  recognizer: TapGestureRecognizer()..onTap = () => null),
            ],
          )),
    );
  }
}
