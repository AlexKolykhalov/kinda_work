import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/widgets/logo_part.dart';
import 'package:kinda_work/registaration/widgets/registration_by_email_part.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/styles.dart';

class RegistrationByEmailPage extends StatelessWidget {
  const RegistrationByEmailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->RegistrationByEmailPage');
    MediaQueryData _mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          backgroundColor: cGrey,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: _mq.size.height - appBarHeight(context) - _mq.padding.top,
            padding: EdgeInsets.symmetric(horizontal: size(context, 0.05)),
            child: Column(
              children: [
                LogoPart(),
                SizedBox(height: size(context, 0.05)),
                RegistrationByEmailPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
