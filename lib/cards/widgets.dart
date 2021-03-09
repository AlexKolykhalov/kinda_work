import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';

class CardIconWidget extends StatelessWidget {
  const CardIconWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    return Container(
      width: _hor * 4,
      height: _hor * 3,
      decoration: BoxDecoration(
        color: cPink,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Icon(
              Icons.add,
              size: constraints.maxHeight * 0.65,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          color: Colors.redAccent[700],
          child: Center(
            child: Text(
              'A',
              style: TextStyle(
                color: Colors.white,
                fontSize: constraints.maxHeight * 0.7,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
