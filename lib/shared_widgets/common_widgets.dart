import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong/latlong.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:kinda_work/shared_widgets/camera/camera_page.dart';
import 'package:kinda_work/shared_widgets/map/map_page.dart';
import 'package:kinda_work/shared_widgets/badges.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/models.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.margin,
    @required this.onTap,
    @required this.text,
    @required this.color,
    @required this.textColor,
    this.borderColor = Colors.transparent,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  final EdgeInsets margin;
  final VoidCallback onTap;
  final String text;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: math.min(size(context, 0.075), 48.0),
        margin: margin,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: borderColor)),
        child: Center(
          child: Text(
            text,
            style: style2(context).copyWith(
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    Key key,
    @required this.icon,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      minWidth: size(context, 0.035),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: size(context, 0.035),
        child: icon,
      ),
    );
  }
}

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key key,
    this.padding,
    this.margin,
  }) : super(key: key);

  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    print('-->BottomButtons');
    final _h = size(context, 0.07);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: padding,
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () => displayQrCode(context),
            child: Container(
              width: _h,
              height: _h,
              padding: EdgeInsets.all(size(context, 0.02)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: cIndigo,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(1.0, 2.0),
                  ),
                ],
              ),
              child: svgQrCodeIcon,
            ),
          ),
          Container(
            width: size(context, 0.21),
            height: _h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  offset: Offset(1.0, 2.0),
                ),
              ],
            ),
            child: GestureDetector(
              //позволяет GestureDetector отрабатывать на все Row
              behavior: HitTestBehavior.opaque,
              onTap: () {
                final Widget _mapPage = MapPage();
                return Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        _mapPage,
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(size(context, 0.015)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 25.0,
                      height: 25.0,
                      child: svgLocationIcon,
                    ),
                    Text(
                      'На карте',
                      style: style1(context).copyWith(
                        color: cIndigo,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              final Widget _cameraPage = CameraPage();
              return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _cameraPage),
              );
            },
            child: Container(
              width: _h,
              height: _h,
              padding: EdgeInsets.all(size(context, 0.02)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: cIndigo,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(1.0, 2.0),
                  ),
                ],
              ),
              child: svgScanBarCodeIcon,
            ),
          )
        ],
      ),
    );
  }
}

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    Key key,
    this.tabs = const [],
    this.tabsStyle = const TabsStyle(
      indicator: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(20.0),
          right: Radius.circular(20.0),
        ),
        color: Colors.green,
      ),
      labelColor: Colors.white,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelColor: Colors.black,
    ),
    this.children = const [],
    this.paddingTabs,
    this.marginTabs,
    this.paddingChildren,
    this.marginChildren,
  })  : assert(tabs.length > 0, children.length > 0),
        assert(tabs.length == children.length),
        super(key: key);

  final List<Widget> tabs;
  final TabsStyle tabsStyle;
  final List<Widget> children;
  final EdgeInsets paddingTabs;
  final EdgeInsets marginTabs;
  final EdgeInsets paddingChildren;
  final EdgeInsets marginChildren;

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  int _index = 0;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('-->CustomTabBar');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: widget.paddingTabs,
          margin: widget.marginTabs,
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: widget.tabsStyle.isScrolling,
              indicator: widget.tabsStyle.indicator,
              indicatorWeight: 0.01,
              indicatorColor: widget.tabsStyle.indicatorColor,
              labelColor: widget.tabsStyle.labelColor,
              labelStyle: widget.tabsStyle.labelStyle,
              unselectedLabelStyle: widget.tabsStyle.unselectedLabelStyle,
              unselectedLabelColor: widget.tabsStyle.unselectedLabelColor,
              onTap: (value) {
                setState(() {
                  _index = value;
                });
              },
              tabs: widget.tabs
                  .map((e) => Container(
                        height: size(context, 0.05),
                        child: Tab(child: e),
                      ))
                  .toList(),
            ),
          ),
        ),
        Container(
          padding: widget.paddingChildren,
          margin: widget.marginChildren,
          child: IndexedStack(
            index: _index,
            children: widget.children,
          ),
        )
      ],
    );
  }
}

class CustomFilterSortBar extends StatelessWidget {
  const CustomFilterSortBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.sort,
              color: cPink,
              size: size(context, 0.025),
            ),
            SizedBox(width: size(context, 0.02)),
            Text('По умолчанию', style: style3(context)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size(context, 0.027),
              height: size(context, 0.027),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cIndigo,
              ),
              child: Center(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Text(
                      '10',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: constraints.maxHeight * 0.55,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: size(context, 0.01)),
            Text('Фильтр', style: style3(context)),
            SizedBox(width: size(context, 0.01)),
            SvgPicture.asset(
              'assets/svg/filter.svg',
              width: size(context, 0.022),
              height: size(context, 0.022),
            ),
          ],
        )
      ],
    );
  }
}

void displayQrCode(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      Size _size = MediaQuery.of(context).size;
      return Container(
        height: _size.height * 0.7,
        color: cGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: _size.width * 0.1,
              height: _size.height * 0.005,
              margin: EdgeInsets.only(top: _size.height * 0.02),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            Text('Покажите при оплате',
                style: TextStyle(fontSize: _size.height * 0.021)),
            QrImage(
              data: '014900',
              version: QrVersions.auto,
              padding: EdgeInsets.all(30.0),
              size: _size.height * 0.35,
              backgroundColor: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: _size.height * 0.1),
              child: Text('014 900',
                  style: TextStyle(fontSize: _size.height * 0.05)),
            ),
          ],
        ),
      );
    },
  );
}

void displayCardImages(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final MediaQueryData _mq = MediaQuery.of(context);
      final double _hor = _mq.size.height * hor;
      final double _vert = _mq.size.height * vert;
      return Container(
        height: _mq.size.height * 0.7,
        color: cGrey,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                Container(
                  width: constraints.maxWidth * 0.15,
                  height: constraints.maxHeight * 0.01,
                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.025),
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: _vert),
                      margin: EdgeInsets.only(left: _vert),
                      child: Text(
                        'Изображения',
                        style: style2(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final Widget _cameraPage = CameraPage(barcode: false);
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    _cameraPage,
                          ),
                        );
                      },
                      child: Container(
                        height: constraints.maxHeight * 0.8,
                        padding: EdgeInsets.only(left: _hor),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: _hor);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return index < 2
                                ? Column(
                                    children: [
                                      Container(
                                        height: constraints.maxHeight * 0.7,
                                        width: constraints.maxWidth * 0.6,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[600],
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Center(
                                          child: LayoutBuilder(
                                            builder: (BuildContext context,
                                                BoxConstraints
                                                    constraintsElement) {
                                              return Container(
                                                width: constraintsElement
                                                        .maxWidth *
                                                    0.75,
                                                height: constraintsElement
                                                        .maxHeight *
                                                    0.5,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: constraintsElement
                                                              .maxWidth *
                                                          0.35,
                                                      height: constraintsElement
                                                              .maxHeight *
                                                          0.3,
                                                      child: svgNoImage,
                                                    ),
                                                    Text(
                                                      'Лицевая сторона',
                                                      style: style2(context)
                                                          .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: index != 0,
                                        child: Container(
                                          height: constraints.maxHeight * 0.1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.delete_outlined,
                                                color: cPink,
                                              ),
                                              SizedBox(width: _vert),
                                              Icon(
                                                Icons.replay,
                                                color: cPink,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Container();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

void displayPhones(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      Size _size = MediaQuery.of(context).size;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: _size.width,
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    FlatButton(
                      onPressed: null,
                      child: Text(
                        'Позвонить',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Divider(thickness: 0.9),
                    FlatButton(
                        onPressed: null,
                        child: Text(
                          '+375 29 625 91 00',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        )),
                    Divider(thickness: 0.9),
                    FlatButton(
                        onPressed: null,
                        child: Text(
                          '+375 29 625 91 00',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        )),
                    Divider(thickness: 0.9),
                    FlatButton(
                        onPressed: null,
                        child: Text(
                          '+375 29 625 91 00',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              width: _size.width,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Отмена',
                  style: TextStyle(
                      color: cPink,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void displayRating(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      Size _size = MediaQuery.of(context).size;
      return Container(
        height: _size.height * 0.35,
        color: cGrey,
        child: Column(
          children: [
            Container(
              width: _size.width * 0.1,
              height: _size.height * 0.005,
              margin: EdgeInsets.only(top: _size.height * 0.02),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _size.height * 0.03),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Общая оценка',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          RateBadge(rate: 9.4, textColor: Colors.green),
                        ],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 20.0, height: 20.0, child: svgService),
                              SizedBox(width: 10.0),
                              Text('Обслуживание'),
                            ],
                          ),
                          RateBadge(rate: 9.8, textColor: Colors.green)
                        ]),
                    SizedBox(height: 10.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 20.0, height: 20.0, child: svgKitchen),
                              SizedBox(width: 10.0),
                              Text('Кухня'),
                            ],
                          ),
                          RateBadge(rate: 9.3, textColor: Colors.green)
                        ]),
                    SizedBox(height: 10.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 20.0,
                                  height: 20.0,
                                  child: svgPriceQuality),
                              SizedBox(width: 10.0),
                              Text('Цена/Качество'),
                            ],
                          ),
                          RateBadge(rate: 9.4, textColor: Colors.green)
                        ]),
                    SizedBox(height: 10.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 20.0,
                                  height: 20.0,
                                  child: svgAmbiance),
                              SizedBox(width: 10.0),
                              Text('Атмосфера'),
                            ],
                          ),
                          RateBadge(rate: 9.5, textColor: Colors.green)
                        ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class ManagerResponse extends StatelessWidget {
  const ManagerResponse({
    Key key,
    @required this.response,
  }) : super(key: key);

  final String response;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextBadge(
          text: 'Ответ',
          textColor: Colors.black,
          backgroundColor: Colors.orange[200],
        ),
        SizedBox(height: 5.0),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            response ?? '',
            style: style4(context).copyWith(fontStyle: FontStyle.italic),
          ),
        )
      ],
    );
  }
}

class QualityRatingScale extends StatelessWidget {
  const QualityRatingScale({
    Key key,
    this.service,
    this.kitchen,
    this.priceQualityRatio,
    this.ambiance,
  }) : super(key: key);

  final int service;
  final int kitchen;
  final int priceQualityRatio;
  final int ambiance;

  @override
  Widget build(BuildContext context) {
    int s = (service ?? 0) +
        (kitchen ?? 0) +
        (priceQualityRatio ?? 0) +
        (ambiance ?? 0);
    int k = (service == null ? 0 : 1) +
        (kitchen == null ? 0 : 1) +
        (priceQualityRatio == null ? 0 : 1) +
        (ambiance == null ? 0 : 1);
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size(context, 0.01),
            vertical: size(context, 0.006),
          ),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: RateBadge(
            rate: s / k,
            textColor: Colors.white,
          ),
        ),
        SizedBox(width: size(context, hor)),
        Container(
          height: size(context, 0.03),
          child: Row(
            children: [
              Visibility(
                visible: service != null,
                child: Row(
                  children: [
                    SizedBox(width: size(context, 0.03), child: svgService),
                    SizedBox(width: size(context, 0.003)),
                    RateBadge(rate: service, textColor: Colors.green),
                  ],
                ),
              ),
              Visibility(
                visible: kitchen != null,
                child: Row(
                  children: [
                    SizedBox(width: size(context, 0.01)),
                    SizedBox(width: size(context, 0.023), child: svgKitchen),
                    SizedBox(width: size(context, 0.003)),
                    RateBadge(rate: kitchen, textColor: Colors.green),
                  ],
                ),
              ),
              Visibility(
                visible: priceQualityRatio != null,
                child: Row(
                  children: [
                    SizedBox(width: size(context, 0.01)),
                    SizedBox(
                        width: size(context, 0.023), child: svgPriceQuality),
                    SizedBox(width: size(context, 0.003)),
                    RateBadge(rate: priceQualityRatio, textColor: Colors.green),
                  ],
                ),
              ),
              Visibility(
                visible: ambiance != null,
                child: Row(
                  children: [
                    SizedBox(width: size(context, 0.01)),
                    SizedBox(width: size(context, 0.023), child: svgAmbiance),
                    SizedBox(width: size(context, 0.003)),
                    RateBadge(rate: ambiance, textColor: Colors.green),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Marker buildCustomMarker({
  @required LatLng position,
}) {
  return Marker(
    width: 35.0,
    height: 35.0,
    point: position,
    builder: (ctx) => Container(
      width: 35.0,
      height: 35.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        ],
      ),
    ),
  );
}

Map<String, dynamic> getRank(int points) {
  if (points >= 0 && points <= 1000) {
    return {
      'status': 'Новичёк ($points баллов) до',
      'nextStatus': 'Юный герой (остался ${1001 - points} баллов)',
    };
  } else if (points >= 1001 && points <= 2000) {
    return {
      'status': 'Юный герой ($points баллов) до',
      'nextStatus': 'Бывалый (остался ${2001 - points} баллов)',
    };
  } else if (points >= 2001 && points <= 3000) {
    return {
      'status': 'Бывалый ($points баллов) до',
      'nextStatus': 'Знаток (остался ${3001 - points} баллов)',
    };
  } else if (points >= 3001 && points <= 4000) {
    return {
      'status': 'Знаток ($points баллов) до',
      'nextStatus': 'Эксперт (остался ${4001 - points} баллов)',
    };
  }
  return {
    'status': 'Эксперт ($points баллов)',
    'nextStatus': '',
  };
}
