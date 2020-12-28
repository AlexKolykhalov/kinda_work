import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/widgets/bottom_buttons.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/promo/BLoC/horizontal_listview_switcher_cubit.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({Key key}) : super(key: key);

  @override
  _PromotionsPageState createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    List<String> _listViewData = [
      'Рестораны',
      'Кафе',
      'Бары',
      'Закусочные',
      'Пивные',
      'Столовые',
    ];
    print('-->PromotionsPage');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Акции - бесплатно',
          tabController: _tabController,
          bottom: [
            'Все акции',
            'Рестораны и кафе',
            'Красота',
            'Развлечения',
            'Спорт',
            'Авто',
          ],
          isScrollable: true,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Stack(
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
                        child: BlocProvider(
                          create: (context) =>
                              SwitcherHorigontalListViewCubit(),
                          child:
                              BlocBuilder<SwitcherHorigontalListViewCubit, int>(
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
                            CustomGridView(
                              size: _size,
                              childAspectRatio: cRatioLargeSize,
                              infoElements: popularPromotions,
                            ),
                            CustomGridView(
                              size: _size,
                              childAspectRatio: cRatioMediumSize,
                              infoElements: popularPromotions,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: _size.width * cHorizont,
                  right: _size.width * cHorizont,
                  bottom: _size.height * 0.04,
                  //width: _size.width - (_size.width * cEditProfilePageHorizontal),
                  child: BottomButtons(size: _size),
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
        bottomNavigationBar: CustomBottomNavBar(currentIndex: 2),
      ),
    );
  }
}
