import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/grid_view.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/list_view.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/styles.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('***CatalogPage***');
    double _hor = size(context, hor);
    double _vert = size(context, vert);
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
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Sections(
                          padding: EdgeInsets.only(left: _hor),
                          margin: EdgeInsets.symmetric(vertical: _vert),
                          elements: sectionElements,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: _hor),
                          child: Column(
                            children: [
                              CustomGridViewTitle(
                                title: 'Рестораны и кафе',
                                textTotalAmount: '127 из 45090',
                              ),
                              CustomGridView(
                                padding: EdgeInsets.symmetric(vertical: _vert),
                                elements: popularCompanies,
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
                              CustomGridViewTitle(
                                padding: EdgeInsets.only(top: _vert),
                                title: 'Красота',
                                textTotalAmount: '127 из 34567',
                              ),
                              CustomGridView(
                                padding: EdgeInsets.symmetric(vertical: _vert),
                                elements: popularCompanies,
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
                              CustomGridViewTitle(
                                padding: EdgeInsets.only(top: _vert),
                                title: 'Развлечения',
                                textTotalAmount: '127 из 56789',
                              ),
                              CustomGridView(
                                padding: EdgeInsets.symmetric(vertical: _vert),
                                elements: popularCompanies,
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
                              CustomGridViewTitle(
                                padding: EdgeInsets.only(top: _vert),
                                title: 'Авто и мото',
                                textTotalAmount: '127 из 1234',
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
                              SizedBox(height: size(context, 0.085)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: size(context, vert),
                    child: BottomButtons(
                      padding: EdgeInsets.symmetric(horizontal: _hor),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
