import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/widgets.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                      0.0,
                      size.height * 0.3,
                      0.0,
                      size.height * 0.08,
                    ),
                    width: 75.0,
                    height: 75.0,
                    child: SvgPicture.asset('assets/svg/thumbsup.svg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.025),
                    child: Text(
                      'Спасибо!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.25),
                    child: Text(
                      'Скидка зафиксирована',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.15),
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
        ),
      ),
    );
  }
}
