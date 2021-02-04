import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/styles.dart';

class BeautyPage extends StatelessWidget {
  const BeautyPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('***BeautyPage***');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(height: appBarHeight(context), title: 'Красота'),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: CustomTabBar(
                tabs: [
                  Text('Маникюр', style: style3(context)),
                  Text('Мейкап', style: style3(context)),
                  Text('Спа-салон', style: style3(context)),
                  Text('Парикмахерские', style: style3(context)),
                  Text('Бани', style: style3(context)),
                  Text('Хамам', style: style3(context)),
                ],
                paddingTabs:
                    EdgeInsets.symmetric(vertical: size(context, vert)),
                marginTabs: EdgeInsets.only(left: size(context, hor)),
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        child: Column(
                          children: [
                            CustomFilterSortBar(),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: _size.height * 0.02),
                            //   child: CustomGridViewElement(
                            //     infoElement: InfoElement(
                            //       isLargeGridElement: true,
                            //       img: 'assets/png/grid/1.png',
                            //       lightText:
                            //           'Студия ногтевого сервиса и наращивания волос',
                            //       boltText: 'Beauty-Express',
                            //       rate: 9.8,
                            //       isFavoriteVisible: false,
                            //       isDiscountVisible: true,
                            //       discount: 45,
                            //       countMessages: 1250,
                            //     ),
                            //     gridElementSize: Size(120.0, 180.0),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: _size.height * 0.02),
                            //   child: CustomGridViewElement(
                            //     infoElement: InfoElement(
                            //       isLargeGridElement: true,
                            //       img: 'assets/png/grid/1.png',
                            //       lightText:
                            //           'Студия ногтевого сервиса и наращивания волос',
                            //       boltText: 'Beauty-Express',
                            //       rate: 0.0,
                            //       isFavoriteVisible: false,
                            //       isDiscountVisible: false,
                            //     ),
                            //     gridElementSize: Size(120.0, 180.0),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: _size.height * 0.02),
                            //   child: CustomGridViewElement(
                            //     infoElement: InfoElement(
                            //       isLargeGridElement: true,
                            //       img: 'assets/png/grid/1.png',
                            //       lightText:
                            //           'Студия ногтевого сервиса и наращивания волос',
                            //       boltText: 'Beauty-Express',
                            //       rate: 0.0,
                            //       isFavoriteVisible: false,
                            //       isDiscountVisible: false,
                            //     ),
                            //     gridElementSize: Size(120.0, 180.0),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.only(bottom: _size.height * 0.02),
                            //   child: CustomGridViewElement(
                            //     infoElement: InfoElement(
                            //       isLargeGridElement: true,
                            //       img: 'assets/png/grid/1.png',
                            //       lightText:
                            //           'Студия ногтевого сервиса и наращивания волос',
                            //       boltText: 'Beauty-Express',
                            //       rate: 0.0,
                            //       isFavoriteVisible: false,
                            //       isDiscountVisible: false,
                            //     ),
                            //     gridElementSize: Size(120.0, 180.0),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
            Positioned(
              // TODO сделать общий Widget для
              // позиционных элементов в стэке
              bottom: size(context, 0.085),
              child: BottomButtons(
                padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
