import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/widgets/bottom_buttons.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/promo/BLoC/horizontal_listview_switcher_cubit.dart';
import 'package:kinda_work/widgets.dart';

class Beauty extends StatelessWidget {
  const Beauty({
    Key key,
    this.currentIndex,
  }) : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    List<String> _listViewData = [
      'Маникюр',
      'Мейкап',
      'Спа-салон',
      'Парикмахерские',
      'Бани',
      'Хамам',
    ];
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(size: _size, title: 'Красота'),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      _size.width * cHorizont,
                      _size.height * 0.02,
                      0.0,
                      _size.height * 0.04,
                    ),
                    //TODO change to TabBar see in info_element_page.dart
                    child: BlocProvider(
                      create: (context) => SwitcherHorigontalListViewCubit(),
                      child: BlocBuilder<SwitcherHorigontalListViewCubit, int>(
                        builder: (context, selectedElement) {
                          return CustomHorizontalListView(
                            size: _size,
                            listViewData: _listViewData,
                            selectedElement: selectedElement,
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: _size.width * cHorizont),
                    child: Column(
                      children: [
                        CustomFilterSortBar(size: _size),
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
            ),
            Positioned(
              bottom: _size.height * 0.0025,
              width: _size.width,
              child: BottomButtons(size: _size),
            ),
          ],
        ),
        bottomNavigationBar:
            CustomBottomNavBar(size: _size, currentIndex: currentIndex),
      ),
    );
  }
}
