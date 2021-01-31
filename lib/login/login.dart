import 'package:flutter/material.dart';

import 'package:kinda_work/login/widgets/email_pass_part.dart';
import 'package:kinda_work/login/widgets/logo_part.dart';
import 'package:kinda_work/login/widgets/registration_part.dart';
import 'package:kinda_work/styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->LoginPage');
    MediaQueryData _mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: _mq.size.height - _mq.padding.top,
            padding: EdgeInsets.symmetric(horizontal: size(context, 0.05)),
            child: Column(
              children: [
                SizedBox(height: appBarHeight(context)),
                LogoPart(),
                SizedBox(height: size(context, 0.05)),
                EmailPasswordPart(),
                Expanded(child: Container()),
                RegistrationPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
