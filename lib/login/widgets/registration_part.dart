import 'package:flutter/material.dart';

import 'package:kinda_work/registaration/reg_page.dart';

class RegistrationPart extends StatelessWidget {
  const RegistrationPart({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Еще не зарегистрировались?',
              style: TextStyle(fontSize: size.height * 0.025)),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(seconds: 0),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      RegistrationPage(),
                )
                // MaterialPageRoute(
                //   builder: (context) => RegistrationPage(),
                // ),
                ),
            child: Text(
              'Зарегистрироваться',
              style:
                  TextStyle(color: Colors.pink, fontSize: size.height * 0.025),
            ),
          ),
        ],
      ),
    );
  }
}
