import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/BLoC/switcher_icon_cubit.dart';
import 'package:kinda_work/login/widgets/email_textfield_widget.dart';
import 'package:kinda_work/login/widgets/phone_textfield_widget.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/widgets.dart';

class EmailPasswordPart extends StatefulWidget {
  const EmailPasswordPart({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  _EmailPasswordPartState createState() => _EmailPasswordPartState();
}

class _EmailPasswordPartState extends State<EmailPasswordPart> {
  TextEditingController _emailPhoneController;
  TextEditingController _passwordController;
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _emailPhoneController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureText = true;
  }

  @override
  void dispose() {
    _emailPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: widget.size.height * 0.05),
            child: Text(
              'Вход в ваш аккаунт',
              style: TextStyle(fontSize: widget.size.height * 0.03),
            ),
          ),
          BlocBuilder<SwitcherIconCubit, bool>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(bottom: widget.size.height * 0.02),
                child: Container(
                  //height: widget.size.height * cHeight,
                  child: (state)
                      ? EmailTextField(
                          size: widget.size,
                          emailPhoneController: _emailPhoneController,
                          showIcon: true,
                        )
                      : PhoneTextField(
                          size: widget.size,
                          emailPhoneController: _emailPhoneController,
                        ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: widget.size.height * 0.02),
            child: Container(
              //height: widget.size.height * cHeight,
              child: TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Пароль',
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: widget.size.width * 0.05),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() {
                      _obscureText = !_obscureText;
                    }),
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: (_obscureText) ? Colors.grey : cPink,
                    ),
                  ),
                  isCollapsed: true,
                ),
              ),
            ),
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
            // size: widget.size,
            buttonText: 'Войти',
            buttonColor: cPink,
            buttonTextColor: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(top: widget.size.height * 0.05),
            child: Text(
              'Забыли пароль?',
              style: TextStyle(
                  color: Colors.grey, fontSize: widget.size.height * 0.025),
            ),
          ),
        ],
      ),
    );
  }
}
