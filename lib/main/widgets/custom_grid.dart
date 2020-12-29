import 'package:flutter/material.dart';
import 'package:kinda_work/models.dart';

import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/constants.dart';

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
          infoElement: infoElements[index],
        ),
      ),
    );
  }
}

class CustomGridView1 extends StatelessWidget {
  const CustomGridView1({
    Key key,
    @required this.infoElements,
    @required this.crossAxisCount,
    this.padding,
    this.margin,
    this.mainAxisSpacing = 10.0,
    this.crossAxisSpacing = 10.0,
  }) : super(key: key);

  final List<InfoElement> infoElements;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsets padding;
  final EdgeInsets margin;

  Widget _getGrid({
    BoxConstraints constraints,
  }) {
    int _k = 0; // count of children in row
    int _r = 0; // count of rows
    List<Widget> _rowChildren = [];
    List<Widget> _columnChildren = [];

    for (var element in infoElements) {
      _columnChildren.clear();
      _rowChildren.add(
        Container(
          width: (constraints.maxWidth - crossAxisSpacing) / crossAxisCount,
          height:
              (constraints.maxWidth - crossAxisSpacing) / crossAxisCount * 1.1,
          child: CustomGridViewElement(infoElement: element),
        ),
      );
      _k++; // add child in Row

      _columnChildren.add(
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _rowChildren,
            ),
            SizedBox(
                height: infoElements.length ~/ crossAxisCount == _r
                    ? 0.0
                    : mainAxisSpacing),
          ],
        ),
      );

      if (_k == crossAxisCount) {
        _r++; //add row element in Column
        _rowChildren = [];
        _k = 0;
      }
    }
    return Container(
      padding: padding,
      margin: margin,
      child: Column(
        children: _columnChildren,
      ),
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
    @required this.infoElement,
  }) : super(key: key);

  final InfoElement infoElement;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgets =
        (infoElement.oldPrice != null || infoElement.newPrice != null)
            ? _listWidgetsWithPrices(
                infoElement.lightText,
                infoElement.rate,
                infoElement.countMessages,
                infoElement.newPrice,
                infoElement.oldPrice,
                isLarge: infoElement.isLargeGridElement,
              )
            : _listWidgetsWithoutPrices(
                infoElement.lightText,
                infoElement.boltText,
                infoElement.rate,
                infoElement.countMessages,
              );
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
                        image: AssetImage(infoElement.img),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _widgets,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Positioned(
              top: 5.0,
              right: 5.0,
              child: FavoriteBadge(favorite: infoElement.favoriteSelected),
            ),
            Positioned(
              top: constraints.maxHeight * 0.52,
              left: 8.0,
              child: DiscountBadge(discount: infoElement.discount),
            ),
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
