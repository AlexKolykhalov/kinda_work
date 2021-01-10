import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/widgets/bottom_buttons.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/promo/BLoC/horizontal_listview_switcher_cubit.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

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
    List<String> _listViewData = [
      'Рестораны',
      'Кафе',
      'Бары',
      'Закусочные',
      'Пивные',
      'Столовые',
    ];
    print('-->PromotionsPage');
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return Scaffold(
              appBar: CustomAppBar(
                height: appBarHeight(context),
                showBackArrow: false,
                title: 'Акции - бесплатно',
                bottom: AppBarBottom(
                  tabController: _tabController,
                  bottomData: [
                    'Все акции',
                    'Рестораны и кафе',
                    'Красота',
                    'Развлечения',
                    'Спорт',
                    'Авто',
                  ],
                  isScrollable: true,
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            BlocProvider(
                              create: (context) =>
                                  SwitcherHorigontalListViewCubit(),
                              child: BlocBuilder<
                                  SwitcherHorigontalListViewCubit, int>(
                                builder: (context, selectedElement) {
                                  return CustomHorizontalListView(
                                    listViewData: _listViewData,
                                    selectedElement: selectedElement,
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size(context, hor)),
                              child: Column(
                                children: [
                                  CustomFilterSortBar(),
                                  CustomGridView(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size(context, 0.03)),
                                    elements: popularPromotions,
                                    mainAxisSpacing: size(context, 0.02),
                                    crossAxisSpacing: size(context, 0.02),
                                  ),
                                  CustomGridView(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size(context, 0.03)),
                                    elements: popularPromotions,
                                    mainAxisSpacing: size(context, 0.02),
                                    crossAxisSpacing: size(context, 0.02),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: size(context, vert),
                        child: BottomButtons(
                          padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor),
                          ),
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
            );
          },
        );
      },
    );
  }
}
