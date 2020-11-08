import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/BLoC/bloc/search_result_bloc.dart';
import 'package:kinda_work/main/widgets/bottom_buttons.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/main/widgets/features_list.dart';
import 'package:kinda_work/main/widgets/store_promotions_slider.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _customGridViewPlaces;
  @override
  void initState() {
    super.initState();
    _customGridViewPlaces = CustomGridView(
      size: Size(414, 240),
      childAspectRatio: cRatioSmallSize,
      infoElements: popularPlaces,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    print('-->MainPage');
    // var _customGridViewPlaces = CustomGridView(
    //   size: _size,
    //   childAspectRatio: cRatioSmallSize,
    //   infoElements: popularPlaces,
    // );
    var _customGridViewPromo = CustomGridView(
      size: _size,
      childAspectRatio: cRatioMediumSize,
      infoElements: popularPromotions,
    );
    return SafeArea(
        child: BlocProvider(
      create: (context) => SearchResultBloc(),
      child: Scaffold(
        appBar: CustomAppBarWithSearch(size: _size),
        body: BlocBuilder<SearchResultBloc, SearchResultState>(
          builder: (context, state) {
            if (state is SearchResultLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is SearchResultLoadSuccess) {
              return SingleChildScrollView(
                child: Column(children: [
                  SearchResultPrices(
                    size: _size,
                    prices: state.result['prices'],
                  ),
                  Divider(thickness: 2.0),
                  SearchResultPromotions(
                    size: _size,
                    promotions: state.result['promotions'],
                  ),
                  Divider(thickness: 2.0),
                  SearchResultCompanies(
                    size: _size,
                    companies: state.result['companies'],
                  ),
                  Divider(thickness: 2.0),
                  SearchResultTypeOfCompanies(
                    size: _size,
                    typeCompanies: state.result['type_companies'],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _size.height * 0.02),
                    child: Divider(thickness: 2.0),
                  ),
                ]),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  StorePromotionSlider(size: _size),
                  FeaturesList(size: _size, currentIndex: 0),
                  //TODO do discription for this widget & widgets at all
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _size.width * cHorizont,
                    ),
                    child: Column(
                      children: [
                        CustomGridViewTitle(
                          size: _size,
                          title: 'Популярные места',
                          textTotalAmount: '5369 из 15600',
                        ),
                        _customGridViewPlaces,
                        // CustomGridView(
                        //   size: _size,
                        //   childAspectRatio: cRatioSmallSize,
                        //   infoElements: popularPlaces,
                        // ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            0.0,
                            _size.height * 0.03,
                            0.0,
                            _size.height * 0.06,
                          ),
                          child: CustomButton(
                            onTap: null,
                            buttonText: 'Смотреть все предложения',
                            buttonColor: cGrey,
                            buttonTextColor: cIndigo,
                            buttonBorderColor: cIndigo,
                          ),
                        ),
                        CustomGridViewTitle(
                          size: _size,
                          title: 'Популярные акции',
                          textTotalAmount: '5090',
                        ),
                        _customGridViewPromo,
                        // CustomGridView(
                        //   size: _size,
                        //   childAspectRatio: cRatioMediumSize,
                        //   infoElements: popularPromotions,
                        // ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            0.0,
                            _size.height * 0.03,
                            0.0,
                            _size.height * 0.06,
                          ),
                          child: CustomButton(
                            onTap: null,
                            buttonText: 'Смотреть все предложения',
                            buttonColor: cGrey,
                            buttonTextColor: cIndigo,
                            buttonBorderColor: cIndigo,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: _size.height * 0.04),
                          child: BottomButtons(size: _size),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavBar(size: _size, currentIndex: 0),
      ),
    ));
  }
}

class SearchResultPrices extends StatelessWidget {
  const SearchResultPrices({
    Key key,
    @required this.size,
    @required this.prices,
  }) : super(key: key);

  final Size size;
  final List<Price> prices;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customTitle('Menu/prices', size),
        Container(
          height: (size.height * (0.42 + 0.02)) * prices.length,
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: prices.length,
            itemBuilder: (context, index) => Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                    size.width * cHorizont,
                    0.0,
                    size.width * cHorizont,
                    size.width * cVertical,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prices[index].type,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      (prices[index].name.length < 24)
                                          ? prices[index].name
                                          : prices[index]
                                                  .name
                                                  .substring(0, 23) +
                                              '...',
                                      style: TextStyle(
                                        fontSize: size.height * 0.025,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  RateBadge(rate: 9.5, textColor: Colors.green),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.005),
                                child: Text(
                                  prices[index].adress,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: size.height * 0.022,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * 0.05),
                          child: DiscountBadge(discount: 50),
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.only(left: size.width * cHorizont),
                  height: size.height * 0.305,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: prices[index].menu.length,
                    itemBuilder: (context, indexMenu) => Column(
                      children: [
                        Container(
                          width: size.width * 0.5,
                          height: size.height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            image: DecorationImage(
                                image: AssetImage(
                                    prices[index].menu[indexMenu].img),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          width: size.width * 0.5,
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600],
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 2.0,
                                ),
                              ]),
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                            vertical: size.height * 0.015,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  prices[index].menu[indexMenu].name,
                                  style: TextStyle(
                                    fontSize: size.height * 0.025,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //TODO try to refactoring
                                Row(
                                  children: [
                                    Text(
                                      prices[index]
                                              .menu[indexMenu]
                                              .newPrice
                                              .toString() +
                                          ' р.',
                                      style: TextStyle(
                                        color: cPink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: size.height * 0.02,
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.02),
                                    Text(
                                      prices[index]
                                              .menu[indexMenu]
                                              .oldPrice
                                              .toString() +
                                          ' р.',
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey[600],
                                        fontSize: size.height * 0.02,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: size.width * 0.04,
                    ),
                  ),
                )
              ],
            ),
            separatorBuilder: (context, index) =>
                SizedBox(height: size.height * 0.02),
          ),
        ),
      ],
    );
  }
}

class SearchResultPromotions extends StatelessWidget {
  const SearchResultPromotions({
    Key key,
    @required this.size,
    @required this.promotions,
  }) : super(key: key);

  final Size size;
  final List<Promotion> promotions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customTitle('Promotions', size),
        Container(
          height: size.height * (0.16 + 0.02) * promotions.length,
          padding: EdgeInsets.symmetric(horizontal: size.width * cHorizont),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: promotions.length,
            itemBuilder: (context, index) => Container(
              height: size.height * 0.16,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.15,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(promotions[index].img),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: size.width * cHorizont),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(promotions[index].discription,
                                        style: TextStyle(
                                            fontSize: size.height * 0.022)),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RateBadge(
                                          rate: promotions[index].rate,
                                          textColor: Colors.green),
                                      Row(
                                        children: [
                                          Text(
                                            promotions[index]
                                                    .newPrice
                                                    .toString() +
                                                ' р.',
                                            style: TextStyle(
                                              color: cPink,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.height * 0.02,
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.02),
                                          Text(
                                            promotions[index]
                                                    .oldPrice
                                                    .toString() +
                                                ' р.',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.grey[600],
                                              fontSize: size.height * 0.02,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: size.width * (cHorizont + 0.02),
                    child: DiscountBadge(discount: promotions[index].discount),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => Divider(thickness: 2.0),
          ),
        ),
      ],
    );
  }
}

class SearchResultCompanies extends StatelessWidget {
  const SearchResultCompanies({
    Key key,
    @required this.size,
    @required this.companies,
  }) : super(key: key);

  final Size size;
  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customTitle('Companies', size),
        Container(
          height: (size.height * 0.1 + 16.0) * companies.length,
          padding: EdgeInsets.symmetric(horizontal: size.width * cHorizont),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: companies.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: size.height * 0.1,
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(companies[index].img),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  EdgeInsets.only(bottom: size.height * 0.01),
                              child:
                                  _customRichText(companies[index].name, size)),
                          Text(
                            companies[index].type,
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            companies[index].adress,
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RateBadge(
                          rate: companies[index].rate, textColor: Colors.green),
                      SizedBox(width: size.width * 0.05),
                      GestureDetector(
                        onTap: () => null,
                        child: Icon(
                          Icons.chevron_right,
                          color: cPink,
                        ),
                      )
                    ],
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Divider(thickness: 2.0),
          ),
        )
      ],
    );
  }
}

class SearchResultTypeOfCompanies extends StatelessWidget {
  const SearchResultTypeOfCompanies({
    Key key,
    @required this.size,
    @required this.typeCompanies,
  }) : super(key: key);

  final Size size;
  final List<String> typeCompanies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customTitle('Type of companies', size),
        Container(
          height: (size.height * 0.035 + 16.0) * typeCompanies.length,
          padding: EdgeInsets.symmetric(horizontal: size.width * cHorizont),
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: typeCompanies.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customRichText(typeCompanies[index], size),
                  GestureDetector(
                    onTap: () => null,
                    child: Icon(Icons.chevron_right,
                        color: cPink, size: size.height * 0.035),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Divider(thickness: 2.0),
          ),
        )
      ],
    );
  }
}

_customRichText(String text, Size size) {
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

_customTitle(String title, Size size) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: size.width * cHorizont,
      vertical: size.height * cVertical,
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.grey[600],
        fontWeight: FontWeight.bold,
        fontSize: size.height * 0.02,
      ),
    ),
  );
}
