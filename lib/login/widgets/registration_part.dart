import 'package:flutter/material.dart';

import 'package:kinda_work/registaration/reg_page.dart';

class RegistrationPart extends StatelessWidget {
  const RegistrationPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Еще не зарегистрировались?',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025)),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(seconds: 0),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    RegistrationPage(),
              ),
            ),
            child: Text(
              'Зарегистрироваться',
              style: TextStyle(
                  color: Colors.pink,
                  fontSize: MediaQuery.of(context).size.height * 0.025),
            ),
          ),
        ],
      ),
    );
  }
}
