import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/pages/discount/discount_calculator_page.dart';
import 'package:kinda_work/main/pages/discount/visit_history_page.dart';
import 'package:kinda_work/other/pages/add_company_page.dart';
import 'package:kinda_work/other/pages/booking_page.dart';
import 'package:kinda_work/other/pages/favorites_page.dart';
import 'package:kinda_work/other/pages/offer_page.dart';
import 'package:kinda_work/other/pages/profile/profile_page.dart';
import 'package:kinda_work/other/pages/users_page.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/shared_widgets.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // TODO remove back arrow
        appBar: CustomAppBar(title: 'Прочее'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _size.height * cVertical),
              TopPart(),
              Divider(thickness: 1.0),
              BusinessPart(),
              Divider(thickness: 1.0),
              SizedBox(height: _size.height * cVertical),
              BottomPart(),
              Divider(thickness: 1.0),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _size.width * cHorizont,
                  vertical: _size.height * cVertical,
                ),
                child: CustomButton(
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AddCompanyPage(),
                    ),
                  ),
                  buttonText: 'Добавить компанию',
                  buttonColor: cGrey,
                  buttonBorderColor: Colors.grey[600],
                  buttonTextColor: Colors.black,
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(currentIndex: 4),
      ),
    );
  }
}

class TopPart extends StatelessWidget {
  const TopPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline),
                  SizedBox(width: 10.0),
                  Text(
                    'Профиль',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ProfilePage(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          indent: size(context, hor),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_outline),
                  SizedBox(width: 10.0),
                  Text(
                    'Избранное',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FavoritesPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: size(context, hor)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.account_box),
                  SizedBox(width: 10.0),
                  Text(
                    'Регион',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Минск',
                    style: style2(context),
                  ),
                  CustomRedRightArrow(
                    onPressed: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 0),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FavoritesPage(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: size(context, hor)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outlined),
                  SizedBox(width: 10.0),
                  Text(
                    'Как это работает',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FavoritesPage(),
                  ),
                ),
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
    Size _size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            _size.width * cHorizont,
            _size.height * cVertical,
            0.0,
            _size.height * cVertical,
          ),
          child: Text(
            'Бизнес',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _size.width * cHorizont),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'История посещений',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        VisitHistoryPage(historyVisits: historyVisitsManyUsers),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 1.0, indent: _size.width * cHorizont),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _size.width * cHorizont),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Пользователи',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        UsersPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          indent: _size.width * cHorizont,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _size.width * cHorizont),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Бронирование',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: _size.height * 0.015,
                    height: _size.height * 0.015,
                    decoration: BoxDecoration(
                        color: cPink,
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                  CustomRedRightArrow(
                    onPressed: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(seconds: 0),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            BookingPage(),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          indent: _size.width * cHorizont,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _size.width * cHorizont),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Калькулятор скидки',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        DiscountCalculatorPage(),
                  ),
                ),
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
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: _size.width * cHorizont),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.mail_outline),
                  SizedBox(width: 10.0),
                  Text(
                    'Обратная связь',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FavoritesPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          indent: _size.width * cHorizont,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _size.width * cHorizont),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.work_outline),
                  SizedBox(width: 10.0),
                  Text(
                    'Оферта',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        OfferPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.0,
          indent: _size.width * cHorizont,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: _size.width * cHorizont),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.file_copy_outlined),
                  SizedBox(width: 10.0),
                  Text(
                    'Конфиденциальность',
                    style:
                        style2(context).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomRedRightArrow(
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FavoritesPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
