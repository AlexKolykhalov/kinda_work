import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/shared_widgets.dart';
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
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Бронирование',
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size(context, hor),
                        vertical: size(context, vert),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: _size.height * 0.1,
                                height: _size.height * 0.1,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(booking['company'].img),
                                  ),
                                ),
                              ),
                              SizedBox(width: _size.width * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: _size.height * 0.01),
                                      child: customRichText(
                                          booking['company'].name, _size)),
                                  Text(
                                    booking['company'].type,
                                    style: TextStyle(
                                      fontSize: _size.height * 0.02,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    booking['company'].adress,
                                    style: TextStyle(
                                      fontSize: _size.height * 0.02,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RateBadge(
                                  rate: booking['company'].rate,
                                  textColor: Colors.green),
                              SizedBox(width: _size.width * 0.05),
                              GestureDetector(
                                onTap: () => null,
                                child: Icon(
                                  Icons.chevron_right,
                                  color: cPink,
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                  Divider(thickness: 1.0),
                  Container(
                    width: _size.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: size(context, hor),
                      vertical: size(context, vert),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'На чье имя',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(booking['name'], style: TextStyle(fontSize: 15.0)),
                        Text(booking['phone'],
                            style: TextStyle(fontSize: 15.0)),
                        SizedBox(height: 20.0),
                        Text(
                          'Дата и время',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(booking['booking_date'],
                            style: TextStyle(fontSize: 15.0)),
                        SizedBox(height: 20.0),
                        Text(
                          'Бронь',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(booking['booking_details'],
                            style: TextStyle(fontSize: 15.0)),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size(context, hor),
                  vertical: size(context, vert),
                ),
                child: CustomButton(
                  onTap: null,
                  buttonText: 'Подтвердить бронь/запись',
                  buttonColor: cPink,
                  buttonTextColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
