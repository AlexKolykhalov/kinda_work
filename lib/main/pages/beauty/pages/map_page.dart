import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:kinda_work/styles.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/info_element/promotion_page.dart';
import 'package:kinda_work/info_element/place_page.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/shared_widgets.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _mapController = MapController();
  int _id = 1;

  List<Marker> _buildMarkers() {
    List<Marker> _markers = [];
    Marker _marker;
    var center = LatLng(53.909480, 27.544318);
    _marker = _buildUserLocationMarker(position: center);
    _markers.add(_marker);
    for (var infoMarker in listInfoMarkers) {
      _marker = _buildInfoMarker(infoMarker: infoMarker);
      _markers.add(_marker);
    }
    for (var discountMarker in listDiscountMarkers) {
      _marker = _buildDiscountMarker(discountMarker: discountMarker);
      _markers.add(_marker);
    }
    return _markers;
  }

  Marker _buildUserLocationMarker({
    @required LatLng position,
  }) {
    return Marker(
      width: size(context, 0.3),
      height: size(context, 0.3),
      point: position,
      builder: (ctx) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: constraints.maxHeight,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cIndigo.withOpacity(0.2),
                ),
              ),
              Container(
                width: constraints.maxHeight * 0.2,
                height: constraints.maxHeight * 0.2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              Container(
                width: constraints.maxHeight * 0.15,
                height: constraints.maxHeight * 0.15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cIndigo,
                ),
                child: Center(
                  child: Icon(
                    Icons.near_me_sharp,
                    color: Colors.white,
                    size: constraints.maxHeight * 0.12,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Marker _buildInfoMarker({
    @required InfoMarker infoMarker,
  }) {
    return Marker(
      width: size(context, 0.1),
      height: size(context, 0.1),
      point: infoMarker.position,
      builder: (ctx) => GestureDetector(
        onTap: () {
          setState(() {
            _id = infoMarker.id;
          });
          _displayBottomSheet(
            context,
            infoMarker.places,
            infoMarker.promotions,
          );
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: constraints.maxHeight * 0.8,
                  height: constraints.maxHeight * 0.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
                Container(
                  width: constraints.maxHeight * 0.62,
                  height: constraints.maxHeight * 0.62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: constraints.maxHeight * 0.48,
                  height: constraints.maxHeight * 0.48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _id == infoMarker.id ? cIndigo : Colors.red,
                  ),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Center(
                        child: Text(
                          (infoMarker.places.length +
                                  infoMarker.promotions.length)
                              .toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: constraints.maxHeight * 0.55,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Marker _buildDiscountMarker({
    @required DiscountMarker discountMarker,
  }) {
    return Marker(
      width: size(context, 0.13),
      height: size(context, 0.06),
      point: discountMarker.position,
      builder: (ctx) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.38,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * 0.26,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * 0.15,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Text(
                  '-${discountMarker.discount.toString()}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: constraints.maxHeight * 0.48,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('-->MapPage');
    var center = LatLng(53.909480, 27.544318);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Красота',
          actions: [cSearchIcon],
        ),
        body: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: center,
              zoom: 16.0,
            ),
            children: [
              TileLayerWidget(
                  options: TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'])),
              MarkerLayerWidget(
                  options: MarkerLayerOptions(
                markers: _buildMarkers(),
              )),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: size(context, hor)),
                  child: ZoomButtons(mapController: _mapController),
                ),
              ),
            ]),
      ),
    );
  }
}

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

void _displayBottomSheet(
  BuildContext context,
  List<Company> listPlaces,
  List<Promotion> listPromotions,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height > 550
            ? size(context, 0.74)
            : size(context, 0.78),
        padding: EdgeInsets.symmetric(
          horizontal: size(context, hor),
          vertical: size(context, 0.01),
        ),
        color: cGrey,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                Container(
                  width: constraints.maxWidth * 0.12,
                  height: constraints.maxHeight * 0.01,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Row(
                  children: [
                    Text(
                      'Заведения',
                      style: style3(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.03),
                    Text(
                      '${listPlaces.length} предложений',
                      style: style4(context).copyWith(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                Container(
                  height: constraints.maxHeight * 0.38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  PlacePage(),
                        ),
                      ),
                      child: Container(
                        width: constraints.maxWidth * 0.53,
                        child:
                            CustomGridViewElement(element: listPlaces[index]),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: constraints.maxWidth * 0.03,
                    ),
                    itemCount: listPlaces.length,
                  ),
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    Text(
                      'Акции',
                      style: style3(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.03),
                    Text(
                      '${listPromotions.length} предложений',
                      style: style4(context).copyWith(
                        color: Colors.grey[600],
                      ),
                    )
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                Container(
                  height: constraints.maxHeight * 0.46,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  PromotionPage(),
                        ),
                      ),
                      child: Container(
                        width: constraints.maxWidth * 0.53,
                        child: CustomGridViewElement(
                            element: listPromotions[index]),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(width: constraints.maxWidth * 0.03),
                    itemCount: listPromotions.length,
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
