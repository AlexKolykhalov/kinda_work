import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/other/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:kinda_work/other/pages/profile/edit_profile/widgets.dart';
import 'package:kinda_work/other/pages/profile/widgets.dart';
import 'package:kinda_work/other/pages/review_page.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';

// TODO add final User user;
class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key key,
    this.user = user1,
  }) : super(key: key);

  final User user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  Widget _general;
  Widget _whereIWas;
  Widget _profileReviews;
  Widget _impressions;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _general = General(user: widget.user);
    // TODO must be parameter user: widget.user
    // & inside User must be whereIwas section
    _whereIWas = WhereIWas();
    _profileReviews = ProfileReviews();
    _impressions = Impressions();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Профиль',
          actions: [
            FlatButton(
              onPressed: () => null,
              minWidth: size(context, 0.07),
              padding: EdgeInsets.zero,
              child: Icon(
                Icons.exit_to_app,
                color: cPink,
                size: size(context, 0.035),
              ),
            ),
            FlatButton(
              onPressed: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      EditProfilePage(),
                ),
              ),
              minWidth: size(context, 0.07),
              padding: EdgeInsets.zero,
              child: Icon(
                Icons.edit_outlined,
                color: cPink,
                size: size(context, 0.035),
              ),
            ),
          ],
          bottom: AppBarBottom(
            tabController: _tabController,
            onTap: (value) {
              setState(() {
                _index = value;
              });
            },
            bottomData: [
              'Общее',
              'Где я был',
              'Отзывы',
              'Впечатления',
            ],
          ),
        ),
        body: IndexedStack(
          index: _index,
          children: [
            _general,
            _whereIWas,
            _profileReviews,
            _impressions,
          ],
        ),
      ),
    );
  }
}

// TODO постараться изменить StatefulWidget на StatelessWidget
class General extends StatefulWidget {
  const General({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  Map<String, dynamic> _rank;

  @override
  void initState() {
    _rank = getRank(widget.user.points);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight * 0.45,
            color: Colors.white,
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                padding: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.05),
                child: LayoutBuilder(
                  builder: (context, containerConstraints) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: containerConstraints.maxHeight * 0.55,
                            height: containerConstraints.maxHeight * 0.55,
                            decoration: BoxDecoration(
                              color: cPink,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: containerConstraints.maxHeight * 0.49,
                            height: containerConstraints.maxHeight * 0.49,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(widget.user.avatar),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: containerConstraints.maxHeight * 0.02,
                              ),
                              child: Text('Изменить фото',
                                  style:
                                      style4(context).copyWith(color: cPink)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    containerConstraints.maxHeight * 0.018,
                              ),
                              child: Text(
                                widget.user.name,
                                style: style1(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(_rank['status'], style: style4(context)),
                            Visibility(
                              visible: _rank['nextStatus'].isNotEmpty,
                              child: Text(
                                _rank['nextStatus'],
                                style: style4(context),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: constraints.maxWidth,
              child: LayoutBuilder(builder: (context, containerConstraints) {
                double _heightRow = containerConstraints.maxHeight * 0.47 / 4;
                return Column(
                  children: [
                    Container(
                      height: containerConstraints.maxHeight * 0.47,
                      child: Column(
                        children: [
                          Container(
                            height: _heightRow,
                            padding: EdgeInsets.symmetric(
                              horizontal: size(context, hor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${widget.user.giftPoints} ',
                                        style: style2(context).copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'баллов на подарки',
                                        style: style2(context).copyWith(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                CustomRedRightArrow(
                                  onPressed: () => Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          EditProfilePage(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 0.0,
                            indent: constraints.maxWidth * hor,
                            thickness: 1.0,
                          ),
                          Container(
                            height: _heightRow,
                            padding: EdgeInsets.symmetric(
                              horizontal: size(context, hor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Отзывы',
                                  style: style2(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${widget.user.reviews.length} отзыва',
                                  style: style2(context),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 0.0,
                            indent: constraints.maxWidth * hor,
                            thickness: 1.0,
                          ),
                          Container(
                            height: _heightRow,
                            padding: EdgeInsets.symmetric(
                              horizontal: size(context, hor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'День рождения',
                                  style: style2(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.user.birthday,
                                  style: style2(context),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 0.0,
                            indent: constraints.maxWidth * hor,
                            thickness: 1.0,
                          ),
                          Container(
                            height: _heightRow,
                            padding: EdgeInsets.symmetric(
                              horizontal: size(context, hor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Обо мне',
                                  style: style2(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.user.about,
                                  style: style2(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 0.0, thickness: 1.0),
                    Container(
                      height: containerConstraints.maxHeight * 0.49,
                      child: LayoutBuilder(
                        builder: (context, columnConstraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Container()),
                              FillScale(value: 65),
                              Expanded(child: Container()),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size(context, hor),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Осталось заполнить',
                                      style: style3(context).copyWith(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      height: _heightRow,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // TODO решить вопрос с соц. сетями
                                          Text(
                                            'Привязка соц. сетей',
                                            style: style2(context).copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '+25%',
                                                style: style2(context).copyWith(
                                                  color: cPink,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              CustomRedRightArrow(
                                                onPressed: () => null,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Divider(height: 0.0, thickness: 1.0),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class WhereIWas extends StatelessWidget {
  const WhereIWas({Key key}) : super(key: key);

  List<Widget> _getColumnElements(List elements, BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return elements
        .asMap()
        .entries
        .map(
          (entry) => Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _hor,
                  vertical: _vert,
                ),
                child: Column(
                  children: [
                    ColumnElementGeneral(
                      element: entry.value['object'],
                      visitTime: entry.value['visit_time'],
                      discountMoney: entry.value['discount_money'],
                      discountPoints: entry.value['discount_points'],
                      showArrow:
                          entry.value['object'] is Company ? true : false,
                    ),
                    SizedBox(height: _vert),
                    CustomButton(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ReviewPage(company: entry.value['object']),
                        ),
                      ),
                      buttonText: entry.value['object'] is Company
                          ? 'Оставить отзыв +110 баллов'
                          : 'Оставить отзыв +55 баллов',
                      buttonColor: cPink,
                      buttonTextColor: Colors.white,
                    )
                  ],
                ),
              ),
              Visibility(
                visible: entry.key != elements.length - 1,
                child: Divider(
                  thickness: 1.0,
                  indent: _hor,
                ),
              )
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: _vert),
          Container(
            padding: EdgeInsets.symmetric(horizontal: _hor),
            child: Text(
              'Вы посетили',
              style: style3(context).copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: _getColumnElements(
                whereIWas
                    .where((element) => element['object'] is Company)
                    .toList(),
                context),
          ),
          Divider(thickness: 1.0),
          SizedBox(height: _vert),
          Container(
            padding: EdgeInsets.symmetric(horizontal: _hor),
            child: Text(
              'Использованные акции',
              style: style3(context).copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: _getColumnElements(
                whereIWas
                    .where((element) => element['object'] is Promotion)
                    .toList(),
                context),
          ),
        ],
      ),
    );
  }
}

class ProfileReviews extends StatelessWidget {
  const ProfileReviews({Key key}) : super(key: key);
  // TODO add BLoC and get two List
  // places & promos
  List<Widget> _getColumnElements(List elements, BuildContext context) {
    return elements
        .asMap()
        .entries
        .map(
          (entry) => Column(
            children: [
              ColumnElementProfileReviews(review: entry.value),
              Visibility(
                visible: entry.key != elements.length - 1,
                child: Divider(indent: size(context, hor), thickness: 1.0),
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    final TextStyle _style = style3(context).copyWith(
      color: Colors.grey[600],
      fontWeight: FontWeight.bold,
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: _vert),
          Container(
            padding: EdgeInsets.symmetric(horizontal: _hor),
            child: Text('Отзывы о заведениях', style: _style),
          ),
          Column(
            children: _getColumnElements(
                reviews
                    .where((element) =>
                        element.objectReview is Company &&
                        element.author == user1)
                    .toList(),
                context),
          ),
          Divider(thickness: 1.0),
          SizedBox(height: _vert),
          Container(
            padding: EdgeInsets.symmetric(horizontal: _hor),
            child: Text('Отзывы об акциях', style: _style),
          ),
          Column(
            children: _getColumnElements(
                reviews
                    .where((element) =>
                        element.objectReview is Promotion &&
                        element.author == user1)
                    .toList(),
                context),
          ),
        ],
      ),
    );
  }
}

class Impressions extends StatelessWidget {
  const Impressions({Key key}) : super(key: key);

  List<Widget> _getColumnElements(List elements, BuildContext context) {
    final double _hor = size(context, hor);
    return elements
        .asMap()
        .entries
        .map(
          (entry) => Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _hor,
                  vertical: size(context, vert),
                ),
                child: Column(
                  children: [
                    ColumnElementGeneral(
                      element: entry.value['object'],
                      visitTime: entry.value['visit_time'],
                      discountMoney: entry.value['discount_money'],
                      discountPoints: entry.value['discount_points'],
                    ),
                    SizedBox(height: _hor),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: null,
                            buttonText: 'Я здесь не был',
                            buttonColor: cGrey,
                            buttonBorderColor: Colors.grey[600],
                            buttonTextColor: Colors.black,
                          ),
                        ),
                        SizedBox(width: _hor),
                        Expanded(
                          child: CustomButton(
                            onTap: () => Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ReviewPage(
                                  company: entry.value['object'],
                                ),
                              ),
                            ),
                            buttonText: 'Оставить отзыв',
                            buttonColor: cPink,
                            buttonTextColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: entry.key != elements.length - 1,
                child: Divider(
                  indent: _hor,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: _vert),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _hor),
              child: Text(
                'Ниже указаны заведения, в которых вы были, но не пользовались скидкой на посещение или акцией данных заведений. Вы все равно можете оставить отзыв об этом посещении.',
                style: style4(context).copyWith(color: Colors.grey[600]),
              ),
            ),
            SizedBox(height: _vert),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _hor,
                  ),
                  child: Text(
                    'Вы могли посетить',
                    style: style3(context).copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  children: _getColumnElements(
                    whereIWas
                        .where((element) => element['object'] is Company)
                        .toList(),
                    context,
                  ),
                ),
                Divider(thickness: 1.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
