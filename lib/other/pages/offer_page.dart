import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Оферта',
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size(context, hor),
            vertical: size(context, vert),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zabava.by - ваш личный гид в мире рекордный скидок',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Zabava.by - ваш личный гид в мире рекордный скидок и выгодных спецпредложений. Это уникальная возможность покупать продукцию известных брендов и пользоваться услугами популярных заведений самого широкого спектра - от ресторанов и развлекательных центров до салонов красоты и образовательных организаций, экономия до 90% от их обычной стоимости.',
                ),
                SizedBox(height: 10.0),
                Text(
                  'На сайте постоянно добавляются новые партнеры специально для вашего города.',
                ),
                SizedBox(height: 10.0),
                Text(
                  'Все предоставленные скидки, подарки и бонусы, - бесплатны.',
                ),
                SizedBox(height: 10.0),
                Text(
                  'Кроме того, Zabava.by - это еще и информационно-развлекательный ресурс. Мы не просто собираем для вас самые выгодные вырианты, но и в целом рассказываем о той продукции, что у нас представлена. Мы следим за последними тенденциями, честно указываем не только преимущества, но и недостатки тех или иных товаров или услуг, помогаем разобраться в большом ассортименте, отобрать то, что нужно именно вам.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
