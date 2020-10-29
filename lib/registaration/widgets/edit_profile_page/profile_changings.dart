import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/widgets.dart';

class ProfileChangings extends StatefulWidget {
  const ProfileChangings({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  _ProfileChangingsState createState() => _ProfileChangingsState();
}

class _ProfileChangingsState extends State<ProfileChangings> {
  TextEditingController _newPassword;
  TextEditingController _repeatPassword;
  //double _heightContainer;
  bool _obscureTextNewPassword;
  bool _obscureTextRepeatPassword;

  @override
  void initState() {
    super.initState();
    _newPassword = TextEditingController();
    _repeatPassword = TextEditingController();
    _obscureTextNewPassword = true;
    _obscureTextRepeatPassword = true;
  }

  @override
  void dispose() {
    _newPassword.dispose();
    _repeatPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _heightContainer = widget.size.height * cHeight;
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: widget.size.height * 0.05),
          child: Text(
            'Изменить пароль',
            style: TextStyle(
                fontSize: widget.size.height * 0.025,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold),
          ),
        ),
        //TODO почему я не применяю шаблон из email_textfield_widget
        //он же такой же только есть BLoC, а здесь SetState.
        Padding(
          padding: EdgeInsets.only(bottom: widget.size.height * 0.02),
          child: Container(
            // height: _heightContainer,
            child: TextField(
              controller: _newPassword,
              obscureText: _obscureTextNewPassword,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Новый пароль',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.05),
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    _obscureTextNewPassword = !_obscureTextNewPassword;
                  }),
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: (_obscureTextNewPassword) ? Colors.grey : cPink,
                  ),
                ),
                isCollapsed: true,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: widget.size.height * 0.1),
          child: Container(
            // height: _heightContainer,
            child: TextField(
              controller: _repeatPassword,
              obscureText: _obscureTextRepeatPassword,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: widget.size.width * 0.05),
                hintText: 'Повторите пароль',
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    _obscureTextRepeatPassword = !_obscureTextRepeatPassword;
                  }),
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: (_obscureTextRepeatPassword) ? Colors.grey : cPink,
                  ),
                ),
                isCollapsed: true,
              ),
            ),
          ),
        ),
        CustomButton(
          onTap: null, //size: size,
          buttonText: 'Сохранить изменения',
          buttonColor: cPink,
          buttonTextColor: Colors.white,
        )
      ],
    ));
  }
}
