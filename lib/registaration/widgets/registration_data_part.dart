import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/registaration/pages/registration_by_sms_page.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class RegistrationDataPart extends StatelessWidget {
  const RegistrationDataPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->RegistrationDataPart');
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.05)),
            child: Text('Регистрация', style: style1(context)),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.02)),
            child: Container(
                //TODO make propper phone number fotmatter
                child: PhoneTextField()),
          ),
          CustomButton(
            onTap: () {
              final Widget _registrationBySmsPage = RegistrationBySmsPage();
              return Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 0),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      _registrationBySmsPage,
                ),
              );
            },
            text: 'Получить СМС с кодом',
            textColor: Colors.white,
            color: cPink,
          ),
        ],
      ),
    );
  }
}
