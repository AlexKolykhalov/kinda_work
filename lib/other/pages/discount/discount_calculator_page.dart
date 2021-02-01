import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class DiscountCalculatorPage extends StatelessWidget {
  const DiscountCalculatorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->DiscountCalculatorPage');
    double _hor = size(context, hor);
    double _vert = size(context, vert);
    return Scaffold(
      appBar: CustomAppBar(
        height: appBarHeight(context),
        title: 'Калькулятор скидки',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Для фиксации и вычисления скидки пользователя введите код',
              style: style3(context).copyWith(color: Colors.grey[600]),
            ),
            SizedBox(height: _hor),
            CustomTextField(
              keyboardType: TextInputType.number,
              maxLength: 16,
              hintText: 'Код (только цифры)',
            ),
            SizedBox(height: _vert),
            Text(
              'или номер телефона',
              style: style3(context).copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: _hor),
            PhoneTextField(maxLength: 9),
          ],
        ),
      ),
    );
  }
}
