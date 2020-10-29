import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/widgets.dart';

class DiscountConditionsPage extends StatelessWidget {
  const DiscountConditionsPage({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            size: size, title: 'Условия скидки', showActions: false),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * cHorizont,
              vertical: size.height * cVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.01),
                  child: Text(
                    'Скидка распространяется на:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.03),
                  child: Text(
                    'На всё меню в любой день в любое время работы заведения!',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.01),
                  child: Text(
                    'Скидка не распространяется на:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.03),
                  child: Text(
                    'Новогодние предложения, обеденное и банкетное меню, алкоголь, табачные изделия, барную продукцию, акционные товары и специальные предложения',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.01),
                  child: Text(
                    'Условия предоставления скидки:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.03),
                  child: Text(
                    'Скидка предоставляется бесплатно!',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.01),
                  child: Text(
                    'Как получить скидку:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.03),
                  child: Text(
                    'Перед расчетом сообщите о наличии скидки от Zabava.by, нажмите кнопку "Предъявить скидку" на странице заведения. При заказе доставки по телефону сообщи свой номер телефона.',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
                Divider(thickness: 1.5),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.03),
                  child: Text(
                      'Скидка не суммируется с другими скидками и акциями.',
                      style: TextStyle(fontSize: 12.0)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
