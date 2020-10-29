import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';

class StorePromotionSlider extends StatefulWidget {
  const StorePromotionSlider({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  _StorePromotionSliderState createState() => _StorePromotionSliderState();
}

class _StorePromotionSliderState extends State<StorePromotionSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.size.width * cHorizont),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Stack(
          children: [
            CarouselSlider(
              items: [
                Image.asset('assets/png/slider/slider1.png', fit: BoxFit.cover),
                Image.asset('assets/png/slider/slider2.png', fit: BoxFit.cover),
                Image.asset('assets/png/slider/slider3.png', fit: BoxFit.cover),
                Image.asset('assets/png/slider/slider4.png', fit: BoxFit.cover),
              ],
              options: CarouselOptions(
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Positioned(
              bottom: widget.size.height * 0.02,
              left: widget.size.width / 3,
              child: Container(
                width: widget.size.width * 0.25,
                height: widget.size.height * 0.025,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (_current == 0)
                        ? FilledCircle(size: widget.size)
                        : UnfilledCircle(size: widget.size),
                    (_current == 1)
                        ? FilledCircle(size: widget.size)
                        : UnfilledCircle(size: widget.size),
                    (_current == 2)
                        ? FilledCircle(size: widget.size)
                        : UnfilledCircle(size: widget.size),
                    (_current == 3)
                        ? FilledCircle(size: widget.size)
                        : UnfilledCircle(size: widget.size),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilledCircle extends StatelessWidget {
  const FilledCircle({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.height * 0.02,
      height: size.height * 0.02,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.white,
      ),
    );
  }
}

class UnfilledCircle extends StatelessWidget {
  const UnfilledCircle({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.height * 0.015,
      height: size.height * 0.015,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(width: 2, color: Colors.white),
        color: Colors.transparent,
      ),
    );
  }
}
