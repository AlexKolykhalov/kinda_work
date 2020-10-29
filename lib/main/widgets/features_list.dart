import 'package:flutter/material.dart';

import 'package:kinda_work/main/pages/beauty/beauty.dart';
import 'package:kinda_work/main/pages/restaurants_cafe_page.dart';

class FeaturesList extends StatelessWidget {
  const FeaturesList({
    Key key,
    @required this.size,
    @required this.currentIndex,
  }) : super(key: key);

  final Size size;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listViewElements = [
      {
        'img': 'assets/png/features/1.png',
        'text': 'Рестораны и кафе',
        'page': RestaurantsCafe(
          currentIndex: currentIndex,
        ),
      },
      {
        'img': 'assets/png/features/2.png',
        'text': 'Красота',
        'page': Beauty(
          currentIndex: currentIndex,
        ),
      },
      {
        'img': 'assets/png/features/3.png',
        'text': 'Развлечения',
        'page': null //Entertainment(),
      },
      {
        'img': 'assets/png/features/4.png',
        'text': 'Авто и мото',
        'page': null //Autoservices(),
      },
      {
        'img': 'assets/png/features/5.png',
        'text': 'Спорт',
        'page': null //Sports(),
      },
    ];
    return Container(
      height: size.height * 0.18,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => ListElement(
          size: size,
          page: listViewElements[index]['page'],
          img: listViewElements[index]['img'],
          text: listViewElements[index]['text'],
        ),
        itemCount: listViewElements.length,
      ),
    );
  }
}

class ListElement extends StatelessWidget {
  const ListElement({
    Key key,
    @required this.size,
    @required this.page,
    @required this.img,
    @required this.text,
  }) : super(key: key);

  final Size size;
  final Widget page;
  final String img;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => page),
      ),
      child: Column(
        children: [
          Container(
            width: size.height * 0.1,
            height: size.height * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                image: AssetImage(img),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Container(
            width: size.height * 0.15,
            child: Text(
              text,
              style: TextStyle(fontSize: size.height * 0.02),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
