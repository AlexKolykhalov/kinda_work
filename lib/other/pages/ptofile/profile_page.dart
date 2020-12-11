import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/other/pages/ptofile/edit_profile/edit_profile_page.dart';
import 'package:kinda_work/other/pages/ptofile/edit_profile/fillout_profile.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
          title: 'Профиль',
          actions: [
            FlatButton(
              onPressed: () => null,
              minWidth: 13.0,
              child: Icon(Icons.exit_to_app, color: cPink),
            ),
            FlatButton(
              onPressed: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      EditProfilePage(),
                ),
              ),
              minWidth: 13.0,
              child: Icon(Icons.edit_outlined, color: cPink),
            ),
          ],
          tabController: _tabController,
          bottom: ['Общее', 'Где я был', 'Отзывы', 'Впечатления'],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            General(user: user1),
            WhereIWas(),
            ProfileReviews(),
            Impressions()
          ],
        ),
      ),
    );
  }
}

// TODO подумать как улучшить в плане динамической размерности
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
                              horizontal: constraints.maxWidth * cHorizont,
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
                            indent: constraints.maxWidth * cHorizont,
                            thickness: 1.0,
                          ),
                          Container(
                            height: _heightRow,
                            padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * cHorizont,
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
                            indent: constraints.maxWidth * cHorizont,
                            thickness: 1.0,
                          ),
                          Container(
                            height: _heightRow,
                            padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * cHorizont,
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
                            indent: constraints.maxWidth * cHorizont,
                            thickness: 1.0,
                          ),
                          Container(
                            height: _heightRow,
                            padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * cHorizont,
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
                                  horizontal: constraints.maxWidth * cHorizont,
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size(context, hor),
              vertical: size(context, vert),
            ),
            child: Text(
              'Вы посетили',
              style: style3(context).copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: _getPlacesColumnElements(whereIWas),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size(context, hor),
              vertical: size(context, vert),
            ),
            child: CustomButton(
              onTap: null,
              buttonText: 'Оставить отзыв +110 баллов',
              buttonColor: cPink,
              buttonTextColor: Colors.white,
            ),
          ),
          Divider(thickness: 1.0),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size(context, hor),
              vertical: size(context, vert),
            ),
            child: Text(
              'Использованные акции',
              style: style3(context).copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: _getPromotionsColumnElements(whereIWas),
          ),
          SizedBox(height: size(context, vert)),
        ],
      ),
    );
  }
}

List<Widget> _getPlacesColumnElements(Map elements) {
  return elements['places'].map<Widget>((place) {
    bool _isVisible =
        elements['places'].indexOf(place) < elements['places'].length - 1;
    return ColumnElementGeneral(
      img: place['company'].img,
      type: place['company'].type,
      name: place['company'].name,
      adress: place['company'].adress,
      visitTime: place['visit_time'],
      discountMoney: place['discount_money'],
      discountPoints: place['discount_points'],
      isVisible: _isVisible,
    );
  }).toList();
}

List<Widget> _getPromotionsColumnElements(Map elements) {
  return elements['promotions'].map<Widget>((promotion) {
    bool _isVisible = elements['promotions'].indexOf(promotion) <
        elements['promotions'].length - 1;
    return ColumnElementGeneral(
      img: promotion['promotion'].img,
      type: promotion['promotion'].type,
      name: promotion['promotion'].discription,
      adress: promotion['promotion'].adress,
      visitTime: promotion['visit_time'],
      isVisible: _isVisible,
    );
  }).toList();
}

class ProfileReviews extends StatelessWidget {
  const ProfileReviews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size(context, hor),
              vertical: size(context, vert),
            ),
            child: Text(
              'Отзывы о заведениях',
              style: style3(context).copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(children: _getPlacesReviews(reviews)),
          Divider(thickness: 1.0),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size(context, hor),
              vertical: size(context, vert),
            ),
            child: Text(
              'Отзывы об акциях',
              style: style3(context).copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_getPlacesReviews(List reviews) {
  List _placesReviews =
      reviews.where((element) => element.objectReview is Company).toList();

  return _placesReviews.map<Widget>((review) {
    bool _isVisible =
        _placesReviews.indexOf(review) < _placesReviews.length - 1;

    return ColumnElementProfileReviews(
      type: review.objectReview.type,
      name: review.objectReview is Company
          ? review.objectReview.name
          : review.objectReview.discription,
      text: review.text,
      service: review.service,
      kitchen: review.kitchen,
      priceQuality: review.priceQuality,
      ambiance: review.ambiance,
      isVisible: _isVisible,
    );
  }).toList();
}

_getPromotionsReviews(List reviews) {
  // _promotionsReviews =
  // return ColumnElementProfileReviews();
}

class Impressions extends StatelessWidget {
  const Impressions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ColumnElementGeneral extends StatelessWidget {
  const ColumnElementGeneral({
    Key key,
    @required this.img,
    @required this.type,
    @required this.name,
    @required this.adress,
    @required this.visitTime,
    @required this.isVisible,
    this.discountMoney,
    this.discountPoints,
  }) : super(key: key);

  final String img;
  final String type;
  final String name;
  final String adress;
  final String visitTime;
  final int discountMoney;
  final int discountPoints;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size(context, 0.065),
                height: size(context, 0.065),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(img),
                  ),
                ),
              ),
              SizedBox(width: size(context, 0.015)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: size(context, 0.008)),
                      child: Text(
                        type,
                        style:
                            style4(context).copyWith(color: Colors.grey[600]),
                      ),
                    ),
                    Text(
                      name,
                      style: style2(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: size(context, 0.008)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            adress,
                            style: style4(context),
                          ),
                          Text(
                            visitTime,
                            style: style4(context),
                          ),
                          Visibility(
                            visible:
                                discountMoney != null && discountPoints != null,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${discountMoney.toString()} р. ',
                                    style: style4(context).copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '(${discountPoints.toString()} баллов)',
                                    style: style4(context).copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: discountMoney != null && discountPoints != null,
                child: CustomRedRightArrow(onPressed: () => null),
              )
            ],
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Divider(
            indent: size(context, hor),
            thickness: 1.0,
          ),
        ),
      ],
    );
  }
}

class ColumnElementProfileReviews extends StatelessWidget {
  const ColumnElementProfileReviews({
    Key key,
    @required this.type,
    @required this.name,
    @required this.text,
    @required this.service,
    @required this.kitchen,
    @required this.priceQuality,
    @required this.ambiance,
    @required this.isVisible,
  }) : super(key: key);

  final String type;
  final String name;
  final String text;
  final int service;
  final int kitchen;
  final int priceQuality;
  final int ambiance;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    type,
                    style: style4(context).copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  TextBadge(
                    text: 'Модерация',
                    textColor: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.75),
                  ),
                ],
              ),
              Text(
                name,
                style: style1(context).copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size(context, 0.008)),
                child: Text(
                  '(посещение 20 сентября 2016)',
                  style: style4(context).copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Text(text, style: style2(context)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size(context, vert)),
                child: QualityRatingScale(
                  service: service,
                  kitchen: kitchen,
                  priceQualityRatio: priceQuality,
                  ambiance: ambiance,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Divider(
            indent: size(context, hor),
            thickness: 1.0,
          ),
        ),
      ],
    );
  }
}
