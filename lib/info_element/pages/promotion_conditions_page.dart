import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/styles.dart';

class PromotionConditionsPage extends StatelessWidget {
  const PromotionConditionsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle _style2 =
        style2(context).copyWith(fontWeight: FontWeight.bold);
    final TextStyle _style3 = style3(context);
    final double _offset01 = size(context, 0.01);
    final double _offset03 = size(context, 0.03);
    // TODO проверить все SafeArea, возможно
    // где-то не понадобятся
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Условия акции',
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size(context, hor),
            vertical: size(context, vert),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Скидка не распространяется на:', style: _style2),
              SizedBox(height: _offset01),
              Text(
                'Новогодние предложения, обеденное и банкетное меню, алкоголь, табачные изделия, барную продукцию, акционные товары и специальные предложения',
                style: _style3,
              ),
              SizedBox(height: _offset03),
              Text('Условия предоставления скидки:', style: _style2),
              SizedBox(height: _offset01),
              Text('Скидка предоставляется бесплатно!', style: _style3),
              SizedBox(height: _offset03),
              Text('Как получить скидку:', style: _style2),
              SizedBox(height: _offset01),
              Text(
                'Перед расчетом сообщите о наличии скидки от Zabava.by, нажмите кнопку "Предъявить скидку" на странице заведения. При заказе доставки по телефону сообщи свой номер телефона.',
                style: _style3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
