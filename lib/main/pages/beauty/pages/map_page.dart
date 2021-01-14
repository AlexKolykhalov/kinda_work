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

enum zoomButtonsType { zoomIn, zoomOut, center }

class MapPage extends StatefulWidget {
  const MapPage({Key key}) : super(key: key);

  // final Size size;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController _mapController;
  int _id;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _id = 1;
  }

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
      width: 180.0,
      height: 180.0,
      point: position,
      builder: (ctx) => Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 180.0,
            height: 180.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cIndigo.withOpacity(0.2),
            ),
          ),
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          Container(
            width: 23.5,
            height: 23.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cIndigo,
            ),
            child: Center(
              child: Icon(
                Icons.near_me_sharp,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Marker _buildInfoMarker({
    @required InfoMarker infoMarker,
  }) {
    return Marker(
      width: 50.0,
      height: 50.0,
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
            Container(
              width: 45.0,
              height: 45.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _id == infoMarker.id ? cIndigo : Colors.red,
              ),
              child: Center(
                  child: Text(
                (infoMarker.places.length + infoMarker.promotions.length)
                    .toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Marker _buildDiscountMarker({
    @required DiscountMarker discountMarker,
  }) {
    return Marker(
      width: 75.0,
      height: 35.0,
      point: discountMarker.position,
      builder: (ctx) => Container(
        width: 75.0,
        height: 30.0,
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
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 10.0,
                  height: 10.0,
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
                fontSize: 15.0,
              ),
            )
          ],
        ),
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
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ZoomButtons(
                        buttonType: zoomButtonsType.zoomIn,
                        mapController: _mapController,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 25.0),
                        child: ZoomButtons(
                          buttonType: zoomButtonsType.zoomOut,
                          mapController: _mapController,
                        ),
                      ),
                      ZoomButtons(
                        buttonType: zoomButtonsType.center,
                        mapController: _mapController,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
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
      Size _size = MediaQuery.of(context).size;
      return Container(
        height: _size.height * 0.55,
        padding: EdgeInsets.symmetric(
          horizontal: size(context, hor),
          vertical: size(context, vert),
        ),
        color: cGrey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: _size.width * 0.1,
                height: _size.height * 0.005,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size(context, vert)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Заведения',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      // TODO склонения
                      '${listPlaces.length} предложений',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PlacePage(),
                      ),
                    ),
                    child: Container(
                      width: 20.0,
                      child: CustomGridViewElement(element: listPlaces[index]),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 15.0),
                  itemCount: listPlaces.length,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size(context, vert)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Акции',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      '${listPromotions.length} предложения',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            PromotionPage(),
                      ),
                    ),
                    child: Container(
                      width: 20.0,
                      child:
                          CustomGridViewElement(element: listPromotions[index]),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 15.0),
                  itemCount: listPromotions.length,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class ZoomButtons extends StatelessWidget {
  const ZoomButtons({
    Key key,
    @required this.buttonType,
    @required this.mapController,
  }) : super(key: key);

  final buttonType;
  final MapController mapController;

  Icon _icon() {
    if (buttonType == zoomButtonsType.zoomIn) {
      return Icon(Icons.add, color: Colors.grey[600]);
    } else if (buttonType == zoomButtonsType.zoomOut) {
      return Icon(Icons.remove, color: Colors.grey[600]);
    } else
      return Icon(Icons.near_me_outlined, color: Colors.grey[600]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (buttonType == zoomButtonsType.zoomIn) {
          if (mapController.zoom + 1 < 19.0) {
            mapController.move(mapController.center, mapController.zoom + 1);
          }
        }
        if (buttonType == zoomButtonsType.zoomOut) {
          if (mapController.zoom - 1 > 14.0) {
            mapController.move(mapController.center, mapController.zoom - 1);
          }
        }
        if (buttonType == zoomButtonsType.center) {
          mapController.move(LatLng(53.909480, 27.544318), 16.0);
        }
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 5.0,
              )
            ]),
        child: Center(child: _icon()),
      ),
    );
  }
}
