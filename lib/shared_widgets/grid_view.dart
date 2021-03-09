import 'package:flutter/material.dart';
import 'package:kinda_work/info_element/pages/company_page.dart';
import 'package:kinda_work/info_element/pages/promotion_page.dart';

import 'package:kinda_work/models.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/badges.dart';
import 'package:kinda_work/styles.dart';

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

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    Key key,
    @required this.elements,
    this.padding,
    this.margin,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 10.0,
    this.crossAxisSpacing = 10.0,
  }) : super(key: key);

  final List elements;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsets padding;
  final EdgeInsets margin;

  Widget _getGrid({
    BoxConstraints constraints,
  }) {
    int _k = 0; // total counter
    List<Widget> _rowChildren = [];
    List<Widget> _columnChildren = [];

    for (var i = 1; i <= (elements.length / crossAxisCount).ceil(); i++) {
      for (var j = 1; j <= crossAxisCount; j++) {
        try {
          _rowChildren.add(
            Row(
              children: [
                Container(
                  width: (constraints.maxWidth -
                          crossAxisSpacing * (crossAxisCount - 1)) /
                      crossAxisCount,
                  height: (constraints.maxWidth -
                          crossAxisSpacing * (crossAxisCount - 1)) /
                      crossAxisCount *
                      (elements[_k] is Company ? 1.15 : 1.45),
                  child: CustomGridViewElement(element: elements[_k]),
                ),
                SizedBox(
                  width: (crossAxisCount == j ? 0.0 : crossAxisSpacing),
                ),
              ],
            ),
          );
        } catch (e) {}
        _k++;
      }
      _columnChildren.add(
        Column(
          children: [
            Row(
              children: _rowChildren,
            ),
            SizedBox(
              height: (elements.length / crossAxisCount).ceil() == i
                  ? 0.0
                  : mainAxisSpacing,
            ),
          ],
        ),
      );
      _rowChildren = [];
    }

    return Container(
      padding: padding,
      margin: margin,
      child: Column(children: _columnChildren),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('-->CustomGridView');
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return _getGrid(constraints: constraints);
      },
    );
  }
}

class CustomGridViewElement extends StatelessWidget {
  const CustomGridViewElement({
    Key key,
    @required this.element,
  }) : super(key: key);

  final element;

  @override
  Widget build(BuildContext context) {
    // print('-->CustomGridViewElement');
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onTap: () {
            final Widget _elementPage = element is Company
                ? CompanyPage(company: element)
                : PromotionPage(promotion: element);
            // final Widget _elementPage = CompanyPage(company: element);
            return Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(seconds: 0),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    _elementPage,
              ),
            );
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  child: Column(children: [
                    Container(
                      height: constraints.maxHeight * 0.6,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(element.img),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(color: Colors.white),
                        child: element is Company
                            ? CompanyInfo(element: element)
                            : PromotionInfo(element: element),
                      ),
                    ),
                  ]),
                ),
              ),
              Positioned(
                top: 5.0,
                right: 5.0,
                child: FavoriteBadge(favorite: element.favorite),
              ),
              Positioned(
                top: constraints.maxHeight * 0.6 - size(context, 0.023),
                left: 8.0,
                child: DiscountBadge(discount: element.discount),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CompanyInfo extends StatelessWidget {
  const CompanyInfo({Key key, @required this.element}) : super(key: key);

  final Company element;

  @override
  Widget build(BuildContext context) {
    // print('-->CompanyInfo');
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              element.type,
              style: TextStyle(
                fontSize: constraints.maxHeight * 0.22,
                color: Colors.grey[600],
              ),
            ),
            Text(
              element.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: constraints.maxHeight * 0.26,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RateBadge(rate: element.rate, textColor: Colors.green),
                MessagesBadge(countMessages: element.messages),
              ],
            ),
          ],
        );
      },
    );
  }
}

class PromotionInfo extends StatelessWidget {
  const PromotionInfo({Key key, @required this.element}) : super(key: key);

  final Promotion element;

  @override
  Widget build(BuildContext context) {
    // print('-->PromotionInfo');
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: constraints.maxHeight * 0.48,
              child: LayoutBuilder(
                builder: (BuildContext context,
                    BoxConstraints containerConstraints1) {
                  return Text(
                    element.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: containerConstraints1.maxHeight * 0.375,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.48,
              child: LayoutBuilder(
                builder: (BuildContext context,
                    BoxConstraints containerConstraints2) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RateBadge(
                              rate: element.rate, textColor: Colors.green),
                          MessagesBadge(countMessages: element.messages),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'от ${element.newPrice} р.',
                            style: TextStyle(
                              color: cPink,
                              fontSize: containerConstraints2.maxHeight * 0.335,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: size(context, 0.02)),
                          Text(
                            '${element.oldPrice} р.',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[600],
                              fontSize: containerConstraints2.maxHeight * 0.335,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
