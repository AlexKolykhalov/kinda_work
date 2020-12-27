import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/BLoC/switcher_icon_cubit.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class EmailPasswordPart extends StatelessWidget {
  const EmailPasswordPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.05)),
            child: Text('Вход в ваш аккаунт', style: style1(context)),
          ),
          BlocBuilder<SwitcherIconCubit, bool>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(bottom: size(context, 0.02)),
                child: Container(
                  child: state ? EmailTextField() : PhoneTextField(),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.02)),
            child: PasswordTextField(),
          ),
          //TODO LogIN
          CustomButton(
            onTap: () => Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(seconds: 0),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MainPage(),
              ),
            ),
            buttonText: 'Войти',
            buttonColor: cPink,
            buttonTextColor: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(top: size(context, 0.05)),
            child: Text(
              'Забыли пароль?',
              style: style2(context).copyWith(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
