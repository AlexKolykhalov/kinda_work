import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinda_work/styles.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets.dart';

class PlacePage extends StatefulWidget {
  const PlacePage({Key key}) : super(key: key);

  @override
  _PlacePageState createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> with TickerProviderStateMixin {
  Size _size;
  bool _isVisible;
  TabController _tabController;
  TabController _tabController1;
  TabController _tabController2;
  TabController _tabControllerReviews;

  final int _recommRate = 0;
  final List<String> _listViewData = [
    'Холодные закуски',
    'Салаты',
    'Супы',
    'Горячие закуски',
    'Гарниры',
    'Десерты',
  ];

  final List<String> _listViewData1 = [
    'Бутерброды',
    'Десерты',
    'Мороженое',
  ];

  final List<Widget> _listViewDataReviews = [
    Row(children: [
      Text('Отзывы наших пользователей (12) '),
      RateBadge(rate: 9.4, textColor: Colors.white),
    ]),
    Row(children: [
      Text('Relax.'),
      RateBadge(rate: 2.4, textColor: Colors.white),
    ]),
  ];

  // TODO convert to Class
  final List<Map<String, dynamic>> _menu = [
    {
      'img': 'assets/png/grid/1.png',
      'name': 'Закуска "Селёдочка под водочку"',
      'description':
          'Филе сельди, лук репчатый красный, картофель отварной, руккола 100/100/20 г ',
      'new_price': 250,
      'old_price': 300,
    },
    {
      'img': 'assets/png/grid/2.png',
      'name': 'Закуска "Мясные медальоны"',
      'description':
          'Филе свинины, обжаренные в вине, с добавлением розмарина и цедры лайма',
      'new_price': 1500,
      'old_price': 3000,
    },
    {
      'img': 'assets/png/grid/3.png',
      'name': 'Стейк',
      'description': 'Мясной стейк средней прожарки',
      'new_price': 700,
      'old_price': 900,
    }
  ];

  final List<Map<String, dynamic>> _listNewsFeed = [
    {
      'date': '01.03.18',
      'img': 'assets/png/grid/1.png',
      'news': 'Самые вкусные пельмени у нас!',
    },
    {
      'date': '08.03.18',
      'img': 'assets/png/grid/2.png',
      'news':
          'Поздравляем дорогих женщин с 8 марта! Желаем счастья, здоровья и всевозможных благ!И больших творческих успехов!!!',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController1 = TabController(length: 6, vsync: this);
    _tabController2 = TabController(length: 3, vsync: this);
    _tabControllerReviews = TabController(length: 2, vsync: this);
    _isVisible = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController1.dispose();
    _tabController2.dispose();
    _tabControllerReviews.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Подробности места',
          actions: [Icon(Icons.favorite_border_outlined, color: cPink)],
          bottom: AppBarBottom(
            tabController: _tabController,
            bottomData: [
              'Описание',
              'Цена',
              'Отзывы',
              'Лента',
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Описание
            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        child: CustomGridViewTitle(
                          title: 'Часто просматривают',
                          textTotalAmount: '',
                        ),
                      ),
                      Container(
                        height: 350.0,
                        padding: EdgeInsets.only(left: size(context, hor)),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            width: 100.0,
                            child: CustomGridViewElement(
                              element: kventin,
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10.0),
                          itemCount: 1,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: size(context, vert)),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 250.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage('assets/png/grid/2.png'),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 310.0,
                                  width: _size.width,
                                  padding: EdgeInsets.all(size(context, vert)),
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Кафе',
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      Text(
                                        'Коттэ развесёлый бар',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => displayRating(context),
                                            child: RateBadge(
                                                rate: 8.3,
                                                textColor: Colors.green),
                                          ),
                                          SizedBox(width: 10.0),
                                          MessagesBadge(countMessages: 25),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,
                                              color: Colors.grey[600]),
                                          SizedBox(width: 10.0),
                                          Text(
                                            'г. Минск, ул. Мазурова, 24',
                                            style: TextStyle(fontSize: 17.0),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 34.0),
                                            child: Text(
                                              'Другие места',
                                              style: TextStyle(color: cPink),
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: cPink,
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: _size.width * 0.75,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: Colors.green,
                                                ),
                                                SizedBox(width: 10.0),
                                                Text(
                                                  'Сегодня с 12:00 до 23:00',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: cPink,
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_box,
                                              color: Colors.grey[600],
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              'www.kottebar.by',
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 16.0),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: _size.width * 0.43,
                                            child: CustomButton(
                                              onTap: () =>
                                                  displayPhones(context),
                                              buttonText: 'Позвонить',
                                              buttonColor: Colors.green,
                                              buttonTextColor: Colors.white,
                                            ),
                                          ),
                                          Container(
                                            width: _size.width * 0.43,
                                            child: CustomButton(
                                              onTap: null,
                                              buttonText: 'Оставить отзыв',
                                              buttonColor: Colors.white,
                                              buttonTextColor: Colors.black,
                                              buttonBorderColor:
                                                  Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Center(
                                        child: Text(
                                          'Сообщите, что звоните с Zabava',
                                          style: TextStyle(color: cPink),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              top: 230.0,
                              right: 8.0,
                              child: Container(
                                width: _size.height * 0.06,
                                height: _size.height * 0.06,
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
                                child: Icon(
                                  Icons.fact_check_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        child: GestureDetector(
                          behavior: HitTestBehavior
                              .opaque, //позволяет GestureDetector отрабатывать на все Row
                          onTap: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Особенности места',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Icon(
                                  _isVisible
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_up,
                                  color: cPink),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isVisible,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size(context, hor)),
                          margin: EdgeInsets.only(top: _size.height * 0.01),
                          width: _size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: cIndigo),
                                  children: [
                                    TextSpan(
                                        text: 'Курение: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: 'Запрещено'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: cIndigo),
                                  children: [
                                    TextSpan(
                                        text: 'Кухня: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: 'Японская, Белорусская'),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: cIndigo),
                                  children: [
                                    TextSpan(
                                        text: 'Музыка: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: 'Тихая фоновая, DJ-сеты'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(thickness: 1.0),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Условия предоставления скидки'),
                            Icon(Icons.keyboard_arrow_right, color: cPink),
                          ],
                        ),
                      ),
                      Divider(thickness: 1.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        margin: EdgeInsets.only(bottom: _size.height * 0.01),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: _size.height * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Меню и цены',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  Text(
                                    'Все меню (100)',
                                    style: TextStyle(
                                      color: cPink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            CustomMenuListView(menu: _menu)
                          ],
                        ),
                      ),
                      Divider(thickness: 1.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        margin: EdgeInsets.only(bottom: _size.height * 0.01),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(bottom: _size.height * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Отзывы (23)',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  Text(
                                    'Все отзывы (54)',
                                    style: TextStyle(
                                      color: cPink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // TODO Extract Widget see _getReviews
                            Container(
                              height: 350.0,
                              child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: _size.height * 0.07,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: _size.height *
                                                              0.07,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: AssetImage(
                                                                      'assets/png/face.png'))),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RichText(
                                                              text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text:
                                                                            'Елена ',
                                                                        style: TextStyle(
                                                                            color:
                                                                                cPink)),
                                                                    TextSpan(
                                                                        text:
                                                                            ' Юный герой',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey[600]))
                                                                  ]),
                                                            ),
                                                            Text(
                                                              '21.06.17',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600]),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width:
                                                            _size.height * 0.07,
                                                        height:
                                                            _size.height * 0.07,
                                                        padding: EdgeInsets.all(
                                                            _size.height *
                                                                0.01),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            color: Colors.white,
                                                            size: 18.0,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      Expanded(
                                                        child: Text(
                                                            'Ну очень долго все готовится, еда не плоха, официант не спешит.'),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width:
                                                            _size.height * 0.07,
                                                        child: Center(
                                                          child: Container(
                                                            width: 20.0 * 0.27,
                                                            height: 20.0 * 0.15,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.0),
                                                            ),
                                                            child: RateBadge(
                                                              rate: 8.2,
                                                              textColor:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/svg/restaurant_icons/restaurant.svg',
                                                            width: 15.0,
                                                            height: 15.0,
                                                          ),
                                                          SizedBox(width: 4.0),
                                                          RateBadge(
                                                            rate: 10,
                                                            textColor:
                                                                Colors.green,
                                                          ),
                                                          SizedBox(width: 10.0),
                                                          SvgPicture.asset(
                                                            'assets/svg/restaurant_icons/fork.svg',
                                                            width: 15.0,
                                                            height: 15.0,
                                                          ),
                                                          SizedBox(width: 4.0),
                                                          RateBadge(
                                                            rate: 10,
                                                            textColor:
                                                                Colors.green,
                                                          ),
                                                          SizedBox(width: 10.0),
                                                          SvgPicture.asset(
                                                            'assets/svg/restaurant_icons/invoice.svg',
                                                            width: 15.0,
                                                            height: 15.0,
                                                          ),
                                                          SizedBox(width: 4.0),
                                                          RateBadge(
                                                            rate: 10,
                                                            textColor:
                                                                Colors.green,
                                                          ),
                                                          SizedBox(width: 10.0),
                                                          SvgPicture.asset(
                                                            'assets/svg/restaurant_icons/happiness.svg',
                                                            width: 15.0,
                                                            height: 15.0,
                                                          ),
                                                          SizedBox(width: 4.0),
                                                          RateBadge(
                                                            rate: 10,
                                                            textColor:
                                                                Colors.green,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 12.0),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                      _size.height * 0.07 +
                                                          10.0,
                                                      0.0,
                                                      0.0,
                                                      0.0,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 55.0,
                                                          height: 25.5,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .orange[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              'Ответ',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 6.0),
                                                        Text(
                                                          'Анна, здравствуйте. Благодарим вас за обратную связь. Безумно стыдно за уровень сервиса, предоставленный вам :(',
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10.0),
                                                  child: Icon(Icons.remove),
                                                ),
                                                _recommRate == 0
                                                    ? Text('0')
                                                    : _recommRate > 0
                                                        ? Text(
                                                            '+${_recommRate.toString()}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green),
                                                          )
                                                        : Text(
                                                            '${_recommRate.toString()}',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Icon(Icons.add),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>

                                      //TODO look at this divider,

                                      // вывести ListView из Column c padding

                                      // и сделать нужный Divider

                                      Divider(thickness: 1.0),
                                  itemCount: 2),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      Container(
                        height: 250.0,
                        child: FlutterMap(
                          options: MapOptions(
                            center: LatLng(53.912280, 27.541818),
                            zoom: 16.0,
                          ),
                          children: [
                            TileLayerWidget(
                                options: TileLayerOptions(
                                    urlTemplate:
                                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                    subdomains: ['a', 'b', 'c'])),
                            MarkerLayerWidget(
                              options: MarkerLayerOptions(
                                markers: [
                                  buildCustomMarker(
                                    position: LatLng(53.912280, 27.541818),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        child: CustomGridViewTitle(
                          title: 'Акции заведения',
                          textTotalAmount: '',
                        ),
                      ),
                      Container(
                        height: 150.0,
                        padding: EdgeInsets.only(left: size(context, hor)),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            width: 20.0,
                            child: CustomGridViewElement(element: promo),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10.0),
                          itemCount: 1,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        child: CustomGridViewTitle(
                          title: 'Часто просматривают',
                          textTotalAmount: '',
                        ),
                      ),
                      Container(
                        height: 150.0,
                        padding: EdgeInsets.only(left: size(context, hor)),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            width: 20.0,
                            child: CustomGridViewElement(element: promo),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10.0),
                          itemCount: 1,
                        ),
                      ),
                      SizedBox(height: 90.0),
                    ],
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 25.0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size(context, hor)),
                    child: CustomButton(
                      onTap: null,
                      buttonText: 'Экономь с нами 20%',
                      buttonColor: cPink,
                      buttonTextColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            // Цена
            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // TODO подумать на SingleChildScrollView лучше const height & width
                      SizedBox(height: _size.height * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Условия предоставления скидки'),
                            Icon(Icons.keyboard_arrow_right, color: cPink),
                          ],
                        ),
                      ),
                      Divider(thickness: 1.0),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          size(context, hor),
                          _size.height * 0.02,
                          0.0,
                          _size.height * 0.04,
                        ),
                        child: Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: TabBar(
                            isScrollable: true,
                            controller: _tabController1,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.green),
                            labelColor: Colors.white,
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            unselectedLabelStyle:
                                TextStyle(fontWeight: FontWeight.normal),
                            unselectedLabelColor: Colors.black,
                            tabs: _listViewData
                                .map((e) => Container(
                                      height: 25.0,
                                      child: Tab(text: e),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 125.0 * _menu.length +
                            10.0 * (_menu.length - 1) +
                            48.0 * 2 +
                            60.0 +
                            25.0 +
                            15.0 +
                            2.0, //indicator weight by default
                        child:
                            TabBarView(controller: _tabController1, children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size(context, hor)),
                            child: Column(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: TabBar(
                                      isScrollable: true,
                                      controller: _tabController2,
                                      indicatorColor: Colors.transparent,
                                      labelColor: cPink,
                                      labelPadding:
                                          EdgeInsets.only(right: 15.0),
                                      unselectedLabelStyle: TextStyle(
                                          fontWeight: FontWeight.normal),
                                      unselectedLabelColor: Colors.grey[600],
                                      tabs: _listViewData1
                                          .map((e) => Container(
                                                height: 25.0,
                                                child: Tab(text: e),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: _tabController2,
                                    children: [
                                      Column(
                                        children: [
                                          CustomMenuListView(menu: _menu),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15.0),
                                            child: CustomButton(
                                              onTap: null,
                                              buttonText:
                                                  'Все блюда раздела (15)',
                                              buttonColor: cGrey,
                                              buttonTextColor: Colors.black,
                                              buttonBorderColor:
                                                  Colors.grey[600],
                                            ),
                                          ),
                                          SizedBox(height: 70.0),
                                        ],
                                      ),
                                      Container(),
                                      Container(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                          Container(),
                        ]),
                      )
                    ],
                  ),
                ),
                Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 25.0,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size(context, hor)),
                      child: CustomButton(
                        onTap: () => displayQrCode(context),
                        buttonText: 'Предъявите скидку -20%',
                        buttonColor: cPink,
                        buttonTextColor: Colors.white,
                      ),
                    ))
              ],
            ),
            // Отзывы
            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(height: _size.height * 0.02),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        size(context, hor),
                        _size.height * 0.02,
                        0.0,
                        _size.height * 0.04,
                      ),
                      child: CustomTabBar(
                          tabControllerReviews: _tabControllerReviews,
                          listViewDataReviews: _listViewDataReviews),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(size(context, hor), 0.0,
                          size(context, hor), _size.height * 0.04),
                      child: CustomButton(
                        onTap: null,
                        buttonText: 'Оставить отзыв',
                        buttonColor: cGrey,
                        buttonTextColor: Colors.black,
                        buttonBorderColor: Colors.grey[600],
                      ),
                    ),
                    Column(children: getReviews(reviews, _size)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size(context, hor),
                          vertical: _size.height * 0.04),
                      child: CustomButton(
                        onTap: null,
                        buttonText: 'Еще 10 отзывов',
                        buttonColor: cGrey,
                        buttonTextColor: Colors.black,
                        buttonBorderColor: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 70.0),
                  ]),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 25.0,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size(context, hor)),
                    child: CustomButton(
                      onTap: null,
                      buttonText: 'Экономь с нами 20%',
                      buttonColor: cPink,
                      buttonTextColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            // Лента
            Container(
              padding: EdgeInsets.fromLTRB(
                size(context, hor),
                size(context, vert),
                size(context, hor),
                0.0,
              ),
              child: Stack(
                children: [
                  ListView.separated(
                    itemCount: _listNewsFeed.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10.0);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      if (index == _listNewsFeed.length - 1) {
                        return Column(
                          children: [
                            NewsWidget(
                              listNewsFeed: _listNewsFeed,
                              index: index,
                            ),
                            SizedBox(height: 150.0),
                          ],
                        );
                      }
                      return NewsWidget(
                        listNewsFeed: _listNewsFeed,
                        index: index,
                      );
                    },
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 25.0,
                    child: CustomButton(
                      onTap: null,
                      buttonText: 'Экономь с нами 20%',
                      buttonColor: cPink,
                      buttonTextColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    Key key,
    @required this.listNewsFeed,
    @required this.index,
  }) : super(key: key);

  final List<Map<String, dynamic>> listNewsFeed;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'kotte.bar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    listNewsFeed[index]['date'],
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: _size.width * 0.85 - 2 * size(context, hor),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(listNewsFeed[index]['img']),
              ),
            ),
          ),
          Container(
            width: _size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                listNewsFeed[index]['news'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key key,
    @required TabController tabControllerReviews,
    @required List<Widget> listViewDataReviews,
  })  : _tabControllerReviews = tabControllerReviews,
        _listViewDataReviews = listViewDataReviews,
        super(key: key);

  final TabController _tabControllerReviews;
  final List<Widget> _listViewDataReviews;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: TabBar(
        isScrollable: true,
        controller: _tabControllerReviews,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.green),
        labelColor: Colors.white,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        unselectedLabelColor: Colors.black,
        tabs: _listViewDataReviews
            .map((e) => Container(
                  height: 25.0,
                  child: Tab(child: e),
                ))
            .toList(),
      ),
    );
  }
}

class CustomMenuListView extends StatelessWidget {
  const CustomMenuListView({
    Key key,
    @required this.menu,
  }) : super(key: key);

  final List<dynamic> menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (125.0 * menu.length) + (10.0 * (menu.length - 1)),
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Container(
                height: 125.0,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 75.0,
                          height: 75.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(menu[index]['img']),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Container(
                            height: 75.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //TODO верх картинки и текста должны быть одинаковыми
                                Text(
                                  menu[index]['name'],
                                  style: TextStyle(
                                    color: cIndigo,
                                    fontSize: 12.5,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    menu[index]['description'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150.0,
                          child: Row(
                            children: [
                              Text(
                                '${menu[index]['new_price']} р.',
                                style: TextStyle(
                                  color: cPink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                '${menu[index]['old_price']} р.',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          'Экономия ${menu[index]['old_price'] - menu[index]['new_price']} р.',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: 10.0,
              ),
          itemCount: menu.length),
    );
  }
}
