import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/styles.dart';

class CompanyFeatures extends StatefulWidget {
  const CompanyFeatures({
    Key key,
  }) : super(key: key);

  @override
  _CompanyFeaturesState createState() => _CompanyFeaturesState();
}

class _CompanyFeaturesState extends State<CompanyFeatures> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    print('-->CompanyFeatures');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            //позволяет GestureDetector отрабатывать на все Row
            behavior: HitTestBehavior.opaque,
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
                  style: style3(context).copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _isVisible
                    ? CustomRedDownArrow(onPressed: null)
                    : CustomRedUpArrow(onPressed: null)
              ],
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: style2(context).copyWith(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: 'Курение: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'Запрещено'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: style2(context).copyWith(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: 'Кухня: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'Японская, Белорусская'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: style2(context).copyWith(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: 'Музыка: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'Тихая фоновая, DJ-сеты'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PromoFeatures extends StatefulWidget {
  const PromoFeatures({
    Key key,
  }) : super(key: key);

  @override
  _PromoFeaturesState createState() => _PromoFeaturesState();
}

class _PromoFeaturesState extends State<PromoFeatures> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cGrey,
      child: Column(
        children: [
          GestureDetector(
            //позволяет GestureDetector отрабатывать на все Row
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Описание акции',
                    style: style3(context).copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    )),
                _isVisible
                    ? CustomRedDownArrow(onPressed: null)
                    : CustomRedUpArrow(onPressed: null),
              ],
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Text(
              '- Перед расчетом сообщи о наличии от Zabava.by, нажми кнопку "Предъявить скидку" на странице Акции ...',
              style: style4(context),
            ),
          ),
        ],
      ),
    );
  }
}

class CallReviewButtons extends StatelessWidget {
  const CallReviewButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onTap: () => displayPhones(context),
            buttonText: 'Позвонить',
            buttonColor: Colors.green,
            buttonTextColor: Colors.white,
          ),
        ),
        SizedBox(width: size(context, hor)),
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
    );
  }
}

class MapPart extends StatelessWidget {
  const MapPart({
    Key key,
    @required this.position,
  }) : super(key: key);

  final LatLng position;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size(context, 0.45),
      child: FlutterMap(
        options: MapOptions(
          center: position,
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
                  position: position,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key key,
    @required this.menu,
  }) : super(key: key);

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size(context, 0.19),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: Colors.white),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double _height = constraints.maxHeight * 0.75;
          double _fontSize1 = constraints.maxHeight * 0.145;
          double _fontSize2 = constraints.maxHeight * 0.135;
          double _fontSize3 = constraints.maxHeight * 0.12;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: _height,
                child: Row(
                  children: [
                    Container(
                      width: _height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(menu.img),
                        ),
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.025),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //TODO верх картинки и текста должны быть одинаковыми
                          Text(
                            menu.name,
                            style: TextStyle(
                              color: cIndigo,
                              fontSize: _fontSize1,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              menu.description,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: _fontSize3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: menu.newPrice > 0.0,
                        child: Row(
                          children: [
                            Text(
                              '${menu.newPrice} р.',
                              style: TextStyle(
                                color: cPink,
                                fontSize: _fontSize2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: constraints.maxWidth * 0.025),
                          ],
                        ),
                      ),
                      Text(
                        '${menu.oldPrice} р.',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: _fontSize2,
                          fontWeight: FontWeight.bold,
                          decoration: menu.newPrice > 0.0
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      )
                    ],
                  ),
                  Visibility(
                    visible: menu.newPrice > 0.0 &&
                        menu.oldPrice - menu.newPrice > 0.0,
                    child: Text(
                      'Экономия ${menu.oldPrice - menu.newPrice} р.',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: _fontSize2,
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    Key key,
    @required this.review,
  }) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    double _offset = size(context, hor);
    double _height = size(context, 0.065);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  height: _height,
                  child: Row(
                    children: [
                      Container(
                        width: _height,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(review.author.avatar))),
                      ),
                      SizedBox(width: _offset),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: style4(context),
                              children: [
                                TextSpan(
                                    text: review.author.name,
                                    style: TextStyle(color: cPink)),
                                TextSpan(
                                    text:
                                        ' ${review.author.points.toStringAsFixed(0)}',
                                    style: TextStyle(color: Colors.grey[600]))
                              ],
                            ),
                          ),
                          Text(
                            review.date,
                            style: style4(context)
                                .copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: size(context, 0.01)),
                Row(
                  children: [
                    Container(
                      width: _height,
                      height: _height,
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                          size: size(context, 0.03),
                        ),
                      ),
                    ),
                    SizedBox(width: _offset),
                    Expanded(
                      child: Text(review.text, style: style4(context)),
                    ),
                  ],
                ),
                SizedBox(height: size(context, 0.01)),
                QualityRatingScale(
                  service: review.service,
                  kitchen: review.kitchen,
                  priceQualityRatio: review.priceQuality,
                  ambiance: review.ambiance,
                ),
                SizedBox(height: size(context, 0.025)),
                Visibility(
                  visible: review.managerResponse != null,
                  child: Container(
                    padding: EdgeInsets.only(left: _height + _offset),
                    child: ManagerResponse(response: review.managerResponse),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Icon(Icons.remove),
              Container(
                padding: EdgeInsets.symmetric(vertical: size(context, hor)),
                child: review.likes == 0
                    ? Text('0', style: style3(context))
                    : review.likes > 0
                        ? Text(
                            '+${review.likes.toString()}',
                            style:
                                style2(context).copyWith(color: Colors.green),
                          )
                        : Text(
                            '${review.likes.toString()}',
                            style: style2(context).copyWith(color: Colors.red),
                          ),
              ),
              Icon(Icons.add),
            ],
          ),
        ],
      ),
    );
  }
}

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    Key key,
    @required this.news,
  }) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    print('-->NewsWidget');
    return Container(
      height: size(context, 0.55),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(size(context, hor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  news.name,
                  style: style2(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  news.date,
                  style: style2(context).copyWith(
                    color: Colors.grey[600],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(news.img),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(size(context, hor)),
              child: Text(
                news.description,
                style: style2(context).copyWith(
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
    print('-->DropdownWidget');
    double _hor = size(context, hor);
    return Container(
      // TODO подумать над динамической высотой
      // когда сворачиваем, должна уменьшаться
      // высота контейнера
      height: size(context, 0.35),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.45,
                color: Colors.white,
                padding: EdgeInsets.all(_hor),
                child: Column(
                  children: [
                    Text(
                      'Окрашивание краской салона в один тон (мытье + сушка по форме)',
                      style: style2(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: Container()),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '25 - 40 р.',
                          style: style2(context).copyWith(
                            color: cPink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: _hor),
                        Text(
                          'Без скидки 55 - 85 р.',
                          style: style2(context),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Visibility(
                visible: _isVisible,
                child: Expanded(
                  child: Container(
                    color: Colors.orange[50],
                    padding: EdgeInsets.all(_hor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Короткие волосы (до 15 см)',
                          style: style3(context),
                        ),
                        Row(
                          children: [
                            Text(
                              '12 р.',
                              style: style3(context).copyWith(
                                color: cPink,
                              ),
                            ),
                            SizedBox(width: _hor),
                            Text(
                              '15 р.',
                              style: style3(context).copyWith(
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
        },
      ),
    );
  }
}

class CompanySchedule extends StatelessWidget {
  const CompanySchedule({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DailySchedule(schedule: 'Пн с 12:00 до 23.00'),
        DailySchedule(schedule: 'Пн с 12:00 до 23.00', active: true),
        DailySchedule(schedule: 'Пн с 12:00 до 23.00'),
        DailySchedule(schedule: 'Пн с 12:00 до 23.00'),
        DailySchedule(schedule: 'Пн с 12:00 до 23.00'),
        DailySchedule(schedule: 'Пн с 12:00 до 23.00'),
        DailySchedule(schedule: 'Пн с 12:00 до 19.00'),
      ],
    );
  }
}

class DailySchedule extends StatelessWidget {
  const DailySchedule({
    Key key,
    @required this.schedule,
    this.active = false,
  }) : super(key: key);

  final String schedule;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time_outlined,
          size: style1(context).fontSize,
          color: Colors.green,
        ),
        SizedBox(width: size(context, hor)),
        Text(
          schedule,
          style: style2(context).copyWith(
            color: active ? Colors.green : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
