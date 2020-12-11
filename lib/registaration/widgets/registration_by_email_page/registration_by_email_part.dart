import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/widgets/email_textfield_widget.dart';
import 'package:kinda_work/other/pages/ptofile/edit_profile/edit_profile_page.dart';
import 'package:kinda_work/widgets.dart';

class RegistrationByEmailPart extends StatefulWidget {
  const RegistrationByEmailPart({Key key}) : super(key: key);

  @override
  _RegistrationByEmailPartState createState() =>
      _RegistrationByEmailPartState();
}

class _RegistrationByEmailPartState extends State<RegistrationByEmailPart> {
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
              'Регистрация',
              style: TextStyle(fontSize: _size.height * 0.03),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _size.height * 0.02),
            child: Container(
                child: EmailTextField(
              emailPhoneController: _emailPhoneController,
              showIcon: false,
            )),
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
          CustomButton(
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(seconds: 0),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    EditProfilePage(),
              ),
            ),
            buttonText: 'Зарегистрироваться',
            buttonTextColor: Colors.white,
            buttonColor: cPink,
          ),
        ],
      ),
    );
  }
}
