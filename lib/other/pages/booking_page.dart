import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/booking_page_details.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/styles.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->BookingPage');
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Бронирование',
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: size(context, vert)),
          child: ListView.builder(
            itemBuilder: (context, index) => Column(
              children: [
                BookingListViewElement(booking: bookingData[index]),
                Divider(
                  height: size(context, vert),
                  thickness: 1.0,
                  indent: size(context, hor),
                )
              ],
            ),
            itemCount: bookingData.length,
          ),
        ),
      ),
    );
  }
}

class BookingListViewElement extends StatelessWidget {
  const BookingListViewElement({
    Key key,
    @required this.booking,
  }) : super(key: key);

  final Map booking;

  @override
  Widget build(BuildContext context) {
    final double _h = size(context, 0.015);
    final double _hor = size(context, hor);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _hor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking['date'],
                style: style4(context).copyWith(
                  color: Colors.grey[600],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: _hor / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(booking['name'], style: style2(context)),
                    Text(booking['booking_date'], style: style2(context)),
                  ],
                ),
              ),
              booking['status'] == 0
                  ? Text(
                      'На рассмотрении',
                      style: style3(context).copyWith(
                        color: Colors.grey[600],
                      ),
                    )
                  : Text(
                      'Подтверждено',
                      style: style3(context).copyWith(color: Colors.green),
                    )
            ],
          ),
          Row(
            children: [
              Container(
                width: _h,
                height: _h,
                decoration: BoxDecoration(
                  color: booking['unseen'] ? cPink : Colors.transparent,
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              CustomRedRightArrow(
                onPressed: () {
                  final Widget _bookingPageDetails =
                      BookingPageDetails(booking: booking);
                  return Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(seconds: 0),
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          _bookingPageDetails,
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
