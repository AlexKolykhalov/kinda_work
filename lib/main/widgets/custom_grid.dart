import 'package:flutter/material.dart';
import 'package:kinda_work/models.dart';

import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    Key key,
    @required this.size,
    @required this.childAspectRatio,
    @required this.infoElements,
    this.crossAxisCount = 2,
  })  : assert(crossAxisCount > 0 && crossAxisCount <= 2),
        super(key: key);

  final Size size;
  final double childAspectRatio;
  final int crossAxisCount;
  final List<InfoElement> infoElements;

  Map<String, dynamic> _getInitialData() {
    final Map<String, dynamic> _initialData = {};
    final double _totalHorizontalPadding = 2 * size.width * cHorizont;
    final int _crossAxisCount = childAspectRatio > 1 ? 1 : 2;
    final double _width = (size.width -
            _totalHorizontalPadding -
            cCrossAxisSpacing * (_crossAxisCount - 1)) /
        _crossAxisCount;
    final double _height = _width / childAspectRatio;
    final int _rows = (infoElements.length / _crossAxisCount).round();
    final double _totalHeight =
        (_rows * _height) + (cMainAxisSpacing * (_rows - 1));
    _initialData['totalHeight'] = _totalHeight;
    _initialData['crossAxisCount'] = _crossAxisCount;

    return _initialData;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> _initialData = _getInitialData();
    print('-->CustomGridView');
    return Container(
      height: _initialData['totalHeight'],
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: infoElements.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: childAspectRatio,
          mainAxisSpacing: cMainAxisSpacing,
          crossAxisSpacing: cCrossAxisSpacing,
          crossAxisCount: _initialData['crossAxisCount'],
        ),
        itemBuilder: (context, index) => CustomGridViewElement(
          element: infoElements[index],
        ),
      ),
    );
  }
}

class CustomGridView1 extends StatelessWidget {
  const CustomGridView1({
    Key key,
    @required this.children,
    @required this.crossAxisCount,
    this.padding,
    this.margin,
    this.mainAxisSpacing = 10.0,
    this.crossAxisSpacing = 10.0,
  }) : super(key: key);

  final List children;
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

    for (var i = 1; i <= (children.length / crossAxisCount).ceil(); i++) {
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
                      (children[_k] is Company ? 1.1 : 1.3),
                  child: CustomGridViewElement(element: children[_k]),
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
              height: (children.length / crossAxisCount).ceil() == i
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
    // final List<Widget> _widgets =
    //     (element.oldPrice != null || element.newPrice != null)
    //         ? _listWidgetsWithPrices(
    //             element.lightText,
    //             element.rate,
    //             element.countMessages,
    //             element.newPrice,
    //             element.oldPrice,
    //             isLarge: element.isLargeGridElement,
    //           )
    //         : _listWidgetsWithoutPrices(
    //             element.lightText,
    //             element.boltText,
    //             element.rate,
    //             element.countMessages,
    //           );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
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
              child: FavoriteBadge(favorite: element.favoriteSelected),
            ),
            Positioned(
              top: constraints.maxHeight * 0.53,
              left: 8.0,
              child: DiscountBadge(discount: element.discount),
            ),
          ],
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          element.type,
          style: style4(context).copyWith(
            color: Colors.grey[600],
          ),
        ),
        Text(
          element.name,
          style: style2(context).copyWith(
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
  }
}

class PromotionInfo extends StatelessWidget {
  const PromotionInfo({Key key, @required this.element}) : super(key: key);

  final Promotion element;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: constraints.maxHeight * 0.5,
              child: Text(element.discription, style: style3(context)),
            ),
            Container(
              height: constraints.maxHeight * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RateBadge(rate: element.rate, textColor: Colors.green),
                      MessagesBadge(countMessages: element.messages),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'от ${element.newPrice} р.',
                        style: style4(context).copyWith(
                          color: cPink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: size(context, 0.02)),
                      Text(
                        '${element.oldPrice} р.',
                        style: style4(context).copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

List<Widget> _listWidgetsWithPrices(String lightText, double rate,
    int countMessages, num newPrice, num oldPrice,
    {bool isLarge}) {
  if (isLarge) {
    return [
      Container(
        height: cConstantWidth * 0.055,
        child: Text(
          lightText,
          style: TextStyle(
            color: cIndigo,
            fontSize: cConstantWidth * scaleLightText,
          ),
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [RateBadge(rate: rate, textColor: Colors.green)],
        ),
        Row(
          children: [
            Text(
              'от $newPrice р.',
              style: TextStyle(
                color: cPink,
                fontWeight: FontWeight.bold,
                fontSize: cConstantWidth * scaleLightText,
              ),
            ),
            SizedBox(width: cConstantWidth * 0.02),
            Text(
              '$oldPrice р.',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey[600],
                fontSize: cConstantWidth * scaleLightText,
              ),
            ),
          ],
        ),
      ]),
    ];
  }
  return [
    Container(
      height: cConstantWidth * 0.2,
      child: Text(
        lightText,
        style: TextStyle(
          color: cIndigo,
          fontSize: cConstantWidth * scaleLightText,
        ),
      ),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RateBadge(rate: rate, textColor: Colors.green),
        MessagesBadge(countMessages: countMessages),
      ],
    ),
    Row(
      children: [
        Text(
          'от $newPrice р.',
          style: TextStyle(
            color: cPink,
            fontWeight: FontWeight.bold,
            fontSize: cConstantWidth * scaleLightText,
          ),
        ),
        SizedBox(width: cConstantWidth * 0.02),
        Text(
          '$oldPrice р.',
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            color: Colors.grey[600],
            fontSize: cConstantWidth * scaleLightText,
          ),
        ),
      ],
    ),
  ];
}

List<Widget> _listWidgetsWithoutPrices(
  String lightText,
  String boltText,
  double rate,
  int countMessages,
) {
  return [
    Text(
      lightText,
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: cConstantWidth * scaleLightText,
      ),
    ),
    Text(
      boltText,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: cConstantWidth * scaleBoltText),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RateBadge(rate: rate, textColor: Colors.green),
        MessagesBadge(countMessages: countMessages),
      ],
    ),
  ];
}
