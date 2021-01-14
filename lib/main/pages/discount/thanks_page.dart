import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({Key key, @required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    print('-->ThanksPage');
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: _size.height * vert),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(
                  0.0,
                  _size.height * 0.3,
                  0.0,
                  _size.height * 0.08,
                ),
                width: 75.0,
                height: 75.0,
                child: SvgPicture.asset('assets/svg/thumbsup.svg'),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: _size.height * 0.025),
                child: Text(
                  'Спасибо!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _size.width * 0.15),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _size.width * 0.15),
                child: CustomButton(
                  // onTap: MainPage(),
                  onTap: null,
                  buttonText: 'Закрыть',
                  buttonColor: cPink,
                  buttonTextColor: Colors.white,
                  isBoldButtonText: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
