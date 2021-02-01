import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/registaration/pages/registration_by_email_page.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class RegistrationBySmsPart extends StatelessWidget {
  const RegistrationBySmsPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->RegistrationBySmsPart');
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.05)),
            child: Text(
              'Регистрация',
              style: style1(context),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.02)),
            child: CustomTextField(
              keyboardType: TextInputType.number,
              hintText: 'СМС код',
            ),
          ),
          CustomButton(
            onTap: () {
              final Widget _registrationByEmailPage = RegistrationByEmailPage();
              return Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 0),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      _registrationByEmailPage,
                ),
              );
            },
            text: 'Отправить код',
            textColor: Colors.white,
            color: cPink,
          ),
        ],
      ),
    );
  }
}
