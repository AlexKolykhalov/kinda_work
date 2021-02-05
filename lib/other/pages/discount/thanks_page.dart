import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/styles.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({Key key, @required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    print('***ThanksPage***');
    final MediaQueryData _mq = MediaQuery.of(context);
    final double _h = _mq.size.height * 0.15;
    final double _vert = _mq.size.height * vert;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: _mq.size.height - _mq.padding.top,
            padding: EdgeInsets.symmetric(
              horizontal: size(context, 0.07),
              vertical: _vert,
            ),
            child: Column(
              children: [
                Expanded(child: Container()),
                Column(
                  children: [
                    Container(
                      width: _h,
                      height: _h,
                      child: SvgPicture.asset('assets/svg/thumbsup.svg'),
                    ),
                    SizedBox(height: _vert * 2),
                    Text(
                      'Спасибо!',
                      style: style1(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: _vert),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: style3(context),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                CustomButton(
                  onTap: () {
                    final Widget _startPage = StartPage();
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  _startPage,
                        ),
                        (route) => false);
                  },
                  text: 'Закрыть',
                  color: cPink,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
