import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/other_page.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/styles.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({Key key, @required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    print('-->ThanksPage');
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size(context, 0.07),
            vertical: size(context, vert),
          ),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      width: size(context, 0.15),
                      height: size(context, 0.15),
                      margin: EdgeInsets.only(top: size(context, 0.2)),
                      child: SvgPicture.asset('assets/svg/thumbsup.svg'),
                    ),
                    SizedBox(height: size(context, 0.05)),
                    Text(
                      'Спасибо!',
                      style: style1(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size(context, 0.025)),
                    Text(text, style: style3(context)),
                  ],
                ),
              ),
              Expanded(child: Container()),
              CustomButton(
                onTap: () {
                  final Widget _otherPage = OtherPage();
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _otherPage,
                    ),
                  );
                },
                buttonText: 'Закрыть',
                buttonColor: cPink,
                buttonTextColor: Colors.white,
                isBoldButtonText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
