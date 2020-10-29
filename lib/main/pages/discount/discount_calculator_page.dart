import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/main/pages/discount/discount_details_page.dart';

class DiscountCalculatorPage extends StatefulWidget {
  const DiscountCalculatorPage({Key key, @required this.size})
      : super(key: key);

  final Size size;

  @override
  _DiscountCalculatorPageState createState() => _DiscountCalculatorPageState();
}

class _DiscountCalculatorPageState extends State<DiscountCalculatorPage> {
  TextEditingController _codeController;
  TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController()..addListener(_valid);
    _phoneController = TextEditingController()..addListener(_valid);
  }

  @override
  void dispose() {
    _codeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _valid() {
    if (_codeController.text.length == 16 &&
        _phoneController.text.length == 9) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 0),
          pageBuilder: (context, animation, secondaryAnimation) =>
              DiscountDetailsPage(size: widget.size),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: FlatButton(
            onPressed: () => Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MainPage(),
              ),
            ),
            child: SvgPicture.asset(
              'assets/svg/left_arrow.svg',
              fit: BoxFit.contain,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Калькулятор скидки',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.size.width * cHorizont,
            vertical: widget.size.height * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Для фиксации и вычисления скидки пользователя введите код',
                style: TextStyle(color: Colors.grey[600]),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  0.0,
                  widget.size.height * cVertical,
                  0.0,
                  0.0,
                ),
                child: TextField(
                  controller: _codeController,
                  maxLength: 16,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Код (только цифры)',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: widget.size.width * 0.05),
                  ),
                ),
              ),
              Text(
                'или номер телефона',
                style: TextStyle(color: Colors.grey[600]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: widget.size.height * cVertical),
                child: TextField(
                  controller: _phoneController,
                  maxLength: 9,
                  keyboardType: TextInputType.phone,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: '(XX) XXX-XX-XX',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: widget.size.width * 0.05),
                    prefixIcon: Container(
                      width: widget.size.width * 0.18,
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
            ],
          ),
        ),
      ),
    );
  }
}
