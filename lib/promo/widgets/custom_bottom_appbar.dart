import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';

class CustomBottomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomBottomAppBar({
    Key key,
    @required this.preferredSize,
    @required this.tabController,
    @required this.bottomData,
    @required this.isScrollable,
  }) : super(key: key);

  final Size preferredSize;
  final TabController tabController;
  final List<String> bottomData;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    print('-->CustomBottomAppBar');
    return PreferredSize(
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          height: preferredSize.height - (preferredSize.height * (1 / 1.7)),
          child: TabBar(
            isScrollable: isScrollable,
            controller: tabController,
            labelPadding: EdgeInsets.zero,
            labelColor: cPink,
            indicatorColor: cPink,
            unselectedLabelColor: Colors.grey[600],
            tabs: bottomData
                .map(
                  (e) => Tab(
                    child: Text(
                      e,
                      style: style3(context),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      preferredSize: preferredSize,
    );
  }
}
