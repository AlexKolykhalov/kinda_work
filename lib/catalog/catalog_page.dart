import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/widgets/bottom_buttons.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/main/widgets/features_list.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/widgets.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    print('-->CatalogPage');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Каталог, привилегии'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: _size.height * 0.02),
                child: FeaturesList(size: _size, currentIndex: 1),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: _size.width * cHorizont),
                child: Column(
                  children: [
                    CustomGridViewTitle(
                      size: _size,
                      title: 'Рестораны и кафе',
                      textTotalAmount: '127 из 45090',
                    ),
                    CustomGridView(
                      size: _size,
                      childAspectRatio: cRatioSmallSize,
                      infoElements: popularPlaces,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        0.0,
                        _size.height * 0.03,
                        0.0,
                        _size.height * 0.06,
                      ),
                      child: CustomButton(
                        onTap: null,
                        buttonText: 'Смотреть все предложения',
                        buttonColor: cGrey,
                        buttonTextColor: cIndigo,
                        buttonBorderColor: cIndigo,
                      ),
                    ),
                    CustomGridViewTitle(
                      size: _size,
                      title: 'Красота',
                      textTotalAmount: '127 из 34567',
                    ),
                    CustomGridView(
                      size: _size,
                      childAspectRatio: cRatioSmallSize,
                      infoElements: popularPlaces,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        0.0,
                        _size.height * 0.03,
                        0.0,
                        _size.height * 0.06,
                      ),
                      child: CustomButton(
                        onTap: null,
                        buttonText: 'Смотреть все предложения',
                        buttonColor: cGrey,
                        buttonTextColor: cIndigo,
                        buttonBorderColor: cIndigo,
                      ),
                    ),
                    CustomGridViewTitle(
                      size: _size,
                      title: 'Развлечения',
                      textTotalAmount: '127 из 56789',
                    ),
                    CustomGridView(
                      size: _size,
                      childAspectRatio: cRatioSmallSize,
                      infoElements: popularPlaces,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        0.0,
                        _size.height * 0.03,
                        0.0,
                        _size.height * 0.06,
                      ),
                      child: CustomButton(
                        onTap: null,
                        buttonText: 'Смотреть все предложения',
                        buttonColor: cGrey,
                        buttonTextColor: cIndigo,
                        buttonBorderColor: cIndigo,
                      ),
                    ),
                    CustomGridViewTitle(
                      size: _size,
                      title: 'Авто и мото',
                      textTotalAmount: '127 из 1234',
                    ),
                    CustomGridView(
                      size: _size,
                      childAspectRatio: cRatioSmallSize,
                      infoElements: popularPlaces,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        0.0,
                        _size.height * 0.03,
                        0.0,
                        _size.height * 0.06,
                      ),
                      child: CustomButton(
                        onTap: null,
                        buttonText: 'Смотреть все предложения',
                        buttonColor: cGrey,
                        buttonTextColor: cIndigo,
                        buttonBorderColor: cIndigo,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: _size.height * 0.04),
                      child: BottomButtons(size: _size),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(size: _size, currentIndex: 1),
      ),
    );
  }
}
