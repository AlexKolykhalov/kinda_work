import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/registaration/pages/registration_by_sms_page.dart';
import 'package:kinda_work/widgets.dart';

class RegistrationDataPart extends StatefulWidget {
  const RegistrationDataPart({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  _RegistrationDataPartState createState() => _RegistrationDataPartState();
}

class _RegistrationDataPartState extends State<RegistrationDataPart> {
  TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
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
            padding: EdgeInsets.only(bottom: widget.size.height * 0.05),
            child: Text(
              'Регистрация',
              style: TextStyle(fontSize: widget.size.height * 0.03),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: widget.size.height * 0.02),
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
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: widget.size.width * 0.05),
                  prefix: Container(
                    width: widget.size.width * 0.2,
                    height: 48.0, //widget.size.height * cHeight,
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
                        Expanded(
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  isCollapsed: true,
                ),
              ),
            ),
          ),
          CustomButton(
            onTap: RegistrationBySmsPage(),
            // size: widget.size,
            buttonText: 'Получить СМС с кодом',
            buttonTextColor: Colors.white,
            buttonColor: cPink,
          ),
        ],
      ),
    );
  }
}
