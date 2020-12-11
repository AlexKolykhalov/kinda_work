import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/BLoC/switcher_icon_cubit.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key key,
    @required this.emailPhoneController,
    @required this.showIcon,
  }) : super(key: key);

  final TextEditingController emailPhoneController;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailPhoneController,
      keyboardType: TextInputType.emailAddress,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
        hintText: 'Email',
        contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        suffixIcon: IconButton(
          onPressed: () {
            if (showIcon) {
              emailPhoneController.clear();
              BlocProvider.of<SwitcherIconCubit>(context).changed();
            }
          },
          icon: (showIcon) ? Icon(Icons.phone, color: cPink) : Icon(null),
        ),
        isCollapsed: true,
      ),
    );
  }
}
