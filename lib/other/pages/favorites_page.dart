import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

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
            bottomData: ['Все', 'Заведения', 'Акции'],
          ),
        ),
        body: TabBarView(controller: _tabController, children: [
          All(),
          Places(),
          Promotions(),
        ]),
      ),
    );
  }
}

class All extends StatelessWidget {
  const All({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->All');
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: size(context, hor),
        vertical: size(context, vert),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Заведения',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          SizedBox(height: 15.0),
          CustomGridView(
            // size: _size,
            // childAspectRatio: cRatioSmallSize,
            elements: popularPlaces
                .where((element) => element.favoriteSelected)
                .toList(),
          ),
          SizedBox(height: 25.0),
          Text(
            'Акции',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          SizedBox(height: 15.0),
          CustomGridView(
            elements: popularPromotions
                .where((element) => element.favoriteSelected)
                .toList(),
          ),
        ],
      ),
    ));
  }
}

class Places extends StatelessWidget {
  const Places({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->Places');
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
