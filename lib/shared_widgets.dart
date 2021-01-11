import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinda_work/main/pages/discount/discount_details_page.dart';
import 'package:latlong/latlong.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/BLoC/switcher_icon_cubit.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/main/BLoC/bloc/search_result_bloc.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/promo/BLoC/horizontal_listview_switcher_cubit.dart';
import 'package:kinda_work/promo/widgets/custom_bottom_appbar.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    this.padding,
    this.margin,
    @required this.onTap,
    @required this.buttonText,
    @required this.buttonColor,
    this.buttonBorderColor = Colors.transparent,
    @required this.buttonTextColor,
    this.isBoldButtonText = true,
  }) : super(key: key);

  final VoidCallback onTap;
  final EdgeInsets padding;
  final EdgeInsets margin;
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
        height: math.min(size(context, 0.075), 48.0),
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: buttonBorderColor)),
        child: Center(
          child: Text(
            buttonText,
            style: style2(context).copyWith(
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
    this.title,
    this.height = 56.0,
    this.actions = const [],
    this.bottom,
    this.backgroundColor = Colors.white,
    this.showBackArrow = true,
    this.elevation = 4.0,
  }) : super(key: key);

  final String title;
  final double height;
  final List<Widget> actions;
  final AppBarBottom bottom;
  final Color backgroundColor;
  final bool showBackArrow;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title ?? '',
        style: TextStyle(
          color: Colors.black,
          fontSize: height * 0.38,
        ),
      ),
      leading: Visibility(
        visible: showBackArrow,
        child: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Container(width: size(context, 0.035), child: cLeftArrow),
        ),
      ),
      actions: actions,
      bottom: bottom != null
          ? CustomBottomAppBar(
              preferredSize: preferredSize,
              tabController: bottom.tabController,
              bottomData: bottom.bottomData,
              isScrollable: bottom.isScrollable,
            )
          : null,
      backgroundColor: backgroundColor,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize =>
      bottom != null ? Size.fromHeight(height * 1.7) : Size.fromHeight(height);
}

class CustomAppBarWithSearch extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithSearch({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

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
      title: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  height: constraints.maxWidth * 0.1,
                  child: TextField(
                    onChanged: (value) {
                      if (value.length > 3) {
                        BlocProvider.of<SearchResultBloc>(context).add(
                          SearchResultFetched(
                              searchText: _textEditingController.text),
                        );
                      }
                    },
                    style:
                        style3(context).copyWith(fontWeight: FontWeight.bold),
                    controller: _textEditingController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                          child: cSearchIcon,
                        ),
                        isCollapsed: true,
                        hintText: 'Поиск',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.5),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: cGrey,
                        filled: true),
                  ),
                ),
              ),
              Visibility(
                visible: _isVisible,
                child: GestureDetector(
                  onTap: () {
                    _textEditingController.clear();
                    BlocProvider.of<SearchResultBloc>(context).add(
                      SearchResultCleared(),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.05),
                    child: Text(
                      'Отмена',
                      style: style3(context).copyWith(color: cPink),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    Key key,
    @required this.images,
    this.height,
  })  : assert(images.length == 4),
        super(key: key);

  final List<Image> images;
  final double height;

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  int _currentSlider;
  Size _size;

  @override
  void initState() {
    super.initState();
    _currentSlider = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.images,
          options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            height: widget.height,
            autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentSlider = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: _size.height * 0.02,
          left: _size.width / 3,
          child: Container(
            width: _size.width * 0.25,
            height: _size.height * 0.025,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentSlider == 0 ? FilledCircle() : UnfilledCircle(),
                _currentSlider == 1 ? FilledCircle() : UnfilledCircle(),
                _currentSlider == 2 ? FilledCircle() : UnfilledCircle(),
                _currentSlider == 3 ? FilledCircle() : UnfilledCircle(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class FilledCircle extends StatelessWidget {
  const FilledCircle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context, 0.02),
      height: size(context, 0.02),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}

class UnfilledCircle extends StatelessWidget {
  const UnfilledCircle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context, 0.015),
      height: size(context, 0.015),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: Colors.white),
        color: Colors.transparent,
      ),
    );
  }
}

class CustomGridViewTitle extends StatelessWidget {
  const CustomGridViewTitle({
    Key key,
    @required this.title,
    @required this.textTotalAmount,
    this.padding,
    this.margin,
  }) : super(key: key);

  final String title;
  final String textTotalAmount;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              title,
              style: style2(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: size(context, hor)),
            Text(
              textTotalAmount,
              style: style4(context).copyWith(color: Colors.grey[600]),
            ),
          ]),
          Text(
            'Все',
            style: style2(context).copyWith(
              color: cPink,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

// TODO make common for all TabBars
class CustomHorizontalListView extends StatelessWidget {
  const CustomHorizontalListView({
    Key key,
    @required this.listViewData,
    @required this.selectedElement,
  }) : super(key: key);

  final List<String> listViewData;
  final int selectedElement;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size(context, 0.05),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => BlocProvider.of<SwitcherHorigontalListViewCubit>(context)
              .changed(index),
          child: ListViewElement(
            title: listViewData[index],
            isSelected: selectedElement == index,
          ),
        ),
        itemCount: listViewData.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: size(context, 0.02)),
      ),
    );
  }
}

class ListViewElement extends StatelessWidget {
  const ListViewElement({
    Key key,
    @required this.title,
    @required this.isSelected,
  }) : super(key: key);

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
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
      constraints: BoxConstraints(
        minWidth: size(context, 0.055),
        minHeight: size(context, 0.055),
      ),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: rate == 0.0 ? Colors.grey[600] : textColor,
          size: size(context, 0.02),
        ),
        SizedBox(width: size(context, 0.005)),
        (rate == 0.0)
            ? Text(
                'Нет оценок',
                style: style3(context).copyWith(
                  color: Colors.grey[600],
                ),
              )
            : Text(
                rate.toStringAsFixed(rate.truncateToDouble() == rate ? 0 : 1),
                style: style3(context).copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
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
          Text(
            countMessages.toString(),
            style: style4(context).copyWith(
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: size(context, 0.008)),
          SvgPicture.asset(
            'assets/svg/chat.svg',
            width: size(context, 0.02),
            height: size(context, 0.02),
          )
        ],
      ),
    );
  }
}

class FavoriteBadge extends StatelessWidget {
  const FavoriteBadge({
    Key key,
    this.favorite,
  }) : super(key: key);

  final bool favorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context, 0.035),
      height: size(context, 0.035),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Icon(
          favorite ? Icons.favorite : Icons.favorite_border,
          color: cPink,
          size: size(context, 0.022),
        ),
      ),
    );
  }
}

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({
    Key key,
    @required this.discount,
  }) : super(key: key);

  final int discount;

  @override
  Widget build(BuildContext context) {
    //print('-->DiscountBadge');
    return Visibility(
      visible: discount > 0,
      child: Container(
        width: size(context, 0.07),
        height: size(context, 0.033),
        decoration: BoxDecoration(
          color: cPink,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Text(
                '-${discount.toString()}%',
                style: TextStyle(
                  fontSize: constraints.maxHeight * 0.65,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      ),
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
          style: style4(context).copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
      indent: size.width * hor,
    ));
  }
  return _widgets;
}

// TODO do something with size
createReviewWidget(Review review, Size _size) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: _size.width * hor),
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
                visible: review.managerResponse != null,
                child: Container(
                  padding: EdgeInsets.only(left: _size.width * 0.12 + 10.0),
                  child:
                      ManagerResponse(response: review.managerResponse ?? ''),
                ),
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
                    SizedBox(width: size(context, 0.023), child: cPriceQuality),
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
    );
  }
}

// TODO нужен ли?
class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: size(context, hor),
      thickness: 1.0,
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

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    Key key,
  }) : super(key: key);

  @override
  _EmailTextFieldState createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final _controller = TextEditingController();
  final bool _showIcon = true;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: math.min(size(context, 0.075), 48.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: _controller,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Email',
                  hintStyle: style2(context),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                ),
              ),
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  if (_showIcon) {
                    _controller.clear();
                    BlocProvider.of<SwitcherIconCubit>(context).changed();
                  }
                },
                padding: EdgeInsets.zero,
                iconSize: constraints.maxHeight * 0.5,
                icon: _showIcon ? Icon(Icons.phone, color: cPink) : Icon(null),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    Key key,
    this.maxLength,
    this.hintText = '',
  }) : super(key: key);

  final int maxLength;
  final String hintText;

  @override
  _PhoneTextFieldState createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO make propper phone number fotmatter
    return Container(
      height: math.min(size(context, 0.075), 48.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                onChanged: (value) {
                  if (widget.maxLength != null &&
                      value.length == widget.maxLength) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 5),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            DiscountDetailsPage(),
                      ),
                    );
                    _controller.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                controller: _controller,
                maxLength: widget.maxLength,
                keyboardType: TextInputType.phone,
                textAlignVertical: TextAlignVertical.center,
                style: style2(context),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  fillColor: Colors.white,
                  filled: true,
                  hintText: widget.hintText,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                  prefixIcon: Container(
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+375',
                          style: style2(context)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                          size: constraints.maxHeight * 0.6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: false,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    _controller.clear();
                    BlocProvider.of<SwitcherIconCubit>(context).changed();
                  },
                  icon: Icon(Icons.email, color: cPink),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key key}) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final _controller = TextEditingController();
  bool _obscureText = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: math.min(size(context, 0.075), 48.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: _controller,
                obscureText: _obscureText,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Пароль',
                  hintStyle: style2(context),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05),
                ),
              ),
              IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () => setState(() {
                  _obscureText = !_obscureText;
                }),
                padding: EdgeInsets.zero,
                iconSize: constraints.maxHeight * 0.5,
                icon: Icon(
                  Icons.remove_red_eye,
                  color: _obscureText ? Colors.grey : cPink,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key key,
    this.text,
    this.maxLength,
    this.fontWeight = FontWeight.normal,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.isEnabled = true,
    this.isMultiLines = false,
    this.popupMenuItems = const [],
  }) : super(key: key);

  final TextInputType keyboardType;
  final String text;
  final int maxLength;
  final FontWeight fontWeight;
  final String hintText;
  final bool isEnabled;
  final List<dynamic> popupMenuItems;
  final bool isMultiLines;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController _controller;
  double _height;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.isMultiLines) {
      _height = null;
    } else {
      _height = math.min(size(context, 0.075), 48.0);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: _controller,
                onTap: () => print('object'),
                onChanged: (value) {
                  if (widget.maxLength != null &&
                      value.length == widget.maxLength) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 5),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            DiscountDetailsPage(),
                      ),
                    );
                    _controller.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                keyboardType: widget.keyboardType,
                textAlignVertical: TextAlignVertical.center,
                maxLength: widget.maxLength,
                minLines: widget.isMultiLines ? 6 : 1,
                maxLines: widget.isMultiLines ? 6 : 1,
                style: style2(context).copyWith(
                  color: widget.isEnabled ? Colors.black : Colors.grey[600],
                  fontWeight: widget.fontWeight,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: '',
                  enabled: widget.isEnabled,
                  fillColor: Colors.white,
                  filled: widget.isEnabled ?? false,
                  hintText: widget.hintText,
                  hintStyle:
                      style2(context).copyWith(fontWeight: FontWeight.normal),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                    vertical: widget.isMultiLines ? 5.0 : 0.0,
                  ),
                ),
              ),
              Visibility(
                visible: widget.popupMenuItems.isNotEmpty,
                child: PopupMenuButton<String>(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: cPink,
                  ),
                  onSelected: (String val) {
                    _controller.text = val;
                  },
                  itemBuilder: (context) => widget.popupMenuItems
                      .map<PopupMenuItem<String>>((dynamic val) =>
                          PopupMenuItem(child: Text(val), value: val))
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
