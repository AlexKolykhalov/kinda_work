import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:kinda_work/styles.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    Key key,
    this.images = const [],
    this.height,
  })  : assert(images.length == 4),
        super(key: key);

  final List<Image> images;
  final double height;

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  int _currentSlider;
  Size _size;

  @override
  void initState() {
    super.initState();
    _currentSlider = 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.images,
          options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            height: widget.height,
            autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentSlider = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: _size.height * 0.02,
          left: _size.width / 3,
          child: Container(
            width: _size.width * 0.25,
            height: _size.height * 0.025,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentSlider == 0 ? FilledCircle() : UnfilledCircle(),
                _currentSlider == 1 ? FilledCircle() : UnfilledCircle(),
                _currentSlider == 2 ? FilledCircle() : UnfilledCircle(),
                _currentSlider == 3 ? FilledCircle() : UnfilledCircle(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class FilledCircle extends StatelessWidget {
  const FilledCircle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context, 0.02),
      height: size(context, 0.02),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}

class UnfilledCircle extends StatelessWidget {
  const UnfilledCircle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context, 0.015),
      height: size(context, 0.015),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2, color: Colors.white),
        color: Colors.transparent,
      ),
    );
  }
}
