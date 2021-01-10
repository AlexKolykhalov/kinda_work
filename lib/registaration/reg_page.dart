import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/widgets/logo_part.dart';
import 'package:kinda_work/registaration/widgets/bottom_text_part.dart';
import 'package:kinda_work/registaration/widgets/registration_data_part.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mq = MediaQuery.of(context);
    print('-->RegistrationPage');
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
                RegistrationDataPart(),
                Expanded(child: Container()),
                BottomTextPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
