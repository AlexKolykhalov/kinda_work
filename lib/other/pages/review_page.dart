import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/profile/profile_page.dart';
import 'package:kinda_work/other/thanks_for_review.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/shared_widgets.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Ваш отзыв'),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: size(context, hor), vertical: size(context, vert)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                PlaceName(),
                ReviewText(),
                ReviewRating(),
              ]),
              CustomButton(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ThanksForReviewPage(),
                  ),
                ),
                buttonText: 'Оставить отзыв +110 баллов',
                buttonColor: cPink,
                buttonTextColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceName extends StatelessWidget {
  const PlaceName({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: size(context, vert)),
      child: ColumnElementGeneral(
        img: 'assets/png/grid/1.png',
        type: 'Ресторан',
        name: 'Джомалунгма',
        visitTime: '(посещение 20 сентября 2016)',
        showArrow: false,
      ),
    );
  }
}

class ReviewText extends StatelessWidget {
  const ReviewText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Текст отзыва',
            hintStyle: style1(context),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none,
            ),
          ),
          maxLines: 4,
          style: style1(context),
        ),
        SizedBox(height: size(context, 0.02)),
        Text(
          'Количество символов в поле "Отзыв" должно быть не менее 50 символов',
          style: style2(context).copyWith(color: cPink),
        )
      ],
    );
  }
}

class ReviewRating extends StatelessWidget {
  const ReviewRating({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: size(context, vert)),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                RatingPoint(
                  title: 'Обслуживание',
                  icon: cService,
                  point: 0,
                ),
                RatingPoint(
                  title: 'Кухня',
                  icon: cKitchen,
                  point: 1,
                )
              ]),
              SizedBox(height: size(context, 0.015)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                RatingPoint(
                  title: 'Цена/Качество',
                  icon: cPriceQuality,
                  point: 2,
                ),
                RatingPoint(
                  title: 'Атмосфера',
                  icon: cAmbiance,
                  point: 3,
                )
              ]),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Общая оценка:',
            style: style1(context),
          ),
          RateBadge(
            rate: 4.2,
            textColor: Colors.green,
          )
        ]),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 20.0, height: 20.0, child: icon),
            SizedBox(width: size(context, 0.01)),
            Text(
              title,
              style: style2(context).copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            point > 0
                ? Icon(
                    Icons.star,
                    color: Colors.green,
                    size: size(context, 0.04),
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey[600],
                    size: size(context, 0.04),
                  ),
            point > 1
                ? Icon(
                    Icons.star,
                    color: Colors.green,
                    size: size(context, 0.04),
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey[600],
                    size: size(context, 0.04),
                  ),
            point > 2
                ? Icon(
                    Icons.star,
                    color: Colors.green,
                    size: size(context, 0.04),
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey[600],
                    size: size(context, 0.04),
                  ),
            point > 3
                ? Icon(
                    Icons.star,
                    color: Colors.green,
                    size: size(context, 0.04),
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey[600],
                    size: size(context, 0.04),
                  ),
            point > 4
                ? Icon(
                    Icons.star,
                    color: Colors.green,
                    size: size(context, 0.04),
                  )
                : Icon(
                    Icons.star_border,
                    color: Colors.grey[600],
                    size: size(context, 0.04),
                  ),
          ],
        ),
      ],
    );
  }
}
