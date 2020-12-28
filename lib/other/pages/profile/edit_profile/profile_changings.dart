import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/shared_widgets.dart';

class ProfileChangings extends StatelessWidget {
  const ProfileChangings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: size(context, 0.03)),
          child: Text(
            'Изменить пароль',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: size(context, 0.02)),
          child: PasswordTextField(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: size(context, 0.07)),
          child: PasswordTextField(),
        ),
        CustomButton(
          onTap: () => null,
          buttonText: 'Сохранить изменения',
          buttonColor: cPink,
          buttonTextColor: Colors.white,
        )
      ],
    ));
  }
}
