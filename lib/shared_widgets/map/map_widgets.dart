import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/styles.dart';

class ZoomButtons extends StatelessWidget {
  const ZoomButtons({
    Key key,
    @required this.mapController,
  }) : super(key: key);

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ZoomButton(
          onTap: () {
            if (mapController.zoom + 1 < 19.0) {
              mapController.move(mapController.center, mapController.zoom + 1);
            }
          },
          icon: Icons.add,
        ),
        SizedBox(height: size(context, 0.025)),
        ZoomButton(
          onTap: () {
            if (mapController.zoom - 1 > 14.0) {
              mapController.move(mapController.center, mapController.zoom - 1);
            }
          },
          icon: Icons.remove,
        ),
        SizedBox(height: size(context, 0.05)),
        ZoomButton(
          onTap: () {
            mapController.move(LatLng(53.909480, 27.544318), 16.0);
          },
          icon: Icons.near_me_outlined,
        ),
      ],
    );
  }
}

class ZoomButton extends StatelessWidget {
  const ZoomButton({
    Key key,
    @required this.onTap,
    @required this.icon,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size(context, 0.065),
        height: size(context, 0.065),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 5.0,
              )
            ]),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: Icon(
                icon,
                size: constraints.maxHeight * 0.65,
                color: Colors.grey[600],
              ),
            );
          },
        ),
      ),
    );
  }
}
