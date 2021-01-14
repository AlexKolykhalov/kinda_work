import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/widgets/bottom_buttons.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class RestaurantsCafe extends StatelessWidget {
  const RestaurantsCafe({
    Key key,
    @required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    print('-->RestaurantsCafe');
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Рестораны и кафе',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: _size.height * 0.03),
              CustomGridViewTitle(
                title: 'Популярные места',
                textTotalAmount: '5394 из 15600',
              ),
              CustomGridView(elements: popularPlaces),
              CustomButton(
                onTap: null,
                buttonText: 'Смотреть все предложения',
                buttonColor: cGrey,
                buttonTextColor: cIndigo,
              ),
              CustomGridViewTitle(
                title: 'Популярные акции',
                textTotalAmount: '5090',
              ),
              CustomGridView(elements: popularPromotions),
              CustomButton(
                onTap: null,
                buttonText: 'Смотреть все предложения',
                buttonColor: cGrey,
                buttonTextColor: cIndigo,
              ),
              BottomButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
