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
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'История посещений',
        ),
        body: Container(
          padding: EdgeInsets.only(top: size(context, vert)),
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                (index < historyVisits.length - 1)
                    ? Divider(thickness: 1.0, indent: size(context, hor))
                    : Divider(thickness: 1.0),
            itemCount: historyVisits.length + 1,
            itemBuilder: (context, index) => (index < historyVisits.length)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size(context, hor)),
                        child: Text(
                          historyVisits[index]['date'],
                          style:
                              style4(context).copyWith(color: Colors.grey[600]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(historyVisits[index]['phone'],
                                style: style3(context)),
                            Text(
                              historyVisits[index]['price'],
                              style: style3(context).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                                style: style3(context)),
                            Text(
                              historyVisits[index]['discount'],
                              style: style3(context).copyWith(
                                color: Colors.green,
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
