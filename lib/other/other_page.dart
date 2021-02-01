import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/add_company_page.dart';
import 'package:kinda_work/other/pages/booking_page.dart';
import 'package:kinda_work/other/pages/discount/discount_calculator_page.dart';
import 'package:kinda_work/other/pages/discount/visit_history_page.dart';
import 'package:kinda_work/other/pages/favorites_page.dart';
import 'package:kinda_work/other/pages/offer_page.dart';
import 'package:kinda_work/other/pages/profile/profile_page.dart';
import 'package:kinda_work/other/pages/users_page.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->OtherPage');
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return Scaffold(
              appBar: CustomAppBar(
                height: appBarHeight(context),
                showBackArrow: false,
                title: 'Прочее',
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: _vert),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopPart(),
                      Divider(thickness: 1.0),
                      BusinessPart(),
                      Divider(thickness: 1.0),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: _vert),
                        child: Column(
                          children: [
                            BottomPart(),
                            Divider(thickness: 1.0),
                          ],
                        ),
                      ),
                      CustomButton(
                        margin: EdgeInsets.symmetric(horizontal: _hor),
                        onTap: () {
                          final _addCompanyPage = AddCompanyPage();
                          return Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      _addCompanyPage,
                            ),
                          );
                        },
                        text: 'Добавить компанию',
                        color: cGrey,
                        borderColor: Colors.grey[600],
                        textColor: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class TopPart extends StatelessWidget {
  const TopPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final TextStyle _style2 = style2(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline),
                  SizedBox(width: _hor),
                  Text(
                    'Профиль',
                    style: _style2.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () {
                  final Widget _profilePage = ProfilePage();
                  return Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _profilePage,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: _hor),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_outline),
                  SizedBox(width: _hor),
                  Text(
                    'Избранное',
                    style: _style2.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () {
                  final Widget _favoritesPage = FavoritesPage();
                  return Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _favoritesPage,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: _hor),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.account_box),
                  SizedBox(width: _hor),
                  Text(
                    'Регион',
                    style: _style2.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Минск', style: style2(context)),
                  CustomRedRightArrow(
                    onPressed: () {
                      final Widget _favoritesPage = FavoritesPage();
                      return Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 0),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  _favoritesPage,
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: _hor),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outlined),
                  SizedBox(width: _hor),
                  Text(
                    'Как это работает',
                    style: _style2.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () {
                  final Widget _favoritesPage = FavoritesPage();
                  return Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _favoritesPage,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BusinessPart extends StatelessWidget {
  const BusinessPart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    final double _heightImg = size(context, 0.015);
    final TextStyle _style2 =
        style2(context).copyWith(fontWeight: FontWeight.bold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
          child: Text(
            'Бизнес',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('История посещений', style: _style2),
              CustomRedRightArrow(
                onPressed: () {
                  final Widget _visitHistoryPage =
                      VisitHistoryPage(historyVisits: historyVisitsManyUsers);
                  return Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _visitHistoryPage,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: _hor),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Пользователи', style: _style2),
              CustomRedRightArrow(
                onPressed: () {
                  final Widget _userPage = UsersPage();
                  return Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _userPage,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: _hor),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Бронирование', style: _style2),
              Row(
                children: [
                  Container(
                    width: _heightImg,
                    height: _heightImg,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cPink,
                    ),
                  ),
                  CustomRedRightArrow(
                    onPressed: () {
                      final Widget _bookingPage = BookingPage();
                      return Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 0),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  _bookingPage,
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: _hor),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Калькулятор скидки', style: _style2),
              CustomRedRightArrow(
                onPressed: () {
                  final Widget _discountCalculatorPage =
                      DiscountCalculatorPage();
                  return Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _discountCalculatorPage,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BottomPart extends StatelessWidget {
  const BottomPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final TextStyle _style2 =
        style2(context).copyWith(fontWeight: FontWeight.bold);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.mail_outline),
                  SizedBox(width: _hor),
                  Text('Обратная связь', style: _style2),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () {
                  final Widget _favoritesPage = FavoritesPage();
                  return Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _favoritesPage,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: _hor),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.work_outline),
                  SizedBox(width: _hor),
                  Text('Оферта', style: _style2),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () {
                  final Widget _offerPage = OfferPage();
                  return Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _offerPage,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: _hor),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _hor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.file_copy_outlined),
                  SizedBox(width: _hor),
                  Text('Конфиденциальность', style: _style2),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () {
                  final Widget _favoritesPage = FavoritesPage();
                  return Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _favoritesPage,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
