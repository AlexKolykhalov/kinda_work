import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/widgets/logo_part.dart';
import 'package:kinda_work/registaration/widgets/registration_by_sms_part.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class RegistrationBySmsPage extends StatelessWidget {
  const RegistrationBySmsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: '',
          backgroundColor: cGrey,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: _size.height -
                AppBar().preferredSize.height * 0.85 -
                MediaQuery.of(context).padding.top,
            padding: EdgeInsets.symmetric(
              horizontal: _size.width * cLoginPageHorizontal,
            ),
            child: Column(
              children: [
                LogoPart(),
                SizedBox(height: size(context, 0.05)),
                RegistrationBySmsPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
