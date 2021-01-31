import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/grid_view.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/styles.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  Widget _all = All();
  Widget _companies = Companies();
  Widget _promotions = Promotions();

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('-->FavoritesPage');
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(
            height: appBarHeight(context),
            title: 'Избранное',
            actions: [Icon(Icons.delete_outline, color: cPink)],
            bottom: AppBarBottom(
              tabController: _tabController,
              onTap: (value) {
                setState(() {
                  _index = value;
                });
              },
              bottomData: ['Все', 'Заведения', 'Акции'],
            ),
          ),
          body: IndexedStack(
            index: _index,
            children: [
              _all,
              _companies,
              _promotions,
            ],
          )

          // TabBarView(controller: _tabController, children: [
          //   All(),
          //   Companies(),
          //   Promotions(),
          // ]
          // ),
          ),
    );
  }
}

class All extends StatelessWidget {
  const All({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->All');
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    final TextStyle _style2 = style2(context);
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Заведения',
            style: _style2.copyWith(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: _vert),
            child: CustomGridView(
              elements: popularCompanies
                  .where((element) => element.favoriteSelected)
                  .toList(),
              mainAxisSpacing: _hor,
              crossAxisSpacing: _hor,
            ),
          ),
          Text(
            'Акции',
            style: _style2.copyWith(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: _vert),
            child: CustomGridView(
              elements: popularPromotions
                  .where((element) => element.favoriteSelected)
                  .toList(),
              mainAxisSpacing: _hor,
              crossAxisSpacing: _hor,
            ),
          ),
        ],
      ),
    ));
  }
}

class Companies extends StatelessWidget {
  const Companies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->Companies');
    return Container();
  }
}

class Promotions extends StatelessWidget {
  const Promotions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->Promotions');
    return Container();
  }
}
