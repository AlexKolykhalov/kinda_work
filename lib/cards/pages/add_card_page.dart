import 'package:flutter/material.dart';
import 'package:kinda_work/cards/pages/add_manually_card_page.dart';
import 'package:kinda_work/cards/widgets.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/styles.dart';

class AddCardPage extends StatelessWidget {
  const AddCardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('***AddCardPage***');
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Scaffold(
      appBar: CustomAppBar(
        height: appBarHeight(context),
        title: 'Добавить карту',
        actions: [
          CustomFlatButton(icon: svgSearchIcon),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: _vert),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColumnElementWidget(),
              SizedBox(height: _vert),
              Divider(thickness: 1.0, height: 0.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _hor,
                  vertical: _vert,
                ),
                child: Text(
                  'Часто добавляются',
                  style: style3(context).copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                children: cards
                    .asMap()
                    .entries
                    .map(
                      (entry) => Column(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(vertical: _vert),
                              child: ColumnElementWidget()),
                          Visibility(
                            visible: entry.key != cards.length - 1,
                            child: Divider(
                              thickness: 1.0,
                              height: 0.0,
                              indent: _hor,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              Divider(thickness: 1.0, height: 0.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _hor,
                  vertical: _vert,
                ),
                child: Text(
                  'А',
                  style: style3(context).copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnElementWidget extends StatelessWidget {
  const ColumnElementWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _hor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CardIconWidget(),
              SizedBox(width: _hor),
              Text(
                'Другая карта',
                style: style2(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          CustomRedRightArrow(
            onPressed: () {
              // final Widget _cameraPage = CameraPage();
              final Widget _addManuallyCardPage = AddManuallyCardPage();
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      _addManuallyCardPage,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
