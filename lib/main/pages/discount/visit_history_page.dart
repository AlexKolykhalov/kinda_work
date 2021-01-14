import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class VisitHistoryPage extends StatelessWidget {
  const VisitHistoryPage({
    Key key,
    @required this.historyVisits,
  }) : super(key: key);

  final List historyVisits;

  @override
  Widget build(BuildContext context) {
    print('-->VisitHistoryPage');
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'История посещений',
        ),
        body: Container(
          padding: EdgeInsets.only(top: _size.height * vert),
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                (index < historyVisits.length - 1)
                    ? Divider(thickness: 1, indent: size(context, hor))
                    : Divider(thickness: 1),
            itemCount: historyVisits.length + 1,
            itemBuilder: (context, index) => (index < historyVisits.length)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size(context, hor)),
                        child: Text(historyVisits[index]['date'],
                            style: TextStyle(color: Colors.grey[600])),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
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
                            horizontal: size(context, hor)),
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
