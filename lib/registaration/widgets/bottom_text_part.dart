import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BottomTextPart extends StatelessWidget {
  const BottomTextPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width * 0.7,
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Нажимая на кнопку, я соглашаюсь с условиями ',
                  style: TextStyle(
                    fontSize: _size.height * 0.02,
                    color: Colors.grey,
                  )),
              TextSpan(
                  text: 'Публичной оферты',
                  style: TextStyle(
                    color: Colors.pink,
                    fontSize: _size.height * 0.02,
                  ),
                  //TODO make link to Public offers
                  recognizer: TapGestureRecognizer()..onTap = () => null),
            ],
          )),
    );
  }
}
