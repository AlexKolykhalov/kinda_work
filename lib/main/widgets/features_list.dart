import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';

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
          SizedBox(height: size(context, 0.01)),
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
