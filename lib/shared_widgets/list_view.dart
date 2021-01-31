import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/grid_view.dart';
import 'package:kinda_work/styles.dart';

class CustomHorizontalListViewCompanies extends StatelessWidget {
  const CustomHorizontalListViewCompanies({
    Key key,
    @required this.elements,
    this.padding,
    this.margin,
  }) : super(key: key);

  final List<dynamic> elements;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    print('-->CustomHorizontalListViewCompanies');
    return Container(
      height: size(context, 0.28),
      padding: padding,
      margin: margin,
      child: CustomHorizontalListView(elements: elements),
    );
  }
}

class CustomHorizontalListViewPromos extends StatelessWidget {
  const CustomHorizontalListViewPromos({
    Key key,
    @required this.elements,
    this.padding,
    this.margin,
  }) : super(key: key);

  final List<dynamic> elements;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    print('-->HorizontalListViewPromos');
    return Container(
      height: size(context, 0.35),
      padding: padding,
      margin: margin,
      child: CustomHorizontalListView(elements: elements),
    );
  }
}

class CustomHorizontalListView extends StatelessWidget {
  const CustomHorizontalListView({
    Key key,
    @required this.elements,
  }) : super(key: key);

  final List<dynamic> elements;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Container(
        width: size(context, 0.25),
        child: CustomGridViewElement(
          element: elements[index],
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(
        width: size(context, hor),
      ),
      itemCount: elements.length,
    );
  }
}

class Sections extends StatelessWidget {
  const Sections({
    Key key,
    @required this.elements,
    this.padding,
    this.margin,
  }) : super(key: key);

  final List<Map<String, dynamic>> elements;

  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    print('-->Sections');
    return Container(
      height: size(context, 0.15),
      padding: padding,
      margin: margin,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => SectionElement(
          page: elements[index]['page'],
          img: elements[index]['img'],
          text: elements[index]['text'],
        ),
        separatorBuilder: (context, index) =>
            SizedBox(width: size(context, hor)),
        itemCount: elements.length,
      ),
    );
  }
}

class SectionElement extends StatelessWidget {
  const SectionElement({
    Key key,
    @required this.page,
    @required this.img,
    @required this.text,
  }) : super(key: key);

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
            width: size(context, 0.1),
            height: size(context, 0.1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                image: AssetImage(img),
              ),
            ),
          ),
          Expanded(child: Container()),
          Text(
            text,
            style: style3(context),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
