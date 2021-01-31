import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class RegistrationByEmailPart extends StatelessWidget {
  const RegistrationByEmailPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->RegistrationByEmailPart');
    final double _hor = size(context, hor);
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.05)),
            child: Text('Регистрация', style: style1(context)),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _hor),
            child: EmailTextField(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _hor),
            child: PasswordTextField(),
          ),
          CustomButton(
            onTap: () {
              final Widget _editProfilePage = EditProfilePage();
              return Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 0),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      _editProfilePage,
                ),
              );
            },
            buttonText: 'Зарегистрироваться',
            buttonTextColor: Colors.white,
            buttonColor: cPink,
          ),
        ],
      ),
    );
  }
}
