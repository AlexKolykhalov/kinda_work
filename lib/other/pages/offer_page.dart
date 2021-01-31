import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/styles.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->OfferPage');
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    final TextStyle _style3 = style3(context);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Оферта',
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zabava.by - ваш личный гид в мире рекордный скидок',
                  style: _style3.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: _hor),
                Text(
                  'Zabava.by - ваш личный гид в мире рекордный скидок и выгодных спецпредложений. Это уникальная возможность покупать продукцию известных брендов и пользоваться услугами популярных заведений самого широкого спектра - от ресторанов и развлекательных центров до салонов красоты и образовательных организаций, экономия до 90% от их обычной стоимости.',
                  style: _style3,
                ),
                SizedBox(height: _hor),
                Text(
                  'На сайте постоянно добавляются новые партнеры специально для вашего города.',
                  style: _style3,
                ),
                SizedBox(height: _hor),
                Text(
                  'Все предоставленные скидки, подарки и бонусы, - бесплатны.',
                  style: _style3,
                ),
                SizedBox(height: _hor),
                Text(
                  'Кроме того, Zabava.by - это еще и информационно-развлекательный ресурс. Мы не просто собираем для вас самые выгодные вырианты, но и в целом рассказываем о той продукции, что у нас представлена. Мы следим за последними тенденциями, честно указываем не только преимущества, но и недостатки тех или иных товаров или услуг, помогаем разобраться в большом ассортименте, отобрать то, что нужно именно вам.',
                  style: _style3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
