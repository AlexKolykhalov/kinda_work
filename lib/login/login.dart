import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/widgets/email_pass_part.dart';
import 'package:kinda_work/login/widgets/logo_part.dart';
import 'package:kinda_work/login/widgets/registration_part.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    final _totalHorizontalPadding = 2 * _size.width * cHorizont;
    cConstantWidth =
        (_size.width - _totalHorizontalPadding - cCrossAxisSpacing) / 2;
    print('-->LoginPage');

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: _size.height - MediaQuery.of(context).padding.top,
            padding: EdgeInsets.symmetric(
              horizontal: _size.width * cLoginPageHorizontal,
              vertical: _size.height * cLoginPageVertical,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoPart(),
                EmailPasswordPart(),
                RegistrationPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
