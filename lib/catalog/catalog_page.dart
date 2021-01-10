import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/widgets/bottom_buttons.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/main/widgets/features_list.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->CatalogPage');
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return Scaffold(
              appBar: CustomAppBar(
                height: appBarHeight(context),
                showBackArrow: false,
                title: 'Каталог, привилегии',
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Sections(
                      padding: EdgeInsets.only(left: size(context, hor)),
                      elements: sectionsElements,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size(context, hor)),
                      child: Column(
                        children: [
                          CustomGridViewTitle(
                            padding: EdgeInsets.only(top: size(context, vert)),
                            title: 'Рестораны и кафе',
                            textTotalAmount: '127 из 45090',
                          ),
                          CustomGridView(
                            padding: EdgeInsets.symmetric(
                                vertical: size(context, 0.03)),
                            elements: popularPlaces,
                            mainAxisSpacing: size(context, 0.02),
                            crossAxisSpacing: size(context, 0.02),
                          ),
                          CustomButton(
                            onTap: null,
                            buttonText: 'Смотреть все предложения',
                            buttonColor: cGrey,
                            buttonTextColor: cIndigo,
                            buttonBorderColor: cIndigo,
                          ),
                          CustomGridViewTitle(
                            padding: EdgeInsets.only(top: size(context, vert)),
                            title: 'Красота',
                            textTotalAmount: '127 из 34567',
                          ),
                          CustomGridView(
                            padding: EdgeInsets.symmetric(
                                vertical: size(context, 0.03)),
                            elements: popularPlaces,
                            mainAxisSpacing: size(context, 0.02),
                            crossAxisSpacing: size(context, 0.02),
                          ),
                          CustomButton(
                            onTap: null,
                            buttonText: 'Смотреть все предложения',
                            buttonColor: cGrey,
                            buttonTextColor: cIndigo,
                            buttonBorderColor: cIndigo,
                          ),
                          CustomGridViewTitle(
                            padding: EdgeInsets.only(top: size(context, vert)),
                            title: 'Развлечения',
                            textTotalAmount: '127 из 56789',
                          ),
                          CustomGridView(
                            padding: EdgeInsets.symmetric(
                                vertical: size(context, 0.03)),
                            elements: popularPlaces,
                            mainAxisSpacing: size(context, 0.02),
                            crossAxisSpacing: size(context, 0.02),
                          ),
                          CustomButton(
                            onTap: null,
                            buttonText: 'Смотреть все предложения',
                            buttonColor: cGrey,
                            buttonTextColor: cIndigo,
                            buttonBorderColor: cIndigo,
                          ),
                          CustomGridViewTitle(
                            padding: EdgeInsets.only(top: size(context, vert)),
                            title: 'Авто и мото',
                            textTotalAmount: '127 из 1234',
                          ),
                          CustomGridView(
                            padding: EdgeInsets.symmetric(
                                vertical: size(context, 0.03)),
                            elements: popularPlaces,
                            mainAxisSpacing: size(context, 0.02),
                            crossAxisSpacing: size(context, 0.02),
                          ),
                          CustomButton(
                            margin:
                                EdgeInsets.only(bottom: size(context, 0.03)),
                            onTap: null,
                            buttonText: 'Смотреть все предложения',
                            buttonColor: cGrey,
                            buttonTextColor: cIndigo,
                            buttonBorderColor: cIndigo,
                          ),
                          BottomButtons(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
