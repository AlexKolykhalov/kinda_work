import 'package:flutter/material.dart';
import 'package:kinda_work/main/pages/beauty/pages/map_page.dart';

import 'package:kinda_work/main/pages/camera/camera_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
              onTap: () => _displayBottomSheet(context, size),
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
                      MapPage(size: size),
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

void _displayBottomSheet(BuildContext context, Size size) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      return Container(
        height: size.height * 0.7,
        color: cGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width * 0.1,
              height: size.height * 0.005,
              margin: EdgeInsets.only(top: size.height * 0.02),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            Text('Покажите при оплате',
                style: TextStyle(fontSize: size.height * 0.021)),
            QrImage(
              data: '014900',
              version: QrVersions.auto,
              padding: EdgeInsets.all(30.0),
              size: size.height * 0.35,
              backgroundColor: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.1),
              child: Text('014 900',
                  style: TextStyle(fontSize: size.height * 0.05)),
            ),
          ],
        ),
      );
    },
  );
}
