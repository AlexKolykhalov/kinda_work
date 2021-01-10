import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class PromotionConditionsPage extends StatelessWidget {
  const PromotionConditionsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: EdgeInsets.only(bottom: size(context, 0.01)),
                child: Text(
                  'Скидка не распространяется на:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size(context, 0.03)),
                child: Text(
                  'Новогодние предложения, обеденное и банкетное меню, алкоголь, табачные изделия, барную продукцию, акционные товары и специальные предложения',
                  style: TextStyle(fontSize: 13.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size(context, 0.01)),
                child: Text(
                  'Условия предоставления скидки:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size(context, 0.03)),
                child: Text(
                  'Скидка предоставляется бесплатно!',
                  style: TextStyle(fontSize: 13.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size(context, 0.01)),
                child: Text(
                  'Как получить скидку:',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size(context, 0.03)),
                child: Text(
                  'Перед расчетом сообщите о наличии скидки от Zabava.by, нажмите кнопку "Предъявить скидку" на странице заведения. При заказе доставки по телефону сообщи свой номер телефона.',
                  style: TextStyle(fontSize: 13.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
