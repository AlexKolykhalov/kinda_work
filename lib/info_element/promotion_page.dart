import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/pages/promotion/promotion_conditions.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({Key key}) : super(key: key);

  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage>
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
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Подробности акции',
          actions: [Icon(Icons.favorite, color: cPink)],
          bottom: ['Описание', 'Условия', 'Отзывы'],
          tabController: _tabController,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Description(),
            Conditions(),
            Reviews(),
          ],
        ),
      ),
    );
  }
}

class Description extends StatefulWidget {
  const Description({Key key}) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Column(children: [
                          CustomSlider(
                            images: sliderImages,
                            height: constraints.maxHeight * 0.35,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * cHorizont),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: constraints.maxHeight * 0.015),
                                  child: Text('Акция',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: constraints.maxHeight * 0.025,
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: constraints.maxHeight * 0.005),
                                  child: Text(
                                      'Романтический ужин "В Баку" всего за 40 руб. Ассорти шашлык и овощи всего за 15 руб. В кафе Апшерон',
                                      style: TextStyle(
                                          color: cIndigo,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              constraints.maxHeight * 0.0355)),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: constraints.maxHeight * 0.02),
                                  child: Row(
                                    children: [
                                      RateBadge(
                                          rate: 4.8, textColor: Colors.green),
                                      SizedBox(width: 10.0),
                                      MessagesBadge(countMessages: 12),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        onTap: () => displayPhones(context),
                                        buttonText: 'Позвонить',
                                        buttonColor: Colors.green,
                                        buttonTextColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                      child: CustomButton(
                                        onTap: null,
                                        buttonText: 'Оставить отзыв',
                                        buttonColor: Colors.white,
                                        buttonTextColor: Colors.black,
                                        buttonBorderColor: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: constraints.maxHeight * 0.01),
                                  child: Center(
                                    child: Text(
                                      'Сообщите, что звоните с Zabava',
                                      style: TextStyle(
                                        color: cPink,
                                        fontSize: constraints.maxHeight * 0.025,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                          'Романтический ужин "В Баку" и ассорти шашлык и овощи от кафе "Апшерон" за пол цены!',
                                          style: TextStyle(
                                              fontSize: constraints.maxHeight *
                                                  0.03)),
                                    ),
                                    Icon(Icons.keyboard_arrow_down,
                                        color: cPink),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: constraints.maxHeight * 0.015),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: constraints.maxHeight * 0.03,
                                            color: Colors.grey[600],
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            'Осталось 2 дня',
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.025),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '31',
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize:
                                                    constraints.maxHeight *
                                                        0.025),
                                          ),
                                          SizedBox(width: 5.0),
                                          Icon(Icons.people_alt_outlined,
                                              size:
                                                  constraints.maxHeight * 0.03,
                                              color: Colors.grey[600])
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        Positioned(
                          top: constraints.maxHeight * 0.35 - 15.0,
                          left: MediaQuery.of(context).size.width * cHorizont,
                          child: DiscountBadge(discount: 45),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: cGrey,
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * cHorizont),
                    child: Column(children: [
                      GestureDetector(
                        behavior: HitTestBehavior
                            .opaque, //позволяет GestureDetector отрабатывать на все Row
                        onTap: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: constraints.maxHeight * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Описание акции',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: constraints.maxHeight * 0.025,
                                ),
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
                        child: Text(
                            '- Перед расчетом сообщи о наличии от Zabava.by, нажми кнопку "Предъявить скидку" на странице Акции ...'),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.01),
                    child: Divider(thickness: 1.0),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * cHorizont),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Меню и цены',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxHeight * 0.025,
                              ),
                            ),
                            Text(
                              'Все меню (120)',
                              style: TextStyle(
                                color: cPink,
                                fontWeight: FontWeight.bold,
                                fontSize: constraints.maxHeight * 0.025,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: constraints.maxHeight * 0.01),
                          child: DropdownWidget(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: constraints.maxHeight * 0.01),
                          child: DropdownWidget(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: constraints.maxHeight * 0.01),
                          child: Text(
                              'Поставщик несет полную ответсвенность перед потребителем за достоверность информации'),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(seconds: 0),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      PromotionConditionsPage(
                                          size: constraints.biggest),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Условия акции',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: constraints.maxHeight * 0.025),
                              ),
                              Icon(Icons.keyboard_arrow_right, color: cPink),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.01),
                    child: Divider(thickness: 1.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * cHorizont,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Отзывы (23)',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: constraints.maxHeight * 0.025,
                          ),
                        ),
                        Text(
                          'Все отзывы (54)',
                          style: TextStyle(
                            color: cPink,
                            fontWeight: FontWeight.bold,
                            fontSize: constraints.maxHeight * 0.025,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.02),
                    child: Column(
                        children: getReviews(reviews, constraints.biggest)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.01),
                    child: Divider(thickness: 1.0),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * cHorizont,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Кафе',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: constraints.maxHeight * 0.025,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Апшерон',
                              style: TextStyle(
                                color: cPink,
                                fontSize: constraints.maxHeight * 0.035,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: cPink,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            RateBadge(
                              rate: 9.4,
                              textColor: Colors.green,
                            ),
                            SizedBox(width: 10.0),
                            MessagesBadge(countMessages: 26),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: 10.0),
                            Text('г. Минск, ул. Мазурова, 24'),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'Пн с 12:00 до 23.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'Вт с 12:00 до 23.00',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'Ср с 12:00 до 23.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'Чт с 12:00 до 23.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'Пт с 12:00 до 23.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'Сб с 12:00 до 23.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  'Вс с 12:00 до 19.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: constraints.maxHeight * cVertical),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Юридическая информация',
                                style: TextStyle(
                                  fontSize: constraints.maxHeight * 0.025,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: cPink,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: constraints.maxHeight * cVertical),
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * cHorizont),
                    child: CustomGridViewTitle(
                      title: 'Другие акции',
                      textTotalAmount: '',
                    ),
                  ),
                  Container(
                    height: cConstantWidth / cRatioMediumSize,
                    padding:
                        EdgeInsets.only(left: constraints.maxWidth * cHorizont),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container(
                        width: cConstantWidth,
                        child: CustomGridViewElement(
                            infoElement: InfoElement(
                          isLargeGridElement: false,
                          isDiscountVisible: true,
                          discount: 50,
                          oldPrice: 10500,
                          newPrice: 8500,
                          isFavoriteVisible: true,
                          countMessages: 25,
                          lightText: 'Массажный салон',
                          img: 'assets/png/grid/2.png',
                          rate: 9.5,
                        )),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 10.0),
                      itemCount: 1,
                    ),
                  ),
                  SizedBox(height: 100.0),
                ],
              ),
            ),
            Positioned(
              left: constraints.maxWidth * cHorizont,
              right: constraints.maxWidth * cHorizont,
              bottom: 40.0,
              child: CustomButton(
                onTap: () => displayQrCode(context),
                buttonText: 'Предъявите скидку -50%',
                buttonColor: cPink,
                buttonTextColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}

class Conditions extends StatelessWidget {
  const Conditions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Reviews extends StatelessWidget {
  const Reviews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({Key key}) : super(key: key);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                  'Окрашивание краской салона в один тон (мытье + сушка по форме)',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '25 - 40 р.',
                    style: TextStyle(
                      color: cPink,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Без скидки 55 - 85 р.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Visibility(
          visible: _isVisible,
          child: Container(
            color: Colors.orange[50],
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Короткие волосы (до 15 см)'),
                Row(
                  children: [
                    Text(
                      '12 р.',
                      style: TextStyle(
                        color: cPink,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      '15 р.',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          child: Container(
            color: Colors.orange[50],
            width: MediaQuery.of(context).size.width,
            child: Icon(
                _isVisible
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: cPink),
          ),
        ),
      ],
    );
  }
}
