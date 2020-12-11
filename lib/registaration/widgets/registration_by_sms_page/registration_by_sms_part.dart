import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/registaration/pages/registration_by_email_page.dart';
import 'package:kinda_work/widgets.dart';

class RegistrationBySmsPart extends StatefulWidget {
  const RegistrationBySmsPart({Key key}) : super(key: key);

  @override
  _RegistrationBySmsPartState createState() => _RegistrationBySmsPartState();
}

class _RegistrationBySmsPartState extends State<RegistrationBySmsPart> {
  Size _size;
  TextEditingController _smsController;

  @override
  void initState() {
    super.initState();
    _smsController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _smsController.dispose();
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
              child: TextField(
                controller: _smsController,
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'СМС код',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: _size.width * 0.05),
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
                    RegistrationByEmailPage(),
              ),
            ),
            buttonText: 'Отправить код',
            buttonTextColor: Colors.white,
            buttonColor: cPink,
          ),
        ],
      ),
    );
  }
}
