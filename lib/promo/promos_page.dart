import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/grid_view.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/styles.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({Key key}) : super(key: key);

  @override
  _PromotionsPageState createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final Widget _allPromotions = AllPromotions();
  final Widget _restaurantsCafe = Container();
  final Widget _beaty = Container();
  final Widget _entertainment = Container();
  final Widget _sport = Container();
  final Widget _auto = Container();

  int _index = 0;

  @override
  void initState() {
    super.initState();
    // TODO если попробовать с TabBarView и все Widgets
    // запихнуть в initState или оставить там, где они
    // сейчас
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
                  onTap: (value) {
                    setState(() {
                      _index = value;
                    });
                  },
                  bottomData: [
                    'Все акции',
                    'Рестораны и кафе',
                    'Красота',
                    'Развлечения',
                    'Спорт',
                    'Авто',
                  ],
                  labelPadding: null,
                  isScrollable: true,
                ),
              ),
              body: IndexedStack(
                index: _index,
                children: [
                  _allPromotions,
                  _restaurantsCafe,
                  _beaty,
                  _entertainment,
                  _sport,
                  _auto,
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class AllPromotions extends StatelessWidget {
  const AllPromotions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Stack(
      children: [
        SingleChildScrollView(
          child: CustomTabBar(
            tabs: [
              Text('Рестораны', style: style3(context)),
              Text('Кафе', style: style3(context)),
              Text('Бары', style: style3(context)),
              Text('Закусочные', style: style3(context)),
              Text('Пивные', style: style3(context)),
              Text('Столовые', style: style3(context)),
            ],
            paddingTabs: EdgeInsets.symmetric(vertical: _vert),
            marginTabs: EdgeInsets.only(left: _hor),
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                child: Column(
                  children: [
                    CustomFilterSortBar(),
                    CustomGridView(
                      padding: EdgeInsets.symmetric(vertical: _vert),
                      elements: popularPromotions,
                      mainAxisSpacing: _hor,
                      crossAxisSpacing: _hor,
                    ),
                    CustomGridView(
                      padding: EdgeInsets.symmetric(vertical: _vert),
                      elements: popularPromotions,
                      mainAxisSpacing: _hor,
                      crossAxisSpacing: _hor,
                    ),
                    SizedBox(height: size(context, 0.085)),
                  ],
                ),
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
          bottom: _vert,
          child: BottomButtons(
            padding: EdgeInsets.symmetric(horizontal: _hor),
          ),
        ),
      ],
    );
  }
}
