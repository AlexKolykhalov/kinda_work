import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class EmailPasswordPart extends StatelessWidget {
  const EmailPasswordPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->EmailPasswordPart');
    return Container(
      child: Column(
        children: [
          Text('Вход в ваш аккаунт', style: style1(context)),
          Container(
            padding: EdgeInsets.symmetric(vertical: size(context, 0.05)),
            child: Column(
              children: [
                EmailPhoneTextField(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size(context, 0.02)),
                  child: PasswordTextField(),
                ),
                //TODO LogIN
                CustomButton(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          StartPage(),
                    ),
                  ),
                  text: 'Войти',
                  color: cPink,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
          Text(
            'Забыли пароль?',
            style: style2(context).copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
