import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';

class ProfileChangings extends StatelessWidget {
  const ProfileChangings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: _vert),
          child: Text(
            'Изменить пароль',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: _hor),
          child: PasswordTextField(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: size(context, 0.07)),
          child: PasswordTextField(),
        ),
        CustomButton(
          onTap: () => null,
          text: 'Сохранить изменения',
          color: cPink,
          textColor: Colors.white,
        )
      ],
    ));
  }
}
