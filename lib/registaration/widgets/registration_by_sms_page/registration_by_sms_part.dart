import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/registaration/pages/registration_by_email_page.dart';
import 'package:kinda_work/widgets.dart';

class RegistrationBySmsPart extends StatefulWidget {
  const RegistrationBySmsPart({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  _RegistrationBySmsPartState createState() => _RegistrationBySmsPartState();
}

class _RegistrationBySmsPartState extends State<RegistrationBySmsPart> {
  TextEditingController _smsController;

  @override
  void initState() {
    super.initState();
    _smsController = TextEditingController();
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
            padding: EdgeInsets.only(bottom: widget.size.height * 0.05),
            child: Text(
              'Регистрация',
              style: TextStyle(fontSize: widget.size.height * 0.03),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: widget.size.height * 0.02),
            child: Container(
              //height: widget.size.height * cHeight,
              child: TextField(
                controller: _smsController,
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'СМС код',
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: widget.size.width * 0.05),
                ),
              ),
            ),
          ),
          CustomButton(
            onTap: RegistrationByEmailPage(),
            //size: widget.size,
            buttonText: 'Отправить код',
            buttonTextColor: Colors.white,
            buttonColor: cPink,
          ),
        ],
      ),
    );
  }
}
