import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/discount/discount_calculator_page.dart';
import 'package:kinda_work/other/pages/discount/discount_details_page.dart';
import 'package:kinda_work/shared_widgets/camera/scanner_utils.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/styles.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final _barcodeDetector = FirebaseVision.instance.barcodeDetector();

  CameraController _cameraController;
  Rect _validRect;
  Rect _barcodeBoundingBox;
  Rect _intersectionRect;
  Size _previewSize;
  double _hor;
  double _vert;
  double _appBarHeight;

  @override
  void initState() {
    super.initState();
    _initCameraAndScanner();
    _validRect = Rect.zero;
    _barcodeBoundingBox = Rect.zero;
    _intersectionRect = Rect.zero;
  }

  @override
  void didChangeDependencies() {
    _hor = size(context, hor);
    _vert = size(context, vert);
    _appBarHeight = appBarHeight(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _barcodeDetector.close();
    super.dispose();
  }

  void _initCameraAndScanner() {
    getCamera(CameraLensDirection.back).then(
      (CameraDescription camera) async {
        await _initCameraController(camera);
        await _initImageStreaming(camera.sensorOrientation);
      },
    );
  }

  Future<void> _initCameraController(CameraDescription camera) async {
    final ResolutionPreset preset =
        defaultTargetPlatform == TargetPlatform.android
            ? ResolutionPreset.medium
            : ResolutionPreset.low;

    _cameraController = CameraController(camera, preset);
    await _cameraController.initialize();
    _previewSize = _cameraController.value.previewSize;
    setState(() {});
  }

  Future<void> _initImageStreaming(int sensorOrientation) async {
    bool isDetecting = false;
    // final MediaQueryData data = MediaQuery.of(context);

    _cameraController.startImageStream((CameraImage image) {
      if (isDetecting) {
        return;
      }

      isDetecting = true;

      detect(
        image: image,
        detectInImage: _barcodeDetector.detectInImage,
        imageRotation: sensorOrientation,
      ).then(
        (dynamic result) {
          _handleResult(
            barcodes: result,
            imageSize: Size(image.width.toDouble(), image.height.toDouble()),
          );
        },
      ).whenComplete(() => isDetecting = false);
    });
  }

  void _handleResult({
    @required List<Barcode> barcodes,
    @required Size imageSize,
  }) {
    if (!_cameraController.value.isStreamingImages) {
      return;
    }

    final MediaQueryData _mq = MediaQuery.of(context);
    final _searchBoxSize = Size(320, 144);
    final double maxLogicalHeight =
        _mq.size.height - _mq.padding.top - _mq.padding.bottom;

    final double imageHeight = defaultTargetPlatform == TargetPlatform.iOS
        ? imageSize.height
        : imageSize.width;

    final double imageScale = imageHeight / maxLogicalHeight;
    final double halfWidth = imageScale * _searchBoxSize.width / 2;
    final double halfHeight = imageScale * _searchBoxSize.height / 2;

    final Offset center = imageSize.center(Offset.zero);

    final Rect validRect = Rect.fromLTRB(
      center.dx - halfWidth * 1.5,
      center.dy - halfHeight * 0.5,
      center.dx + halfWidth,
      center.dy + halfHeight,
    );

    for (Barcode barcode in barcodes) {
      final Rect intersection = validRect.intersect(barcode.boundingBox);
      final bool doesContain = intersection == barcode.boundingBox;

      setState(() {
        _validRect = validRect;
        _intersectionRect = intersection;
        _barcodeBoundingBox = barcode.boundingBox;
      });

      // if (doesContain) {
      //   print('!!!!! RESULT: ' + barcode.rawValue);
      //   _cameraController.stopImageStream().then(
      //     (_) {
      //       _cameraController.dispose();
      //       final Widget _discountDetailsPage =
      //           DiscountDetailsPage(canPop: false);
      //       Navigator.push(
      //         context,
      //         PageRouteBuilder(
      //             transitionDuration: Duration(seconds: 3),
      //             pageBuilder: (context, animation, secondaryAnimation) =>
      //                 _discountDetailsPage),
      //       );
      //     },
      //   );
      // }

    }
  }

  double _getImageZoom(MediaQueryData data) {
    final double logicalWidth = data.size.width;
    final double logicalHeight = _previewSize.aspectRatio * logicalWidth;

    final EdgeInsets padding = data.padding;
    final double maxLogicalHeight =
        data.size.height - padding.top - padding.bottom;

    return maxLogicalHeight / logicalHeight;
  }

  @override
  Widget build(BuildContext context) {
    print('-->CameraPage');
    if (_cameraController != null && _cameraController.value.isInitialized) {
      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(_appBarHeight),
            child: AppBar(
              leading: CustomFlatButton(
                icon: svgLeftArrow,
                onPressed: () {
                  _cameraController
                      .stopImageStream()
                      .then((_) => Navigator.pop(context));
                },
              ),
              title: Text(
                'Добавить карту',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: _appBarHeight * 0.38,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              actions: [
                CustomFlatButton(
                  icon: Icon(
                    Icons.wb_sunny_outlined,
                    color: cPink,
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              Container(
                child: Transform.scale(
                  scale: _getImageZoom(MediaQuery.of(context)),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: _cameraController.value.aspectRatio,
                      child: CameraPreview(_cameraController),
                    ),
                  ),
                ),
              ),
              Center(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      constraints: const BoxConstraints.expand(),
                      child: CustomPaint(
                        painter: WindowPainter(
                          windowSize: Size(
                            constraints.maxWidth * 0.95,
                            constraints.maxHeight * 0.35,
                          ),
                          backgroundColor: Colors.black54,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: _hor,
                right: _hor,
                top: _vert,
                child: Text(
                  'Отсканируйте штрих-код вашей карты.\nДержите штрих-код в кадре, чтобы просканировать его.',
                  textAlign: TextAlign.center,
                  style: style2(context).copyWith(color: Colors.white),
                ),
              ),
              Center(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      width: constraints.maxWidth * 0.95,
                      height: constraints.maxHeight * 0.35,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: CustomPaint(
                  painter: BarcodeRect(
                    barcodeRect: _validRect,
                    color: const Color(0xFF0099FF),
                  ),
                ),
              ),
              Center(
                child: CustomPaint(
                  painter: BarcodeRect(
                      barcodeRect: _barcodeBoundingBox,
                      color: const Color(0xFF66BB6A)),
                ),
              ),
              Center(
                child: CustomPaint(
                  painter: BarcodeRect(
                      barcodeRect: _intersectionRect,
                      color: const Color(0xFFCFD8DC)),
                ),
              ),
              Positioned(
                left: _hor * 3,
                right: _hor * 3,
                bottom: _vert,
                child: GestureDetector(
                  onTap: () {
                    _cameraController.stopImageStream().then((_) {
                      _cameraController.dispose();
                      final Widget _discountCalculatorPage =
                          DiscountCalculatorPage();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(seconds: 0),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  _discountCalculatorPage,
                        ),
                      );
                    });
                  },
                  child: CustomButton(
                    onTap: () {},
                    text: 'Ввести вручную',
                    color: Colors.transparent,
                    textColor: Colors.white,
                    borderColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }
}

class BarcodeRect extends CustomPainter {
  final Rect barcodeRect;
  final Color color;

  BarcodeRect({
    @required this.barcodeRect,
    @required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTRB(
        barcodeRect.left,
        barcodeRect.top,
        barcodeRect.right,
        barcodeRect.bottom,
      ),
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(BarcodeRect oldDelegate) {
    return true;
  }
}

class WindowPainter extends CustomPainter {
  WindowPainter({
    @required this.windowSize,
    @required this.backgroundColor,
  });

  final Size windowSize;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double windowHalfWidth = windowSize.width / 2;
    final double windowHalfHeight = windowSize.height / 2;

    final Rect windowRect = Rect.fromLTRB(
      center.dx - windowHalfWidth,
      center.dy - windowHalfHeight,
      center.dx + windowHalfWidth,
      center.dy + windowHalfHeight,
    );

    final Rect left =
        Rect.fromLTRB(0, windowRect.top, windowRect.left, windowRect.bottom);
    final Rect top = Rect.fromLTRB(0, 0, size.width, windowRect.top);
    final Rect right = Rect.fromLTRB(
      windowRect.right,
      windowRect.top,
      size.width,
      windowRect.bottom,
    );
    final Rect bottom = Rect.fromLTRB(
      0,
      windowRect.bottom,
      size.width,
      size.height,
    );

    final Paint paint = Paint()..color = backgroundColor;
    canvas.drawRect(left, paint);
    canvas.drawRect(top, paint);
    canvas.drawRect(right, paint);
    canvas.drawRect(bottom, paint);
  }

  @override
  bool shouldRepaint(WindowPainter oldDelegate) => true;
}
