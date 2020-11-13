import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/catalog/catalog_page.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/BLoC/bloc/search_result_bloc.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/promo/BLoC/horizontal_listview_switcher_cubit.dart';
import 'package:kinda_work/promo/promos_page.dart';
import 'package:kinda_work/promo/widgets/custom_bottom_appbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
      // TODO maybe onle push
      onTap: () => onTap(),
      // onTap: () => Navigator.pushReplacement(
      //   context,
      //   PageRouteBuilder(
      //     transitionDuration: Duration(seconds: 0),
      //     pageBuilder: (context, animation, secondaryAnimation) => onTap,
      //   ),
      // ),
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
    this.actionIcon,
    this.tabController,
    this.bottom = const [],
  }) : super(key: key);

  final String title;
  final Widget actionIcon;
  final TabController tabController;
  final List<String> bottom;

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
      actions: [
        Visibility(
          visible: actionIcon != null,
          child: FlatButton(
            padding: EdgeInsets.all(14.0),
            onPressed: () => Navigator.pop(context),
            child: actionIcon ?? Container(),
          ),
        ),
      ],
      bottom: (bottom.isNotEmpty)
          ? CustomBottomAppBar(
              preferredSize: preferredSize,
              tabController: tabController,
              bottomData: bottom,
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
                    onPressed: () => null,
                  )
                : IconButton(
                    icon: SvgPicture.asset(
                        'assets/svg/bottombar_icons/cards.svg'),
                    onPressed: () => null,
                  )),
        BottomNavigationBarItem(
          label: 'Прочее',
          icon: Stack(
            children: [
              (currentIndex == 4)
                  ? IconButton(
                      icon: SvgPicture.asset(
                          'assets/svg/bottombar_icons/more_sel.svg'),
                      onPressed: () => null,
                    )
                  : IconButton(
                      icon: SvgPicture.asset(
                          'assets/svg/bottombar_icons/more.svg'),
                      onPressed: () => null,
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
                rate.toString(),
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
