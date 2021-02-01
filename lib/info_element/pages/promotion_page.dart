import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/info_element/info_element_widgets.dart';
import 'package:kinda_work/info_element/pages/promotion_conditions_page.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/badges.dart';
import 'package:kinda_work/shared_widgets/grid_view.dart';
import 'package:kinda_work/shared_widgets/list_view.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/shared_widgets/slider.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/repository.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({
    Key key,
    @required this.promotion,
  }) : super(key: key);

  final Promotion promotion;

  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  Widget _description;
  Widget _conditions;
  Widget _reviews;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _description = Description(promotion: widget.promotion);
    _conditions = Conditions();
    _reviews = Reviews();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('-->PromotionPage');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Подробности акции',
          actions: [
            CustomFlatButton(
              icon: widget.promotion.favorite
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
              'Условия',
              'Отзывы',
            ],
          ),
        ),
        body: IndexedStack(
          index: _index,
          children: [
            _description,
            _conditions,
            _reviews,
          ],
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.promotion,
  }) : super(key: key);

  final Promotion promotion;

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
              Container(
                height: size(context, 0.8),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            CustomSlider(
                              images: sliderImages,
                              height: constraints.maxHeight * 0.4,
                            ),
                            Container(
                              color: Colors.white,
                              height: constraints.maxHeight * 0.6,
                              padding: EdgeInsets.all(_hor),
                              child: LayoutBuilder(
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        promotion.type,
                                        style: style4(context).copyWith(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                constraints.maxHeight * 0.02),
                                        child: Text(
                                          promotion.description,
                                          style: style1(context).copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          RateBadge(
                                            rate: promotion.rate,
                                            textColor: Colors.green,
                                          ),
                                          SizedBox(width: _hor),
                                          MessagesBadge(
                                            countMessages: promotion.messages,
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      CallReviewButtons(),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.02,
                                      ),
                                      Center(
                                        child: Text(
                                          'Сообщите, что звоните с Zabava',
                                          style: style4(context)
                                              .copyWith(color: cPink),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Романтический ужин "В Баку" и ассорти шашлык и овощи от кафе "Апшерон" за пол цены!',
                                              style: style3(context),
                                            ),
                                          ),
                                          //странно, но так надо
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            color: cPink,
                                          ),
                                        ],
                                      ),
                                      Expanded(child: Container()),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                color: Colors.grey[600],
                                                size: style2(context).fontSize,
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * 0.02,
                                              ),
                                              Text(
                                                'Осталось 2 дня',
                                                style: style4(context).copyWith(
                                                  color: Colors.grey[600],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '31',
                                                style: style4(context).copyWith(
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * 0.02,
                                              ),
                                              Icon(
                                                Icons.people_alt_outlined,
                                                color: Colors.grey[600],
                                                size: style2(context).fontSize,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: constraints.maxHeight * 0.375,
                          left: _hor,
                          child: DiscountBadge(discount: promotion.discount),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                child: PromoFeatures(),
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
                          'Все меню (120)',
                          style: style2(context).copyWith(
                            color: cPink,
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: _vert),
                      child: Column(
                        children: [
                          // TODO два одинаковых widget
                          // с одинаковыми данными
                          // нужно сделать входные параметры
                          DropdownWidget(),
                          SizedBox(height: _vert),
                          DropdownWidget(),
                        ],
                      ),
                    ),
                    Text(
                      'Поставщик несет полную ответсвенность перед потребителем за достоверность информации',
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        final Widget _promotionConditionsPage =
                            PromotionConditionsPage();
                        return Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(seconds: 0),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    _promotionConditionsPage,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Условия акции', style: style2(context)),
                          CustomRedRightArrow(onPressed: null),
                        ],
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
                    Row(
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
                    Container(
                      padding: EdgeInsets.symmetric(vertical: _vert),
                      child: Column(
                        children: reviews
                            .where(
                              (element) =>
                                  element.objectReview == promotion.company,
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
                                                      promotion.company,
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
              Divider(thickness: 1.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      promotion.company.type,
                      style: style4(context).copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          promotion.company.name,
                          style: style1(context).copyWith(
                            color: cPink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomRedDownArrow(onPressed: null),
                      ],
                    ),
                    Row(
                      children: [
                        RateBadge(
                          rate: promotion.company.rate,
                          textColor: Colors.green,
                        ),
                        SizedBox(width: _hor),
                        MessagesBadge(
                            countMessages: promotion.company.messages),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: size(context, 0.015),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: style1(context).fontSize,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: _hor),
                          Text(
                            'г. Минск, ул. Мазурова, 24',
                            style: style2(context),
                          ),
                        ],
                      ),
                    ),
                    CompanySchedule(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Юридическая информация',
                          style: style2(context),
                        ),
                        CustomRedRightArrow(onPressed: null),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: _vert),
                child: MapPart(position: LatLng(53.912280, 27.541818)),
              ),
              CustomGridViewTitle(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                title: 'Другие акции',
                textTotalAmount: '',
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: _vert),
                margin: EdgeInsets.only(left: _hor),
                child: CustomHorizontalListViewPromos(
                  elements: popularPromotions,
                ),
              ),
              SizedBox(height: size(context, 0.085)),
            ],
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: _vert,
          child: CustomButton(
            margin: EdgeInsets.symmetric(horizontal: _hor),
            onTap: () => displayQrCode(context),
            text: 'Предъявите скидку -50%',
            color: cPink,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

class Conditions extends StatelessWidget {
  const Conditions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->Conditions');
    return Container();
  }
}

class Reviews extends StatelessWidget {
  const Reviews({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->Reviews');
    return Container();
  }
}
