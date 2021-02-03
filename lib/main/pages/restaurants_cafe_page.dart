import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/grid_view.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/styles.dart';

class RestaurantsCafe extends StatelessWidget {
  const RestaurantsCafe({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('***RestaurantsCafe***');
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Рестораны и кафе',
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _hor,
                  vertical: _vert,
                ),
                child: Column(
                  children: [
                    CustomGridViewTitle(
                      title: 'Популярные места',
                      textTotalAmount: '5394 из 15600',
                    ),
                    CustomGridView(
                      padding: EdgeInsets.symmetric(vertical: _vert),
                      elements: popularCompanies,
                      mainAxisSpacing: _hor,
                      crossAxisSpacing: _hor,
                    ),
                    CustomButton(
                      margin: EdgeInsets.only(bottom: _vert),
                      onTap: null,
                      text: 'Смотреть все предложения',
                      color: cGrey,
                      textColor: cIndigo,
                      borderColor: cIndigo,
                    ),
                    CustomGridViewTitle(
                      title: 'Популярные акции',
                      textTotalAmount: '5090',
                    ),
                    CustomGridView(
                      padding: EdgeInsets.symmetric(vertical: _vert),
                      elements: popularPromotions,
                      mainAxisSpacing: _hor,
                      crossAxisSpacing: _hor,
                    ),
                    CustomButton(
                      onTap: null,
                      text: 'Смотреть все предложения',
                      color: cGrey,
                      textColor: cIndigo,
                      borderColor: cIndigo,
                    ),
                    SizedBox(
                      height: size(context, 0.085),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: _vert,
              child: BottomButtons(
                padding: EdgeInsets.symmetric(horizontal: _hor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
