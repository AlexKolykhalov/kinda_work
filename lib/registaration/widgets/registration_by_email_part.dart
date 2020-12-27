import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class RegistrationByEmailPart extends StatelessWidget {
  const RegistrationByEmailPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.05)),
            child: Text('Регистрация', style: style1(context)),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.02)),
            child: EmailTextField(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.02)),
            child: PasswordTextField(),
          ),
          CustomButton(
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(seconds: 0),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    EditProfilePage(),
              ),
            ),
            buttonText: 'Зарегистрироваться',
            buttonTextColor: Colors.white,
            buttonColor: cPink,
          ),
        ],
      ),
    );
  }
}
