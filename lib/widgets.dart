import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/catalog/catalog_page.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/BLoC/bloc/search_result_bloc.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/promo/BLoC/horizontal_listview_switcher_cubit.dart';
import 'package:kinda_work/promo/promo_page.dart';
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
    @required this.size,
    @required this.title,
    this.showActions = true,
    this.showBottom = false,
    this.tabController,
    this.bottomData,
  }) : super(key: key);

  final Size size;
  final String title;
  final bool showActions;
  final bool showBottom;
  final TabController tabController;
  final List<String> bottomData;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      leading: FlatButton(
        onPressed: () => Navigator.pop(context),
        child: cLeftArrow,
      ),
      actions: [
        Visibility(
          visible: showActions,
          child: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: cSearchIcon,
          ),
        ),
      ],
      bottom: (showBottom)
          //TODO определиться, что выбрать
          ? CustomBottomAppBar1(
              preferredSize: preferredSize,
              tabController: tabController,
              bottomData: bottomData,
            )
          // CustomBottomAppBar(
          //     size: size,
          //     bottomListViewData: bottomListViewData,
          //     preferredSize: preferredSize,
          //   )
          : null,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => (showBottom)
      ? Size.fromHeight(size.height * 0.15)
      : Size.fromHeight(AppBar().preferredSize.height);
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
