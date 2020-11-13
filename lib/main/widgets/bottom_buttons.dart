import 'package:flutter/material.dart';

import 'package:kinda_work/main/pages/beauty/pages/map_page.dart';
import 'package:kinda_work/main/pages/camera/camera_page.dart';
import 'package:kinda_work/widgets.dart';
import 'package:kinda_work/constants.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () => displayQrCode(context),
              child: Container(
                width: size.height * cHeight,
                height: size.height * cHeight,
                padding: EdgeInsets.all(size.height * 0.02),
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
            width: size.height * 3 * cHeight,
            height: size.height * cHeight,
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
                  padding: EdgeInsets.all(size.height * 0.015),
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
                        style: TextStyle(
                          color: cIndigo,
                          fontSize: size.height * 0.03,
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
              MaterialPageRoute(
                builder: (context) => CameraPage(size: size),
              ),
            ),
            child: Container(
              width: size.height * cHeight,
              height: size.height * cHeight,
              padding: EdgeInsets.all(size.height * 0.02),
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
