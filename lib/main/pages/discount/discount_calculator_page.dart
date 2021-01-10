import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/pages/discount/discount_details_page.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

Map<String, bool> _map = {'textfield': false, 'phonetextfield': false};

void _validation(BuildContext context) {}

class DiscountCalculatorPage extends StatefulWidget {
  const DiscountCalculatorPage({Key key}) : super(key: key);

  @override
  _DiscountCalculatorPageState createState() => _DiscountCalculatorPageState();
}

class _DiscountCalculatorPageState extends State<DiscountCalculatorPage> {
  Size _size;
  TextEditingController _codeController;
  TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(); //..addListener(_valid);
    _phoneController = TextEditingController(); //..addListener(_valid);
  }

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future _valid(BuildContext context) {
    return Future.delayed(
      Duration(seconds: 1),
      () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: 0),
          pageBuilder: (context, animation, secondaryAnimation) =>
              DiscountDetailsPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Калькулятор скидки',
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size(context, hor),
            vertical: size(context, vert),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Для фиксации и вычисления скидки пользователя введите код',
                style: style3(context).copyWith(color: Colors.grey[600]),
              ),
              SizedBox(height: size(context, 0.02)),
              CustomTextField(
                onChanged: (value) {
                  if (value.length == 16) {
                    _map['textfield'] = true;
                    return _validation(context);
                  }
                },
                keyboardType: TextInputType.number,
                maxLength: 16,
                hintText: 'Код (только цифры)',
              ),
              // TextField(
              //   controller: _codeController,
              //   onEditingComplete: () {
              //     if (_codeController.text.length == 16 &&
              //         _phoneController.text.length == 9) {
              //       return _valid(context);
              //     }
              //   },
              //   maxLength: 16,
              //   keyboardType: TextInputType.number,
              //   textAlignVertical: TextAlignVertical.center,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     filled: true,
              //     fillColor: Colors.white,
              //     hintText: 'Код (только цифры)',
              //     contentPadding:
              //         EdgeInsets.symmetric(horizontal: _size.width * 0.05),
              //   ),
              // ),
              SizedBox(height: size(context, 0.035)),
              Text(
                'или номер телефона',
                style: style3(context).copyWith(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: size(context, 0.02)),
              PhoneTextField(maxLength: 9),
              // TextField(
              //   controller: _phoneController,
              //   onEditingComplete: () {
              //     if (_codeController.text.length == 16 &&
              //         _phoneController.text.length == 9) {
              //       return _valid(context);
              //     }
              //   },
              //   maxLength: 9,
              //   keyboardType: TextInputType.phone,
              //   textAlignVertical: TextAlignVertical.center,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(),
              //     fillColor: Colors.white,
              //     filled: true,
              //     hintText: '(XX) XXX-XX-XX',
              //     contentPadding:
              //         EdgeInsets.symmetric(horizontal: _size.width * 0.05),
              //     prefixIcon: Container(
              //       width: _size.width * 0.18,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           Text(
              //             '+375',
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           Icon(
              //             Icons.keyboard_arrow_down,
              //             color: Colors.grey,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
