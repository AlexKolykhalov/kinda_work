import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/BLoC/switcher_icon_cubit.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    Key key,
    @required this.emailPhoneController,
  }) : super(key: key);

  final TextEditingController emailPhoneController;

  @override
  Widget build(BuildContext context) {
    //TODO make propper phone number fotmatter
    Size _size = MediaQuery.of(context).size;
    return TextField(
      controller: emailPhoneController,
      keyboardType: TextInputType.phone,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: _size.width * 0.05),
        prefixIcon: Container(
          width: _size.width * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '+375',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            emailPhoneController.clear();
            BlocProvider.of<SwitcherIconCubit>(context).changed();
          },
          icon: Icon(Icons.email, color: cPink),
        ),
        isCollapsed: true,
      ),
    );
  }
}
