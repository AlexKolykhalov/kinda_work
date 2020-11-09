import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/promo/BLoC/bottom_appbar_switcher_cubit.dart';

class CustomBottomAppBar1 extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomBottomAppBar1({
    Key key,
    @required this.preferredSize,
    @required this.tabController,
    @required this.bottomData,
  }) : super(key: key);

  final Size preferredSize;
  final TabController tabController;
  final List<String> bottomData;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: TabBar(
          isScrollable: true,
          controller: tabController,
          labelColor: cPink,
          indicatorColor: cPink,
          unselectedLabelColor: Colors.grey[600],
          tabs: bottomData.map((e) => Tab(text: e)).toList(),
        ),
      ),
      preferredSize: preferredSize,
    );
  }
}

class CustomBottomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomBottomAppBar({
    Key key,
    @required this.size,
    @required this.bottomListViewData,
    @required this.preferredSize,
  }) : super(key: key);

  final Size size;
  final List<String> bottomListViewData;
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SwitcherBottomAppBarCubit(),
      child: BlocBuilder<SwitcherBottomAppBarCubit, int>(
        builder: (context, selectedElement) {
          return PreferredSize(
            child: Container(
              height: size.height * 0.065,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () =>
                      BlocProvider.of<SwitcherBottomAppBarCubit>(context)
                          .changed(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: (selectedElement == index)
                          ? Border(
                              bottom: BorderSide(
                                color: cPink,
                                width: 5.0,
                              ),
                            )
                          : null,
                    ),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bottomListViewData[index],
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color:
                              (selectedElement == index) ? cPink : Colors.grey,
                        ),
                      ),
                    )),
                  ),
                ),
                itemCount: bottomListViewData.length,
              ),
            ),
            preferredSize: preferredSize,
          );
        },
      ),
    );
  }
}
