import 'package:flutter/material.dart';

import 'package:kinda_work/main/pages/beauty/pages/map_page.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key key,
    this.padding,
    this.margin,
  }) : super(key: key);

  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: padding,
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
              onTap: () => displayQrCode(context),
              child: Container(
                width: size(context, 0.07),
                height: size(context, 0.07),
                padding: EdgeInsets.all(size(context, 0.02)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: cIndigo,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      offset: Offset(1.0, 2.0),
                    ),
                  ],
                ),
                child: cQrCodeIcon,
              )),
          Container(
            width: size(context, 0.21),
            height: size(context, 0.07),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  offset: Offset(1.0, 2.0),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      MapPage(),
                ),
              ),
              child: Padding(
                  padding: EdgeInsets.all(size(context, 0.015)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 25.0,
                        height: 25.0,
                        child: cLocationIcon,
                      ),
                      Text(
                        'На карте',
                        style: style1(context).copyWith(
                          color: cIndigo,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => null
                  //CameraPage(size: size),
                  ),
            ),
            child: Container(
              width: size(context, 0.07),
              height: size(context, 0.07),
              padding: EdgeInsets.all(size(context, 0.02)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: cIndigo,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(1.0, 2.0),
                  ),
                ],
              ),
              child: cScanBarCodeIcon,
            ),
          )
        ],
      ),
    );
  }
}
