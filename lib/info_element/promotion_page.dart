import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/widgets/store_promotions_slider.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/widgets.dart';

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
          actionIcon: Icon(Icons.favorite, color: cPink),
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
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSlider(images: imagesMainPage),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        constraints.maxWidth * cHorizont),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [],
                                      ),
                                    ),
                                    Text('Акция',
                                        style:
                                            TextStyle(color: Colors.grey[600])),
                                    Text(
                                        'Романтический ужин "В Баку" всего за 40 руб. Ассорти шашлык и овощи всего за 15 руб. В кафе Апшерон'),
                                    Row(
                                      children: [
                                        RateBadge(
                                            rate: 4.8, textColor: Colors.green),
                                        SizedBox(width: 10.0),
                                        MessagesBadge(countMessages: 12),
                                      ],
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
                                    Center(
                                      child: Text(
                                        'Сообщите, что звоните с Zabava',
                                        style: TextStyle(color: cPink),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              'Романтический ужин "В Баку" и ассорти шашлык и овощи от кафе "Апшерон" за пол цены!'),
                                        ),
                                        Icon(Icons.keyboard_arrow_down,
                                            color: cPink),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              color: Colors.grey[600],
                                            ),
                                            SizedBox(width: 5.0),
                                            Text(
                                              'Осталось 2 дня',
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '31',
                                              style: TextStyle(
                                                  color: Colors.grey[600]),
                                            ),
                                            SizedBox(width: 5.0),
                                            Icon(Icons.people_alt_outlined,
                                                color: Colors.grey[600])
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                        Positioned(
                          bottom: 0.0,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Описание акции',
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
                      Visibility(
                        visible: _isVisible,
                        child: Text(
                            '- Перед расчетом сообщи о наличии от Zabava.by, нажми кнопку "Предъявить скидку" на странице Акции ...'),
                      ),
                    ]),
                  ),
                  Divider(thickness: 1.0),
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
                                fontSize: 13.0,
                              ),
                            ),
                            Text(
                              'Все меню (120)',
                              style: TextStyle(
                                color: cPink,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            )
                          ],
                        ),
                        DropdownWidget(),
                        Text(
                            'Поставщик несет полную ответсвенность перед потребителем за достоверность информации')
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Positioned(
            //   left: constraints.maxWidth * cHorizont,
            //   right: constraints.maxWidth * cHorizont,
            //   bottom: 20.0,
            //   child: CustomButton(
            //     onTap: null,
            //     buttonText: 'Предъявите скидку -50%',
            //     buttonColor: cPink,
            //     buttonTextColor: Colors.white,
            //   ),
            // )
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
          child: Column(
            children: [
              Text(
                  'Окрашивание краской салона в один тон (мытье + сушка по форме)'),
              Row(
                children: [
                  Text('25 - 40 р.'),
                  SizedBox(width: 10.0),
                  Text('Без скидки 55 - 85 р.'),
                ],
              )
            ],
          ),
        ),
        Visibility(
          visible: _isVisible,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Короткие волосы (до 15 см)'),
              Row(
                children: [
                  Text('12 р.'),
                  SizedBox(width: 5.0),
                  Text('15 р.'),
                ],
              )
            ],
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
