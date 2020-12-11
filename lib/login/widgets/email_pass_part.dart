import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/BLoC/switcher_icon_cubit.dart';
import 'package:kinda_work/login/widgets/email_textfield_widget.dart';
import 'package:kinda_work/login/widgets/phone_textfield_widget.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/widgets.dart';

class EmailPasswordPart extends StatefulWidget {
  const EmailPasswordPart({Key key}) : super(key: key);

  //final Size size;

  @override
  _EmailPasswordPartState createState() => _EmailPasswordPartState();
}

class _EmailPasswordPartState extends State<EmailPasswordPart> {
  Size _size;
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
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
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
            padding: EdgeInsets.only(bottom: _size.height * 0.05),
            child: Text(
              'Вход в ваш аккаунт',
              style: TextStyle(fontSize: _size.height * 0.03),
            ),
          ),
          BlocBuilder<SwitcherIconCubit, bool>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(bottom: _size.height * 0.02),
                child: Container(
                  child: (state)
                      ? EmailTextField(
                          emailPhoneController: _emailPhoneController,
                          showIcon: true,
                        )
                      : PhoneTextField(
                          emailPhoneController: _emailPhoneController,
                        ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _size.height * 0.02),
            child: Container(
              child: TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Пароль',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: _size.width * 0.05),
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
            buttonText: 'Войти',
            buttonColor: cPink,
            buttonTextColor: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(top: _size.height * 0.05),
            child: Text(
              'Забыли пароль?',
              style:
                  TextStyle(color: Colors.grey, fontSize: _size.height * 0.025),
            ),
          ),
        ],
      ),
    );
  }
}
