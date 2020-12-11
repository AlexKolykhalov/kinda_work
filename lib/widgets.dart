import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinda_work/cards/cards_page.dart';
import 'package:kinda_work/other/other_page.dart';
import 'package:kinda_work/styles.dart';
import 'package:latlong/latlong.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:kinda_work/catalog/catalog_page.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/BLoC/bloc/search_result_bloc.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/promo/BLoC/horizontal_listview_switcher_cubit.dart';
import 'package:kinda_work/promo/promos_page.dart';
import 'package:kinda_work/promo/widgets/custom_bottom_appbar.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    @required this.onTap,
    @required this.buttonText,
    @required this.buttonColor,
    this.buttonBorderColor = Colors.transparent,
    @required this.buttonTextColor,
    this.isBoldButtonText = true,
  }) : super(key: key);

  final VoidCallback onTap;
  // final Widget onTap;
  final String buttonText;
  final Color buttonTextColor;
  final bool isBoldButtonText;
  final Color buttonColor;
  final Color buttonBorderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // TODO maybe only push
      onTap: onTap,
      child: Container(
        height: 48.0,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: buttonBorderColor)),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: buttonTextColor,
              fontWeight: (isBoldButtonText) ? FontWeight.bold : null,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key key,
    @required this.title,
    this.actions = const [],
    this.tabController,
    this.bottom = const [],
    this.isScrollable = false,
  }) : super(key: key);

  final String title;
  final List<Widget> actions;
  final TabController tabController;
  final List<String> bottom;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      leading: FlatButton(
        padding: EdgeInsets.all(13.0),
        onPressed: () => Navigator.pop(context),
        child: cLeftArrow,
      ),
      actions: actions,
      // [
      //   Visibility(
      //     visible: actionIcon != null,
      //     child: FlatButton(
      //       padding: EdgeInsets.all(14.0),
      //       onPressed: () => Navigator.pop(context),
      //       child: actionIcon ?? Container(),
      //     ),
      //   ),
      // ],
      bottom: (bottom.isNotEmpty)
          ? CustomBottomAppBar(
              preferredSize: preferredSize,
              tabController: tabController,
              bottomData: bottom,
              isScrollable: isScrollable,
            )
          : null,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => (bottom.isNotEmpty)
      ? Size.fromHeight(1.7 * AppBar().preferredSize.height)
      : Size.fromHeight(AppBar().preferredSize.height * 0.85);
}

class CustomAppBarWithSearch extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithSearch({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  _CustomAppBarWithSearchState createState() => _CustomAppBarWithSearchState();
}

class _CustomAppBarWithSearchState extends State<CustomAppBarWithSearch> {
  TextEditingController _textEditingController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()
      ..addListener(() {
        setState(() {
          if (_textEditingController.text.length > 0 && !_isVisible) {
            _isVisible = true;
          } else if (_textEditingController.text.length == 0) {
            _isVisible = false;
          }
        });
      });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        height: widget.size.height * 0.05,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  if (value.length > 3) {
                    BlocProvider.of<SearchResultBloc>(context).add(
                      SearchResultFetched(
                          searchText: _textEditingController.text),
                    );
                  }
                },
                style: TextStyle(fontWeight: FontWeight.bold),
                controller: _textEditingController,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: cSearchIcon,
                    ),
                    isCollapsed: true,
                    hintText: 'Поиск',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
            Visibility(
              visible: _isVisible,
              child: Container(
                width: widget.size.width * 0.2,
                child: GestureDetector(
                  onTap: () {
                    _textEditingController.clear();
                    BlocProvider.of<SearchResultBloc>(context).add(
                      SearchResultCleared(),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Отмена',
                      style: TextStyle(
                        color: cPink,
                        fontSize: widget.size.height * 0.025,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.size,
    @required this.currentIndex,
  }) : super(key: key);

  final Size size;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedFontSize: 12.5,
      unselectedFontSize: 12.5,
      selectedItemColor: cPink,
      unselectedItemColor: cIndigo,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          label: 'Главная',
          icon: (currentIndex == 0)
              ? IconButton(
                  icon: SvgPicture.asset(
                      'assets/svg/bottombar_icons/home_sel.svg'),
                  onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MainPage(),
                    ),
                  ),
                )
              : IconButton(
                  icon: SvgPicture.asset('assets/svg/bottombar_icons/home.svg'),
                  onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MainPage(),
                    ),
                  ),
                ),
        ),
        BottomNavigationBarItem(
          label: 'Каталог',
          icon: (currentIndex == 1)
              ? IconButton(
                  icon: SvgPicture.asset(
                      'assets/svg/bottombar_icons/catalog_sel.svg'),
                  onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CatalogPage(),
                    ),
                  ),
                )
              : IconButton(
                  icon: SvgPicture.asset(
                      'assets/svg/bottombar_icons/catalog.svg'),
                  onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CatalogPage(),
                    ),
                  ),
                ),
        ),
        BottomNavigationBarItem(
          label: 'Акции',
          icon: (currentIndex == 2)
              ? IconButton(
                  icon: SvgPicture.asset(
                      'assets/svg/bottombar_icons/gift_sel.svg'),
                  onPressed: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          PromotionsPage(),
                    ),
                  ),
                )
              : IconButton(
                  icon: SvgPicture.asset('assets/svg/bottombar_icons/gift.svg'),
                  onPressed: () => Navigator.push(
                    context,
                    // TODO why two same PageRouteBuilder ???
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          PromotionsPage(),
                    ),
                  ),
                ),
        ),
        BottomNavigationBarItem(
            label: 'Карты',
            icon: (currentIndex == 3)
                ? IconButton(
                    icon: SvgPicture.asset(
                        'assets/svg/bottombar_icons/cards_sel.svg'),
                    onPressed: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 0),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CardsPage(),
                      ),
                    ),
                  )
                : IconButton(
                    icon: SvgPicture.asset(
                        'assets/svg/bottombar_icons/cards.svg'),
                    onPressed: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 0),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CardsPage(),
                      ),
                    ),
                  )),
        BottomNavigationBarItem(
          label: 'Прочее',
          icon: Stack(
            children: [
              (currentIndex == 4)
                  ? IconButton(
                      icon: SvgPicture.asset(
                          'assets/svg/bottombar_icons/more_sel.svg'),
                      onPressed: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 0),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  OtherPage(),
                        ),
                      ),
                    )
                  : IconButton(
                      icon: SvgPicture.asset(
                          'assets/svg/bottombar_icons/more.svg'),
                      onPressed: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 0),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  OtherPage(),
                        ),
                      ),
                    ),
              Positioned(
                top: size.height * 0.015,
                right: 0.0,
                child: Container(
                  width: size.height * 0.015,
                  height: size.height * 0.015,
                  decoration: BoxDecoration(
                      color: cPink, borderRadius: BorderRadius.circular(50.0)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

// TODO make common for all TabBars
class CustomHorizontalListView extends StatelessWidget {
  const CustomHorizontalListView({
    Key key,
    @required this.size,
    @required this.listViewData,
    @required this.selectedElement,
  }) : super(key: key);

  final Size size;
  final List<String> listViewData;
  final int selectedElement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.05,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => BlocProvider.of<SwitcherHorigontalListViewCubit>(context)
              .changed(index),
          child: ListViewElement(
            size: size,
            title: listViewData[index],
            isSelected: selectedElement == index,
          ),
        ),
        itemCount: listViewData.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: size.width * 0.02),
      ),
    );
  }
}

class ListViewElement extends StatelessWidget {
  const ListViewElement({
    Key key,
    @required this.size,
    @required this.title,
    @required this.isSelected,
  }) : super(key: key);

  final Size size;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * cHorizont),
      decoration: BoxDecoration(
        color: (isSelected) ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: (isSelected) ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

class CustomRedRightArrow extends StatelessWidget {
  const CustomRedRightArrow({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: onPressed,
      icon: Align(
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.keyboard_arrow_right,
          color: cPink,
          size: size(context, 0.035),
        ),
      ),
    );
  }
}

// TODO refactoring
class RateBadge extends StatelessWidget {
  const RateBadge({
    Key key,
    @required this.rate,
    @required this.textColor,
  }) : super(key: key);

  final num rate;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    //print('-->RateBadge');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: rate == 0.0 ? Colors.grey[600] : textColor,
          size: cConstantWidth * 0.1,
        ),
        SizedBox(width: cConstantWidth * 0.01),
        (rate == 0.0)
            ? Container(
                width: cConstantWidth * 0.45,
                child: Text(
                  'Нет оценок',
                  style: TextStyle(fontSize: cConstantWidth * scaleLightText),
                ),
              )
            : Text(
                rate.toStringAsFixed(rate.truncateToDouble() == rate ? 0 : 1),
                style: TextStyle(
                  fontSize: cConstantWidth * scaleLightText,
                  color: textColor,
                ),
              ),
      ],
    );
  }
}

class MessagesBadge extends StatelessWidget {
  const MessagesBadge({
    Key key,
    @required this.countMessages,
  }) : super(key: key);

  final int countMessages;

  @override
  Widget build(BuildContext context) {
    //print('-->MessagesBadge');
    return Visibility(
      visible: countMessages > 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(countMessages.toString(),
              style: TextStyle(
                fontSize: cConstantWidth * scaleLightText,
                color: Colors.grey[600],
              )),
          SizedBox(width: cConstantWidth * 0.02),
          SvgPicture.asset(
            'assets/svg/chat.svg',
            width: cConstantWidth * scaleLightText,
            height: cConstantWidth * scaleLightText,
          )
        ],
      ),
    );
  }
}

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({Key key, @required this.discount}) : super(key: key);

  final int discount;

  @override
  Widget build(BuildContext context) {
    //print('-->DiscountBadge');
    return Container(
      width: cConstantWidth * 0.3,
      height: cConstantWidth * 0.15,
      decoration: BoxDecoration(
        color: cPink,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Text(
          '-${discount.toString()}%',
          style: TextStyle(
            color: Colors.white,
            fontSize: cConstantWidth * scaleBoltText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CustomFilterSortBar extends StatelessWidget {
  const CustomFilterSortBar({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    Orientation _currentOrientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: _currentOrientation == Orientation.portrait
                ? size.width * 0.325
                : size.height * 0.325,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.sort,
                  color: cPink,
                  size: _currentOrientation == Orientation.portrait
                      ? size.height * 0.025
                      : size.width * 0.025,
                ),
                Text(
                  'По умолчанию',
                  style: TextStyle(
                      fontSize: _currentOrientation == Orientation.portrait
                          ? size.height * 0.02
                          : size.width * 0.02),
                ),
              ],
            ),
          ),
          Container(
            width: _currentOrientation == Orientation.portrait
                ? size.width * 0.25
                : size.height * 0.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cIndigo,
                  ),
                  child: Center(
                      child: Text(
                    '10',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
                Text(
                  'Фильтр',
                  style: TextStyle(
                      fontSize: _currentOrientation == Orientation.portrait
                          ? size.height * 0.02
                          : size.width * 0.02),
                ),
                SvgPicture.asset(
                  'assets/svg/filter.svg',
                  width: _currentOrientation == Orientation.portrait
                      ? size.height * 0.025
                      : size.width * 0.025,
                  height: _currentOrientation == Orientation.portrait
                      ? size.height * 0.025
                      : size.width * 0.025,
                ),
              ],
            ),
          )
        ],
      ),
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
                                  width: 20.0, height: 20.0, child: cService),
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
                                  width: 20.0, height: 20.0, child: cKitchen),
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
                                  child: cPriceQuality),
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
                                  width: 20.0, height: 20.0, child: cAmbiance),
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

// TODO do something with size
List<Widget> getReviews(List<Review> reviews, Size size) {
  List<Widget> _widgets = [];
  for (var review in reviews) {
    Widget _widget = createReviewWidget(review, size);
    _widgets.add(_widget);
    // TODO нужно сделать различной длины Divider
    _widgets.add(Divider(
      height: 30.0,
      thickness: 1.0,
      indent: size.width * cHorizont,
    ));
  }
  return _widgets;
}

// TODO do something with size
createReviewWidget(Review review, Size _size) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: _size.width * cHorizont),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                height: _size.width * 0.12,
                child: Row(
                  children: [
                    Container(
                      width: _size.width * 0.12,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(review.author.avatar))),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: review.author.name,
                                style: TextStyle(color: cPink)),
                            TextSpan(
                                text:
                                    ' ${review.author.points.toStringAsFixed(0)}',
                                style: TextStyle(color: Colors.grey[600]))
                          ]),
                        ),
                        Text(
                          review.date,
                          style: TextStyle(color: Colors.grey[600]),
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
                    width: _size.width * 0.12,
                    height: _size.width * 0.12,
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(review.text),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              QualityRatingScale(
                service: review.service,
                kitchen: review.kitchen,
                priceQualityRatio: review.priceQuality,
                ambiance: review.ambiance,
              ),
              const SizedBox(height: 15.0),
              Visibility(
                visible: review.response != null,
                child: Container(
                    padding: EdgeInsets.only(left: _size.width * 0.12 + 10.0),
                    child: ManagerResponse(response: review.response ?? '')),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Icon(Icons.remove),
            ),
            review.likes == 0
                ? Text('0')
                : review.likes > 0
                    ? Text(
                        '+${review.likes.toString()}',
                        style: TextStyle(color: Colors.green),
                      )
                    : Text(
                        '${review.likes.toString()}',
                        style: TextStyle(color: Colors.red),
                      ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Icon(Icons.add),
            ),
          ],
        ),
      ],
    ),
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
            response,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        )
      ],
    );
  }
}

class TextBadge extends StatelessWidget {
  const TextBadge({
    Key key,
    @required this.text,
    @required this.textColor,
    @required this.backgroundColor,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(size(context, 0.0065)),
        child: Text(
          text,
          style: style4(context)
              .copyWith(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
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
    Size _size = MediaQuery.of(context).size;
    int s = (service ?? 0) +
        (kitchen ?? 0) +
        (priceQualityRatio ?? 0) +
        (ambiance ?? 0);
    int k = (service == null ? 0 : 1) +
        (kitchen == null ? 0 : 1) +
        (priceQualityRatio == null ? 0 : 1) +
        (ambiance == null ? 0 : 1);
    return Container(
      child: Row(
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
          SizedBox(width: 10.0),
          Container(
            height: size(context, 0.03),
            child: Row(
              children: [
                Visibility(
                  visible: service != null,
                  child: Row(
                    children: [
                      SizedBox(width: size(context, 0.03), child: cService),
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
                      SizedBox(width: size(context, 0.023), child: cKitchen),
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
                          width: size(context, 0.023), child: cPriceQuality),
                      SizedBox(width: size(context, 0.003)),
                      RateBadge(
                          rate: priceQualityRatio, textColor: Colors.green),
                    ],
                  ),
                ),
                Visibility(
                  visible: ambiance != null,
                  child: Row(
                    children: [
                      SizedBox(width: size(context, 0.01)),
                      SizedBox(width: size(context, 0.023), child: cAmbiance),
                      SizedBox(width: size(context, 0.003)),
                      RateBadge(rate: ambiance, textColor: Colors.green),
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
