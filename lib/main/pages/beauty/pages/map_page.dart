import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/info_element/info_element_page.dart';
import 'package:kinda_work/main/widgets/custom_grid.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/widgets.dart';

enum zoomButtonsType { zoomIn, zoomOut, center }

class MapPage extends StatefulWidget {
  const MapPage({Key key, @required this.size}) : super(key: key);

  final Size size;

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
    _id = 0;
  }

  Marker _buildCustomMarker({
    @required int id,
    @required int value,
    @required LatLng position,
  }) {
    return Marker(
      width: 50.0,
      height: 50.0,
      point: position,
      builder: (ctx) => GestureDetector(
        onTap: () {
          setState(() {
            _id = id;
          });
          _displayBottomSheet(context, MediaQuery.of(context).size);
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
                color: id == _id ? cIndigo : Colors.red,
              ),
              child: Center(
                  child: Text(
                value.toString(),
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

  Marker _buildLocationMarker({
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

  Marker _buildCustomDiscountMarker({
    @required int discount,
    @required LatLng position,
  }) {
    return Marker(
      width: 75.0,
      height: 35.0,
      point: position,
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
              '-${discount.toString()}%',
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
    var center = LatLng(53.909480, 27.544318);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          size: widget.size,
          title: 'Красота',
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
                markers: [
                  _buildLocationMarker(position: center),
                  _buildCustomMarker(
                    id: 0,
                    value: 12,
                    position: LatLng(53.912180, 27.545018),
                  ),
                  _buildCustomMarker(
                    id: 1,
                    value: 3,
                    position: LatLng(53.911080, 27.541718),
                  ),
                  _buildCustomMarker(
                    id: 2,
                    value: 7,
                    position: LatLng(53.908580, 27.546318),
                  ),
                  _buildCustomDiscountMarker(
                    discount: 95,
                    position: LatLng(53.912280, 27.541818),
                  ),
                  _buildCustomDiscountMarker(
                    discount: 50,
                    position: LatLng(53.911580, 27.547918),
                  ),
                  _buildCustomDiscountMarker(
                    discount: 15,
                    position: LatLng(53.908380, 27.541318),
                  ),
                ],
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

void _displayBottomSheet(BuildContext context, Size size) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (ctx) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * cHorizont),
        height: size.height,
        color: cGrey,
        child: SingleChildScrollView(
          child: Column(
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
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: size.height * cVertical),
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
                      '5 предложений',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                height: cConstantWidth / cRatioSmallSize,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            InfoElementPage(),
                      ),
                    ),
                    child: Container(
                      width: cConstantWidth,
                      child: CustomGridViewElement(
                          infoElement: InfoElement(
                        isLargeGridElement: false,
                        isDiscountVisible: false,
                        isFavoriteVisible: false,
                        lightText: 'Массажный салон',
                        img: 'assets/png/grid/2.png',
                        rate: 9.5,
                      )),
                    ),
                  ),

                  // CustomGridViewElement(
                  //   infoElement: InfoElement(
                  //     isLargeGridElement: false,
                  //     img: 'assets/png/grid/1.png',
                  //     lightText: 'SPA-салон',
                  //     boltText: 'Tao Спа',
                  //     isFavoriteVisible: false,
                  //     rate: 9.3,
                  //     countMessages: 2,
                  //     isDiscountVisible: false,
                  //   ),
                  //   gridElementSize: Size(120.0, 180.0),
                  // ),
                  separatorBuilder: (context, index) => SizedBox(width: 15.0),
                  itemCount: 1,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: size.height * cVertical),
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
                      '2 предложения',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height * 0.15,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(),

                  // CustomGridViewElement(
                  //   infoElement: InfoElement(
                  //     isLargeGridElement: false,
                  //     img: 'assets/png/grid/2.png',
                  //     lightText: 'SPA-салон',
                  //     boltText: 'Tao Спа',
                  //     isFavoriteVisible: false,
                  //     rate: 9.3,
                  //     countMessages: 20,
                  //     isDiscountVisible: true,
                  //     discount: 43,
                  //   ),
                  //   gridElementSize: Size(120.0, 180.0),
                  // ),
                  separatorBuilder: (context, index) => SizedBox(width: 15.0),
                  itemCount: 1,
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
