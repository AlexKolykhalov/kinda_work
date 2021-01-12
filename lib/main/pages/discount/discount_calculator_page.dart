import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class DiscountCalculatorPage extends StatelessWidget {
  const DiscountCalculatorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->DiscountCalculatorPage');
    return Scaffold(
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
              keyboardType: TextInputType.number,
              maxLength: 16,
              hintText: 'Код (только цифры)',
            ),
            SizedBox(height: size(context, 0.035)),
            Text(
              'или номер телефона',
              style: style3(context).copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: size(context, 0.02)),
            PhoneTextField(
              maxLength: 9,
              hintText: '(XX) XXX-XX-XX',
            ),
          ],
        ),
      ),
    );
  }
}
