import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/widgets.dart';

class VisitHistoryPage extends StatelessWidget {
  const VisitHistoryPage({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    List historyVisits = [
      {
        'date': '21.06.17',
        'phone': '+375 (940) 677-60-91',
        'price': '3500 Br',
        'name': 'Роман Красновский',
        'discount': '10%',
      },
      {
        'date': '21.06.17',
        'phone': '+375 (940) 677-60-91',
        'price': '500 Br',
        'name': 'Роман Красновский',
        'discount': '2%',
      },
      {
        'date': '22.06.17',
        'phone': '+375 (940) 677-60-91',
        'price': '3000 Br',
        'name': 'Роман Красновский',
        'discount': '13%',
      },
      {
        'date': '23.06.17',
        'phone': '+375 (940) 677-60-91',
        'price': '100 Br',
        'name': 'Роман Красновский',
        'discount': '1%',
      },
      {
        'date': '24.06.17',
        'phone': '+375 (940) 677-60-91',
        'price': '5500 Br',
        'name': 'Роман Красновский',
        'discount': '50%',
      },
    ];

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          size: size,
          title: 'История посещений',
          showActions: false,
        ),
        body: Container(
          padding: EdgeInsets.only(top: size.height * cVertical),
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                (index < historyVisits.length - 1)
                    ? Padding(
                        padding: EdgeInsets.only(left: size.width * cHorizont),
                        child: Divider(thickness: 1),
                      )
                    : Divider(thickness: 1),
            itemCount: historyVisits.length + 1,
            itemBuilder: (context, index) => (index < historyVisits.length)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * cHorizont),
                        child: Text(historyVisits[index]['date'],
                            style: TextStyle(color: Colors.grey[600])),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * cHorizont),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(historyVisits[index]['phone'],
                                style: TextStyle(fontSize: 15.0)),
                            Text(historyVisits[index]['price'],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * cHorizont),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(historyVisits[index]['name'],
                                style: TextStyle(fontSize: 15.0)),
                            Text(
                              historyVisits[index]['discount'],
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Container(),
          ),
        ),
      ),
    );
  }
}
