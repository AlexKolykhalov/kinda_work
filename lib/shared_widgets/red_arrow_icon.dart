import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';

class CustomArrow extends StatelessWidget {
  const CustomArrow({
    Key key,
    @required this.onPressed,
    @required this.icon,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: BoxConstraints(
        minWidth: size(context, 0.055),
        minHeight: size(context, 0.055),
      ),
      padding: EdgeInsets.zero,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: onPressed,
      icon: Align(
        alignment: Alignment.centerRight,
        child: Icon(
          icon,
          color: cPink,
          size: size(context, 0.035),
        ),
      ),
    );
  }
}

class CustomRedRightArrow extends StatelessWidget {
  const CustomRedRightArrow({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomArrow(
      onPressed: onPressed,
      icon: Icons.keyboard_arrow_right,
    );
  }
}

class CustomRedUpArrow extends StatelessWidget {
  const CustomRedUpArrow({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomArrow(
      onPressed: onPressed,
      icon: Icons.keyboard_arrow_up,
    );
  }
}

class CustomRedDownArrow extends StatelessWidget {
  const CustomRedDownArrow({
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomArrow(
      onPressed: onPressed,
      icon: Icons.keyboard_arrow_down,
    );
  }
}
