import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/booking_page_details.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets.dart';
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
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * vert),
            child: ListView.separated(
              itemBuilder: (context, index) => BookingListViewElement(
                booking: bookingData[index],
              ),
              separatorBuilder: (context, index) => Divider(
                thickness: 1.0,
                indent: MediaQuery.of(context).size.width * hor,
              ),
              itemCount: bookingData.length,
            )),
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
    Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(booking['date'], style: TextStyle(color: Colors.grey[600])),
              Text(booking['name'], style: TextStyle(fontSize: 15.0)),
              Text(booking['booking_date'], style: TextStyle(fontSize: 15.0)),
              SizedBox(height: 5.0),
              booking['status'] == 0
                  ? Text('На рассмотрении',
                      style: TextStyle(color: Colors.grey[600]))
                  : Text('Подтверждено', style: TextStyle(color: Colors.green))
            ],
          ),
          Row(
            children: [
              Container(
                width: _size.height * 0.015,
                height: _size.height * 0.015,
                decoration: BoxDecoration(
                    color: booking['unseen'] ? cPink : Colors.transparent,
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        BookingPageDetails(booking: booking),
                  ),
                ),
                icon: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.keyboard_arrow_right, color: cPink),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
