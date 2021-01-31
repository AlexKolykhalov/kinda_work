import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';

// TODO refactoring
class RateBadge extends StatelessWidget {
  const RateBadge({
    Key key,
    @required this.rate,
    this.textColor,
  }) : super(key: key);

  final num rate;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    print('-->RateBadge');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: rate == 0.0 ? Colors.grey[600] : textColor,
          size: size(context, 0.02),
        ),
        SizedBox(width: size(context, 0.005)),
        (rate == 0.0)
            ? Text(
                'Нет оценок',
                style: style3(context).copyWith(
                  color: Colors.grey[600],
                ),
              )
            : Text(
                rate.toStringAsFixed(rate.truncateToDouble() == rate ? 0 : 1),
                style: style3(context).copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );
  }
}

class MessagesBadge extends StatelessWidget {
  const MessagesBadge({
    Key key,
    @required this.countMessages,
  }) : super(key: key);

  final int countMessages;

  @override
  Widget build(BuildContext context) {
    print('-->MessagesBadge');
    return Visibility(
      visible: countMessages > 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            countMessages.toString(),
            style: style4(context).copyWith(
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: size(context, 0.008)),
          SvgPicture.asset(
            'assets/svg/chat.svg',
            width: size(context, 0.02),
            height: size(context, 0.02),
          )
        ],
      ),
    );
  }
}

class FavoriteBadge extends StatelessWidget {
  const FavoriteBadge({
    Key key,
    this.favorite,
  }) : super(key: key);

  final bool favorite;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(context, 0.035),
      height: size(context, 0.035),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Center(
        child: Icon(
          favorite ? Icons.favorite : Icons.favorite_border,
          color: cPink,
          size: size(context, 0.022),
        ),
      ),
    );
  }
}

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({
    Key key,
    @required this.discount,
  }) : super(key: key);

  final int discount;

  @override
  Widget build(BuildContext context) {
    print('-->DiscountBadge');
    return Visibility(
      visible: discount > 0,
      child: Container(
        width: size(context, 0.07),
        height: size(context, 0.033),
        decoration: BoxDecoration(
          color: cPink,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Text(
                '-${discount.toString()}%',
                style: TextStyle(
                  fontSize: constraints.maxHeight * 0.65,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TextBadge extends StatelessWidget {
  const TextBadge({
    Key key,
    @required this.text,
    @required this.textColor,
    @required this.backgroundColor,
  }) : super(key: key);

  final String text;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(size(context, 0.0065)),
        child: Text(
          text,
          style: style4(context).copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
