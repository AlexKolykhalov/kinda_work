import 'package:flutter/material.dart';

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
  bool shouldRepaint(BarcodeRect oldDelegate) => true;
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

    final Rect left = Rect.fromLTRB(
      0,
      windowRect.top,
      windowRect.left,
      windowRect.bottom,
    );

    final Rect top = Rect.fromLTRB(
      0,
      0,
      size.width,
      windowRect.top,
    );

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
