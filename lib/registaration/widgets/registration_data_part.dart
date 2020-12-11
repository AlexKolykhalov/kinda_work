import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/pages/discount/discount_calculator_page.dart';
import 'package:kinda_work/registaration/pages/registration_by_sms_page.dart';
import 'package:kinda_work/widgets.dart';

class RegistrationDataPart extends StatefulWidget {
  const RegistrationDataPart({Key key}) : super(key: key);

  @override
  _RegistrationDataPartState createState() => _RegistrationDataPartState();
}

class _RegistrationDataPartState extends State<RegistrationDataPart> {
  Size _size;
  TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _phoneController.dispose();
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
              //TODO make propper phone number fotmatter
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                  prefixIcon: Container(
                    width: _size.width * 0.18,
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
                    RegistrationBySmsPage(),
              ),
            ),
            buttonText: 'Получить СМС с кодом',
            buttonTextColor: Colors.white,
            buttonColor: cPink,
          ),
        ],
      ),
    );
  }
}
