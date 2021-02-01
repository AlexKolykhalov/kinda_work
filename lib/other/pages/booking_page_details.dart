import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/styles.dart';

class BookingPageDetails extends StatelessWidget {
  const BookingPageDetails({
    Key key,
    @required this.booking,
  }) : super(key: key);

  final Map booking;

  @override
  Widget build(BuildContext context) {
    print('-->BookingPageDetails');
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    final TextStyle _style2 = style2(context);
    final TextStyle _style3 = style3(context);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Бронирование',
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: _vert),
              child: SearchCompany(element: booking['company']),
            ),
            Divider(thickness: 1.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'На чье имя',
                    style: _style3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _hor),
                  Text(booking['name'], style: _style2),
                  Text(booking['phone'], style: _style2),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: _vert),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Дата и время',
                          style: _style3.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: _hor),
                        Text(booking['booking_date'], style: _style2),
                      ],
                    ),
                  ),
                  Text(
                    'Бронь',
                    style: _style3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: _hor),
                  Text(booking['booking_details'], style: _style2),
                ],
              ),
            ),
            Expanded(child: Container()),
            CustomButton(
              margin: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
              onTap: null,
              text: 'Подтвердить бронь/запись',
              color: cPink,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
