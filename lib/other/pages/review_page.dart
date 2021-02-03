import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/other/pages/profile/widgets.dart';
import 'package:kinda_work/other/thanks_for_review.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/badges.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({
    Key key,
    @required this.company,
  }) : super(key: key);

  final Company company;

  @override
  Widget build(BuildContext context) {
    print('-->ReviewPage');
    final MediaQueryData _mq = MediaQuery.of(context);
    final double _height = _mq.size.height -
        _mq.padding.top -
        appBarHeight(context) -
        bottomAppHeight;
    final double _hor = _mq.size.height * hor;
    final double _vert = _mq.size.height * vert;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Ваш отзыв',
        ),
        body: SingleChildScrollView(
          child: Container(
            height: _height,
            padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  ColumnElementGeneral(
                    element: company,
                    visitTime: '(посещение 20 сентября 2016)',
                    showAdress: false,
                    showArrow: false,
                  ),
                  ReviewText(),
                  ReviewRating(),
                ]),
                CustomButton(
                  onTap: () {
                    final Widget _thanks = ThanksForReviewPage();
                    return Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            _thanks,
                      ),
                    );
                  },
                  text: 'Оставить отзыв +110 баллов',
                  color: cPink,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewText extends StatelessWidget {
  const ReviewText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->ReviewText');
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: size(context, hor)),
          child: CustomTextField(
            hintText: 'Текст отзыва',
            isMultiLines: true,
          ),
        ),
        Text(
          'Количество символов в поле "Отзыв" должно быть не менее 50 символов',
          style: style3(context).copyWith(color: cPink),
        )
      ],
    );
  }
}

class ReviewRating extends StatelessWidget {
  const ReviewRating({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->ReviewRating');
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: size(context, hor)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingPoint(
                    title: 'Обслуживание',
                    icon: svgService,
                    point: 0,
                  ),
                  RatingPoint(
                    title: 'Кухня',
                    icon: svgKitchen,
                    point: 1,
                  )
                ],
              ),
              SizedBox(height: size(context, 0.015)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                RatingPoint(
                    title: 'Цена/Качество', icon: svgPriceQuality, point: 2),
                RatingPoint(
                  title: 'Атмосфера',
                  icon: svgAmbiance,
                  point: 3,
                )
              ]),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Общая оценка:',
              style: style2(context),
            ),
            RateBadge(
              rate: 4.2,
              textColor: Colors.green,
            )
          ],
        ),
      ],
    );
  }
}

class RatingPoint extends StatelessWidget {
  const RatingPoint({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.point,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final int point;

  @override
  Widget build(BuildContext context) {
    print('-->RatingPoint');
    final double _heightIcon = size(context, 0.025);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: _heightIcon, height: _heightIcon, child: icon),
            SizedBox(width: size(context, 0.01)),
            Text(
              title,
              style: style3(context).copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: _heightIcon / 3.5),
        Row(
          children: [
            point > 0 ? FilledStar() : UnfilledStar(),
            point > 1 ? FilledStar() : UnfilledStar(),
            point > 2 ? FilledStar() : UnfilledStar(),
            point > 3 ? FilledStar() : UnfilledStar(),
            point > 4 ? FilledStar() : UnfilledStar(),
          ],
        ),
      ],
    );
  }
}

class FilledStar extends StatelessWidget {
  const FilledStar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _heightStar = size(context, 0.035);
    return Container(
      child: Icon(
        Icons.star,
        color: Colors.green,
        size: _heightStar,
      ),
    );
  }
}

class UnfilledStar extends StatelessWidget {
  const UnfilledStar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _heightStar = size(context, 0.035);
    return Container(
      child: Icon(
        Icons.star_border,
        color: Colors.grey[600],
        size: _heightStar,
      ),
    );
  }
}
