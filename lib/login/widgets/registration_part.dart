import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';

import 'package:kinda_work/registaration/reg_page.dart';
import 'package:kinda_work/styles.dart';

class RegistrationPart extends StatelessWidget {
  const RegistrationPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: size(context, 0.05)),
      child: Column(
        children: [
          Text('Еще не зарегистрировались?', style: style2(context)),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(seconds: 0),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    RegistrationPage(),
              ),
            ),
            child: Text(
              'Зарегистрироваться',
              style: style2(context).copyWith(color: cPink),
            ),
          ),
        ],
      ),
    );
  }
}
