import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/info_element/info_element_widgets.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/badges.dart';
import 'package:kinda_work/shared_widgets/grid_view.dart';
import 'package:kinda_work/shared_widgets/list_view.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/repository.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({
    Key key,
    @required this.company,
  }) : super(key: key);

  final Company company;

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  Widget _description;
  Widget _prices;
  Widget _reviews;
  Widget _newsFeed;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _description = Description(company: widget.company);
    _prices = Prices(menu: widget.company.menu);
    _reviews = CompanyReviews(company: widget.company);
    _newsFeed = NewsFeed(news: widget.company.news);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('***CompanyPage***');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Подробности места',
          actions: [
            CustomFlatButton(
              icon: widget.company.favorite
                  ? Icon(
                      Icons.favorite,
                      color: cPink,
                    )
                  : Icon(
                      Icons.favorite_border_outlined,
                      color: cPink,
                    ),
            ),
          ],
          bottom: AppBarBottom(
            tabController: _tabController,
            onTap: (int value) {
              setState(() {
                _index = value;
              });
            },
            bottomData: [
              'Описание',
              'Цена',
              'Отзывы',
              'Лента',
            ],
          ),
        ),
        body: IndexedStack(
          index: _index,
          children: [
            _description,
            _prices,
            _reviews,
            _newsFeed,
          ],
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.company,
  }) : super(key: key);

  final Company company;

  @override
  Widget build(BuildContext context) {
    print('-->Description');
    double _hor = size(context, hor);
    double _vert = size(context, vert);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              CustomGridViewTitle(
                padding: EdgeInsets.symmetric(
                  horizontal: _hor,
                  vertical: _vert,
                ),
                title: 'Часто просматривают',
                textTotalAmount: '',
              ),
              CustomHorizontalListViewCompanies(
                padding: EdgeInsets.only(left: _hor),
                elements: popularCompanies,
              ),
              Container(
                height: size(context, 0.8),
                margin: EdgeInsets.symmetric(vertical: _vert),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: constraints.maxHeight * 0.45,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  // TODO должен быть Slider
                                  image: AssetImage(company.img),
                                ),
                              ),
                            ),
                            Container(
                              height: constraints.maxHeight * 0.55,
                              padding: EdgeInsets.all(_hor),
                              color: Colors.white,
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  double _rowHeight =
                                      constraints.maxHeight * 0.11;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        company.type,
                                        style: style4(context)
                                            .copyWith(color: Colors.grey[600]),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.005,
                                      ),
                                      Text(
                                        company.name,
                                        style: style1(context).copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.005,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => displayRating(context),
                                            child: RateBadge(
                                                rate: 8.3,
                                                textColor: Colors.green),
                                          ),
                                          SizedBox(width: _hor),
                                          MessagesBadge(countMessages: 25),
                                        ],
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.02,
                                      ),
                                      Container(
                                        height: _rowHeight,
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on_outlined,
                                                size: style1(context).fontSize,
                                                color: Colors.grey[600]),
                                            SizedBox(width: _hor),
                                            Text(
                                              company.adress,
                                              style: style2(context),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: _rowHeight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  null,
                                                  size:
                                                      style1(context).fontSize,
                                                ),
                                                SizedBox(width: _hor),
                                                Text(
                                                  'Другие места',
                                                  style: style2(context)
                                                      .copyWith(color: cPink),
                                                ),
                                              ],
                                            ),
                                            CustomRedDownArrow(
                                              onPressed: null,
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: _rowHeight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  size:
                                                      style1(context).fontSize,
                                                  color: Colors.green,
                                                ),
                                                SizedBox(width: _hor),
                                                Text(
                                                  'Сегодня с 12:00 до 23:00',
                                                  style:
                                                      style2(context).copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            CustomRedDownArrow(
                                              onPressed: null,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: company.web.isNotEmpty,
                                        child: Container(
                                          height: _rowHeight,
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.check_box,
                                                size: style1(context).fontSize,
                                                color: Colors.grey[600],
                                              ),
                                              SizedBox(width: _hor),
                                              Text(
                                                company.web,
                                                style: style2(context).copyWith(
                                                  color: Colors.grey[600],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      CallReviewButtons(),
                                      Expanded(child: Container()),
                                      Center(
                                        child: Text(
                                          'Сообщите, что звоните с Zabava',
                                          style: style4(context)
                                              .copyWith(color: cPink),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          top: constraints.maxHeight * 0.4,
                          right: constraints.maxWidth * 0.02,
                          child: Container(
                            width: constraints.maxHeight * 0.1,
                            height: constraints.maxHeight * 0.1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600],
                                  blurRadius: 5.0,
                                )
                              ],
                              color: cPink,
                            ),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                return Icon(
                                  Icons.fact_check_outlined,
                                  color: Colors.white,
                                  size: constraints.maxHeight * 0.6,
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              CompanyFeatures(),
              Divider(thickness: 1.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Условия предоставления скидки',
                      style: style2(context).copyWith(color: Colors.grey[600]),
                    ),
                    CustomRedRightArrow(onPressed: null),
                  ],
                ),
              ),
              Divider(thickness: 1.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Меню и цены',
                          style: style3(context).copyWith(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Все меню (100)',
                          style: style2(context).copyWith(
                            color: cPink,
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: _vert),
                      child: Column(
                        children: company.menu
                            .take(2)
                            .toList()
                            .asMap()
                            .entries
                            .map(
                              (entry) => Column(
                                children: [
                                  MenuWidget(menu: entry.value),
                                  Visibility(
                                    visible: entry.key != 1,
                                    child: SizedBox(
                                      height: size(context, 0.015),
                                    ),
                                  )
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Отзывы (23)',
                            style: style3(context).copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Все отзывы (54)',
                            style: style2(context).copyWith(
                              color: cPink,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: _vert),
                      child: Column(
                        children: reviews
                            .where(
                              (element) => element.objectReview == company,
                            )
                            .take(2)
                            .toList()
                            .asMap()
                            .entries
                            .map(
                              (entry) => Column(
                                children: [
                                  ReviewWidget(review: entry.value),
                                  Visibility(
                                    visible: entry.key !=
                                        reviews
                                                .where(
                                                  (element) =>
                                                      element.objectReview ==
                                                      company,
                                                )
                                                .take(2)
                                                .length -
                                            1,
                                    child: Divider(
                                      thickness: 1.0,
                                      indent: _hor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              MapPart(position: LatLng(53.912280, 27.541818)),
              SizedBox(height: _vert),
              CustomGridViewTitle(
                padding: EdgeInsets.symmetric(
                  horizontal: _hor,
                ),
                title: 'Акции заведения',
                textTotalAmount: '',
              ),
              CustomHorizontalListViewPromos(
                  padding: EdgeInsets.only(left: _hor),
                  margin: EdgeInsets.symmetric(
                    vertical: _vert,
                  ),
                  elements: popularPromotions),
              CustomGridViewTitle(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                title: 'Часто просматривают',
                textTotalAmount: '',
              ),
              CustomHorizontalListViewCompanies(
                padding: EdgeInsets.only(left: _hor),
                margin: EdgeInsets.symmetric(vertical: _vert),
                elements: popularCompanies,
              ),
              // TODO точно подсчитать отступ от низа
              // текущий вариант варьируется в зависимости
              // от размера экрана
              SizedBox(height: size(context, 0.085)),
            ],
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: _vert,
          child: CustomButton(
            onTap: null,
            margin: EdgeInsets.symmetric(horizontal: _hor),
            text: 'Экономь с нами 20%',
            color: cPink,
            textColor: Colors.white,
          ),
        )
      ],
    );
  }
}

class Prices extends StatelessWidget {
  const Prices({
    Key key,
    @required this.menu,
  }) : super(key: key);

  final List<Menu> menu;

  @override
  Widget build(BuildContext context) {
    print('-->Prices');
    double _hor = size(context, hor);
    double _vert = size(context, vert);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Условия предоставления скидки',
                      style: style2(context),
                    ),
                    CustomRedRightArrow(onPressed: null)
                  ],
                ),
              ),
              Divider(thickness: 1.0),
              CustomTabBar(
                paddingTabs: EdgeInsets.only(left: _hor),
                marginTabs: EdgeInsets.symmetric(vertical: _vert),
                tabs: [
                  Text('Холодные закуски', style: style3(context)),
                  Text('Салаты', style: style3(context)),
                  Text('Супы', style: style3(context)),
                  Text('Горячие закуски', style: style3(context)),
                  Text('Гарниры', style: style3(context)),
                  Text('Десерты', style: style3(context)),
                ],
                children: [
                  Column(
                    children: [
                      CustomTabBar(
                        paddingTabs: EdgeInsets.only(left: _hor),
                        paddingChildren: EdgeInsets.symmetric(horizontal: _hor),
                        tabsStyle: TabsStyle(
                          indicatorColor: Colors.transparent,
                          labelColor: cPink,
                          unselectedLabelColor: Colors.grey[600],
                        ),
                        tabs: [
                          Text('Бутерброды', style: style3(context)),
                          Text('Десерты', style: style3(context)),
                          Text('Мороженое', style: style3(context)),
                        ],
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: _vert),
                                child: Column(
                                  children: menu
                                      .asMap()
                                      .entries
                                      .map(
                                        (entry) => Column(
                                          children: [
                                            MenuWidget(menu: entry.value),
                                            Visibility(
                                              visible:
                                                  entry.key != menu.length - 1,
                                              child: SizedBox(
                                                height: size(context, 0.015),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              CustomButton(
                                onTap: null,
                                text: 'Все блюда раздела (15)',
                                color: cGrey,
                                textColor: Colors.black,
                                borderColor: Colors.grey[600],
                              ),
                              SizedBox(height: size(context, 0.12)),
                            ],
                          ),
                          Container(),
                          Container(),
                        ],
                      )
                    ],
                  ),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: _vert,
          child: CustomButton(
            onTap: () => displayQrCode(context),
            margin: EdgeInsets.symmetric(horizontal: _hor),
            text: 'Предъявите скидку -20%',
            color: cPink,
            textColor: Colors.white,
          ),
        )
      ],
    );
  }
}

class CompanyReviews extends StatelessWidget {
  const CompanyReviews({
    Key key,
    @required this.company,
  }) : super(key: key);

  final Company company;

  @override
  Widget build(BuildContext context) {
    print('-->CompanyReviews');
    double _hor = size(context, hor);
    double _vert = size(context, vert);
    return Stack(
      children: [
        SingleChildScrollView(
          child: CustomTabBar(
            paddingTabs: EdgeInsets.symmetric(
              vertical: _vert,
            ),
            marginTabs: EdgeInsets.only(left: _hor),
            tabs: [
              Row(children: [
                Text(
                  'Отзывы наших пользователей (12) ',
                  style: style3(context),
                ),
                RateBadge(rate: 9.4),
              ]),
              Row(
                children: [
                  Text(
                    'Relax.',
                    style: style3(context),
                  ),
                  RateBadge(rate: 2.4),
                ],
              ),
            ],
            children: [
              Column(
                children: [
                  CustomButton(
                    margin: EdgeInsets.symmetric(horizontal: _hor),
                    onTap: null,
                    text: 'Оставить отзыв',
                    color: cGrey,
                    textColor: Colors.black,
                    borderColor: Colors.grey[600],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: _vert),
                    child: Column(
                      children: reviews
                          .where((element) => element.objectReview == company)
                          .toList()
                          .asMap()
                          .entries
                          .map(
                            (entry) => Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: _hor,
                                  ),
                                  child: ReviewWidget(review: entry.value),
                                ),
                                Divider(thickness: 1.0, indent: _hor),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  CustomButton(
                    margin: EdgeInsets.symmetric(horizontal: _hor),
                    onTap: null,
                    text: 'Еще 10 отзывов',
                    color: cGrey,
                    textColor: Colors.black,
                    borderColor: Colors.grey[600],
                  ),
                  SizedBox(height: size(context, 0.12)),
                ],
              ),
              Container(),
            ],
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: _vert,
          child: CustomButton(
            onTap: null,
            margin: EdgeInsets.symmetric(horizontal: _hor),
            text: 'Экономь с нами 20%',
            color: cPink,
            textColor: Colors.white,
          ),
        )
      ],
    );
  }
}

class NewsFeed extends StatelessWidget {
  const NewsFeed({
    Key key,
    this.news = const <News>[],
  }) : super(key: key);

  final List<News> news;

  @override
  Widget build(BuildContext context) {
    print('-->NewsFeed');
    double _hor = size(context, hor);
    double _vert = size(context, vert);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _hor,
                  vertical: _vert,
                ),
                child: Column(
                  children: news
                      .asMap()
                      .entries
                      .map((entry) => Column(
                            children: [
                              NewsWidget(news: entry.value),
                              Visibility(
                                visible: entry.key != news.length,
                                child: SizedBox(height: _vert),
                              )
                            ],
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: size(context, 0.12)),
            ],
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: _vert,
          child: CustomButton(
            onTap: null,
            margin: EdgeInsets.symmetric(horizontal: _hor),
            text: 'Экономь с нами 20%',
            color: cPink,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
