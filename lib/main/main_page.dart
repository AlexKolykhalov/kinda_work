import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/BLoC/transition_bloc.dart';
import 'package:kinda_work/cards/cards_page.dart';
import 'package:kinda_work/catalog/catalog_page.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/BLoC/search_result_bloc.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/badges.dart';
import 'package:kinda_work/shared_widgets/grid_view.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/other/other_page.dart';
import 'package:kinda_work/promo/promos_page.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/list_view.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/shared_widgets/slider.dart';
import 'package:kinda_work/styles.dart';

double bottomAppHeight = 0.0;

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final Widget _mainPage = MainPage();
  final Widget _catalogPage = CatalogPage();
  final Widget _promotionsPage = PromotionsPage();
  final Widget _cardsPage = CardsPage();
  final Widget _otherPage = OtherPage();
  final _keyBottomAppBar = GlobalKey();
  int _currentIndex = 0;
  double _svgImageSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => bottomAppHeight = _keyBottomAppBar.currentContext.size.height,
    );
  }

  @override
  void didChangeDependencies() {
    _svgImageSize = size(context, 0.04);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('***StartPage***');
    return SafeArea(
      top: false,
      child: Scaffold(
        body: BlocProvider(
          create: (context) => TransitionBloc(),
          child: IndexedStack(
            index: _currentIndex,
            children: [
              _mainPage,
              _catalogPage,
              _promotionsPage,
              _cardsPage,
              _otherPage,
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          key: _keyBottomAppBar,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedFontSize: style4(context).fontSize,
          unselectedFontSize: style4(context).fontSize,
          selectedItemColor: cPink,
          unselectedItemColor: cIndigo,
          showUnselectedLabels: true,
          onTap: (int index) {
            setState(() {
              if (index == 0) {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => _mainPage,
                //   ),
                //   (route) => false,
                // );
                // Navigator.removeRouteBelow(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => _mainPage,
                //   ),
                // );
              }
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Главная',
              icon: Container(
                width: _svgImageSize,
                height: _svgImageSize,
                padding: EdgeInsets.zero,
                child: _currentIndex == 0
                    ? SvgPicture.asset(
                        'assets/svg/bottombar_icons/home_sel.svg')
                    : SvgPicture.asset('assets/svg/bottombar_icons/home.svg'),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Каталог',
              icon: Container(
                width: _svgImageSize,
                height: _svgImageSize,
                padding: EdgeInsets.zero,
                child: _currentIndex == 1
                    ? SvgPicture.asset(
                        'assets/svg/bottombar_icons/catalog_sel.svg')
                    : SvgPicture.asset(
                        'assets/svg/bottombar_icons/catalog.svg'),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Акции',
              icon: Container(
                width: _svgImageSize,
                height: _svgImageSize,
                padding: EdgeInsets.zero,
                child: _currentIndex == 2
                    ? SvgPicture.asset(
                        'assets/svg/bottombar_icons/gift_sel.svg')
                    : SvgPicture.asset('assets/svg/bottombar_icons/gift.svg'),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Карты',
              icon: Container(
                width: _svgImageSize,
                height: _svgImageSize,
                padding: EdgeInsets.zero,
                child: _currentIndex == 3
                    ? SvgPicture.asset(
                        'assets/svg/bottombar_icons/cards_sel.svg')
                    : SvgPicture.asset('assets/svg/bottombar_icons/cards.svg'),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Прочее',
              activeIcon: Container(
                width: _svgImageSize,
                height: _svgImageSize,
                padding: EdgeInsets.zero,
                child:
                    SvgPicture.asset('assets/svg/bottombar_icons/more_sel.svg'),
              ),
              icon: Container(
                width: double.infinity,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: _svgImageSize,
                          height: _svgImageSize,
                          padding: EdgeInsets.zero,
                          child: SvgPicture.asset(
                              'assets/svg/bottombar_icons/more.svg'),
                        ),
                        Positioned(
                          top: constraints.maxWidth * 0.1,
                          right: constraints.maxWidth * 0.23,
                          child: Container(
                            width: size(context, 0.01),
                            height: size(context, 0.01),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: cPink,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('***MainPage***');
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return BlocProvider(
              create: (context) => SearchResultBloc(),
              child: Scaffold(
                appBar: CustomAppBarWithSearch(
                  height: appBarHeight(context),
                ),
                body: BlocBuilder<SearchResultBloc, SearchResultState>(
                  builder: (context, state) {
                    if (state is SearchResultLoadInProgress) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is SearchResultLoadSuccess) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SearchResultPrices(
                              companies: state.result['companies'],
                            ),
                            Divider(thickness: 1.0),
                            SearchResultPromotions(
                              promotions: state.result['promotions'],
                            ),
                            Divider(thickness: 1.0),
                            SearchResultCompanies(
                              companies: state.result['companies'],
                            ),
                            Divider(thickness: 1.0),
                            SearchResultTypeOfCompanies(
                              typeCompanies: state.result['type_companies'],
                            ),
                            Divider(thickness: 1.0),
                          ],
                        ),
                      );
                    }
                    return Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(_hor),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: CustomSlider(images: sliderImages)),
                              ),
                              Sections(
                                padding: EdgeInsets.only(left: _hor),
                                elements: sectionElements,
                              ),
                              //TODO do description for this widget & widgets at all
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: _hor),
                                child: Column(
                                  children: [
                                    CustomGridViewTitle(
                                      padding: EdgeInsets.only(top: _vert),
                                      title: 'Популярные места',
                                      textTotalAmount: '5369 из 15600',
                                    ),
                                    CustomGridView(
                                      padding:
                                          EdgeInsets.symmetric(vertical: _vert),
                                      elements: popularCompanies,
                                      mainAxisSpacing: _hor,
                                      crossAxisSpacing: _hor,
                                    ),
                                    CustomButton(
                                      onTap: null,
                                      text: 'Смотреть все предложения',
                                      color: cGrey,
                                      textColor: cIndigo,
                                      borderColor: cIndigo,
                                    ),
                                    CustomGridViewTitle(
                                      padding: EdgeInsets.only(top: _vert),
                                      title: 'Популярные акции',
                                      textTotalAmount: '5090',
                                    ),
                                    CustomGridView(
                                      padding:
                                          EdgeInsets.symmetric(vertical: _vert),
                                      elements: popularPromotions,
                                      mainAxisSpacing: _hor,
                                      crossAxisSpacing: _hor,
                                    ),
                                    CustomButton(
                                      margin: EdgeInsets.only(bottom: _vert),
                                      onTap: null,
                                      text: 'Смотреть все предложения',
                                      color: cGrey,
                                      textColor: cIndigo,
                                      borderColor: cIndigo,
                                    ),
                                    SizedBox(height: size(context, 0.085)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: _vert,
                          child: BottomButtons(
                            padding: EdgeInsets.symmetric(horizontal: _hor),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SearchResultPrices extends StatelessWidget {
  const SearchResultPrices({
    Key key,
    @required this.companies,
  }) : super(key: key);

  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size(context, hor),
            vertical: size(context, vert),
          ),
          child: Text(
            'Меню/прайс',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: companies
              .map((company) => CompanyWithMenu(company: company))
              .toList(),
        )
      ],
    );
  }
}

class CompanyWithMenu extends StatelessWidget {
  const CompanyWithMenu({
    Key key,
    @required this.company,
  }) : super(key: key);

  final Company company;

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: CompanyPart(
            type: company.type,
            name: company.name,
            adress: company.adress,
            rate: company.rate,
            discount: company.discount,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: _hor),
          margin: EdgeInsets.only(left: _hor),
          child: MenuPart(menu: company.menu),
        ),
      ],
    );
  }
}

class CompanyPart extends StatelessWidget {
  const CompanyPart({
    Key key,
    @required this.type,
    @required this.name,
    @required this.adress,
    @required this.rate,
    @required this.discount,
  }) : super(key: key);

  final String type;
  final String name;
  final String adress;
  final double rate;
  final int discount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: style4(context).copyWith(color: Colors.grey[600]),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints:
                          BoxConstraints(maxWidth: constraints.maxWidth * 0.5),
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 2,
                        style: style2(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: size(context, hor)),
                    RateBadge(rate: rate, textColor: Colors.green)
                  ],
                ),
                SizedBox(height: size(context, 0.007)),
                Text(
                  adress,
                  style: style4(context).copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            DiscountBadge(discount: discount),
          ],
        );
      },
    );
  }
}

class MenuPart extends StatelessWidget {
  const MenuPart({
    Key key,
    @required this.menu,
  }) : super(key: key);

  final List<Menu> menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size(context, 0.21),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => MenuElement(element: menu[index]),
        separatorBuilder: (context, index) => SizedBox(
          width: size(context, hor),
        ),
        itemCount: menu.length,
      ),
    );
  }
}

class MenuElement extends StatelessWidget {
  const MenuElement({
    Key key,
    @required this.element,
  }) : super(key: key);

  final Menu element;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            width: size(context, 0.23),
            child: Column(children: [
              Container(
                height: constraints.maxHeight * 0.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(element.img),
                  ),
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.4,
                child: LayoutBuilder(
                  builder: (BuildContext context,
                      BoxConstraints constraintsContainer) {
                    return Container(
                      width: constraintsContainer.maxWidth,
                      padding:
                          EdgeInsets.all(constraintsContainer.maxHeight * 0.15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: LayoutBuilder(
                        builder: (BuildContext context,
                            BoxConstraints constraintsPadding) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                element.name,
                                style: TextStyle(
                                  fontSize: constraintsPadding.maxHeight * 0.35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Visibility(
                                    visible: element.newPrice != 0.0,
                                    child: Row(
                                      children: [
                                        Text(
                                          '${element.newPrice.toString()} p.',
                                          style: TextStyle(
                                            color: cPink,
                                            fontSize:
                                                constraintsPadding.maxHeight *
                                                    0.35,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              constraintsPadding.maxWidth * 0.1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${element.oldPrice.toString()} p.',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      decoration: element.newPrice == 0.0
                                          ? TextDecoration.none
                                          : TextDecoration.lineThrough,
                                      fontSize:
                                          constraintsPadding.maxHeight * 0.35,
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

class SearchResultPromotions extends StatelessWidget {
  const SearchResultPromotions({
    Key key,
    @required this.promotions,
  }) : super(key: key);

  final List<Promotion> promotions;

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: _hor,
            vertical: _vert,
          ),
          child: Text(
            'Акции',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: size(context, 0.018)),
          child: Column(
            children: promotions
                .asMap()
                .entries
                .map((entry) => Column(
                      children: [
                        SearchPromotions(element: entry.value),
                        Visibility(
                          visible: entry.key != promotions.length - 1,
                          child: Divider(
                              height: size(context, 0.035),
                              indent: _hor,
                              thickness: 1.0),
                        )
                      ],
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class SearchPromotions extends StatelessWidget {
  const SearchPromotions({
    Key key,
    @required this.element,
  }) : super(key: key);

  final Promotion element;

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    return Container(
      height: size(context, 0.13),
      padding: EdgeInsets.symmetric(horizontal: _hor),
      child: Stack(
        children: [
          Container(
            height: size(context, 0.12),
            child: Row(
              children: [
                Container(
                  width: size(context, 0.12),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(element.img),
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                SizedBox(width: _hor),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        element.description,
                        style: style3(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RateBadge(
                              rate: element.rate, textColor: Colors.green),
                          Row(
                            children: [
                              Text(
                                '${element.newPrice} р.',
                                style: style3(context).copyWith(color: cPink),
                              ),
                              SizedBox(width: size(context, 0.01)),
                              Text(
                                '${element.oldPrice} р.',
                                style: style3(context).copyWith(
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.lineThrough,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 8.0,
            child: DiscountBadge(discount: element.discount),
          )
        ],
      ),
    );
  }
}

class SearchResultCompanies extends StatelessWidget {
  const SearchResultCompanies({
    Key key,
    @required this.companies,
  }) : super(key: key);

  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: _hor,
            vertical: _vert,
          ),
          child: Text(
            'Компании',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
            children: companies
                .asMap()
                .entries
                .map(
                  (entry) => Column(
                    children: [
                      SearchCompany(element: entry.value),
                      Visibility(
                        visible: entry.key != companies.length - 1,
                        child: Divider(
                            height: size(context, 0.035),
                            indent: _hor,
                            thickness: 1.0),
                      )
                    ],
                  ),
                )
                .toList()),
      ],
    );
  }
}

class SearchCompany extends StatelessWidget {
  const SearchCompany({
    Key key,
    @required this.element,
  }) : super(key: key);

  final Company element;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                constraints:
                    BoxConstraints(maxWidth: constraints.maxWidth * 0.8),
                child: Row(
                  children: [
                    Container(
                      width: size(context, 0.06),
                      height: size(context, 0.06),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(element.img),
                        ),
                      ),
                    ),
                    SizedBox(width: size(context, 0.02)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            element.name,
                            overflow: TextOverflow.ellipsis,
                            style: style2(context),
                          ),
                          SizedBox(height: size(context, 0.006)),
                          Text(
                            element.type,
                            style: style4(context).copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            element.adress,
                            style: style4(context).copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  RateBadge(rate: 8.0, textColor: Colors.green),
                  CustomRedRightArrow(onPressed: null),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class SearchResultTypeOfCompanies extends StatelessWidget {
  const SearchResultTypeOfCompanies({
    Key key,
    @required this.typeCompanies,
  }) : super(key: key);

  final List<String> typeCompanies;

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: _hor,
            vertical: _vert,
          ),
          child: Text(
            'Тип заведения',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: typeCompanies
              .asMap()
              .entries
              .map(
                (entry) => Column(
                  children: [
                    SearchTypeCompany(element: entry.value),
                    Visibility(
                      visible: entry.key != typeCompanies.length - 1,
                      child: Divider(
                          // height: size(context, 0.035),
                          indent: _hor,
                          thickness: 1.0),
                    ),
                  ],
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

class SearchTypeCompany extends StatelessWidget {
  const SearchTypeCompany({
    Key key,
    @required this.element,
  }) : super(key: key);

  final String element;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          element,
          style: style2(context),
        ),
        CustomRedRightArrow(onPressed: null),
      ]),
    );
  }
}

customRichText(String text, Size size) {
  Map<String, String> result = {
    'normalText1': '',
    'boldText': '',
    'normalText2': '',
  };

  int startBold = text.indexOf('&');
  int endBold = text.lastIndexOf('&');

  result['normalText1'] = text.substring(0, startBold);
  result['boldText'] = text.substring(startBold + 1, endBold);
  result['normalText2'] = text.substring(endBold + 1, text.length);

  Widget widgetRichText = Text.rich(
    TextSpan(
      children: [
        TextSpan(text: result['normalText1']),
        TextSpan(
          text: result['boldText'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(text: result['normalText2']),
      ],
    ),
    style: TextStyle(
      fontSize: size.height * 0.025,
    ),
  );

  return widgetRichText;
}
