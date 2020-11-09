import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/widgets/email_textfield_widget.dart';
import 'package:kinda_work/registaration/pages/edit_profile_page.dart';
import 'package:kinda_work/widgets.dart';

class RegistrationByEmailPart extends StatefulWidget {
  const RegistrationByEmailPart({Key key, @required this.size})
      : super(key: key);

  final Size size;

  @override
  _RegistrationByEmailPartState createState() =>
      _RegistrationByEmailPartState();
}

class _RegistrationByEmailPartState extends State<RegistrationByEmailPart> {
  TextEditingController _emailPhoneController;
  TextEditingController _passwordController;
  //double _heightContainer;
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
    //_heightContainer = widget.size.height * cHeight;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: widget.size.height * 0.05),
            child: Text(
              'Регистрация',
              style: TextStyle(fontSize: widget.size.height * 0.03),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: widget.size.height * 0.02),
            child: Container(
                //height: _heightContainer,
                child: EmailTextField(
              size: widget.size,
              emailPhoneController: _emailPhoneController,
              showIcon: false,
            )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: widget.size.height * 0.02),
            child: Container(
              //height: _heightContainer,
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
          CustomButton(
            // onTap: EditProfilePage(),
            onTap: null,
            //size: widget.size,
            buttonText: 'Зарегистрироваться',
            buttonTextColor: Colors.white,
            buttonColor: cPink,
          ),
        ],
      ),
    );
  }
}
