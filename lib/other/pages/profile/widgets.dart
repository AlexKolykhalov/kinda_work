import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/badges.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/styles.dart';

class ColumnElementGeneral extends StatelessWidget {
  const ColumnElementGeneral({
    Key key,
    @required this.element,
    @required this.visitTime,
    this.discountMoney = 0,
    this.discountPoints = 0,
    this.showArrow = true,
    this.showAdress = true,
  }) : super(key: key);

  final element;
  final String visitTime;
  final int discountMoney;
  final int discountPoints;
  final bool showArrow;
  final bool showAdress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size(context, 0.065),
              height: size(context, 0.065),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(element.img),
                ),
              ),
            ),
            SizedBox(width: size(context, 0.015)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size(context, 0.008)),
                    child: Text(
                      element.type,
                      style: style4(context).copyWith(color: Colors.grey[600]),
                    ),
                  ),
                  Text(
                    element is Company ? element.name : element.description,
                    style: style2(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: size(context, 0.008)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: showAdress,
                          child: Text(
                            element is Company
                                ? element.adress
                                : element.company.adress,
                            style: style4(context),
                          ),
                        ),
                        Text(
                          visitTime,
                          style: style4(context),
                        ),
                        Visibility(
                          visible: discountMoney != 0 && discountPoints != 0,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${discountMoney.toString()} р. ',
                                  style: style4(context).copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: '(${discountPoints.toString()} баллов)',
                                  style: style4(context).copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: showArrow,
              child: CustomRedRightArrow(onPressed: () => null),
            )
          ],
        ),
      ],
    );
  }
}

class ColumnElementProfileReviews extends StatelessWidget {
  const ColumnElementProfileReviews({
    Key key,
    @required this.review,
  }) : super(key: key);

  final Review review;

  _getStatusTextBadge() {
    if (review.reviewStatus == ReviewStatus.moderation) {
      return TextBadge(
        text: 'Модерация',
        textColor: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.75),
      );
    }
    if (review.reviewStatus == ReviewStatus.apply) {
      return TextBadge(
        text: '${review.reviewPoints} баллов',
        textColor: Colors.white,
        backgroundColor: cPink,
      );
    }
    if (review.reviewStatus == ReviewStatus.deny) {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    final double _offset = size(context, 0.01);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _hor,
        vertical: _vert,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.objectReview.type,
                style: style4(context).copyWith(
                  color: Colors.grey[600],
                ),
              ),
              _getStatusTextBadge(),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: _offset),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.objectReview is Company
                      ? review.objectReview.name
                      : review.objectReview.description,
                  style: style1(context).copyWith(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size(context, 0.008)),
                  child: Text(
                    '(посещение 20 сентября 2016)',
                    style: style4(context).copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(review.text, style: style2(context)),
          SizedBox(height: _hor),
          review.objectReview is Promotion
              ? Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size(context, 0.01),
                        vertical: size(context, 0.006),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: RateBadge(
                        rate: review.objectReview.rate,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                )
              : QualityRatingScale(
                  service: review.service,
                  kitchen: review.kitchen,
                  priceQualityRatio: review.priceQuality,
                  ambiance: review.ambiance,
                ),
          review.managerResponse != null
              ? Column(
                  children: [
                    SizedBox(height: _hor),
                    ManagerResponse(response: review.managerResponse),
                  ],
                )
              : Container(),
          review.moderatorResponse != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: _hor),
                    Text(
                      'Отказано в доступе',
                      style: style3(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: cPink,
                      ),
                    ),
                    SizedBox(height: _offset),
                    Text(
                      review.moderatorResponse,
                      style: style4(context),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
