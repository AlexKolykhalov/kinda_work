import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:kinda_work/cards/pages/notes_page.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/styles.dart';

class EditCardPage extends StatelessWidget {
  const EditCardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Карты',
          actions: [
            CustomFlatButton(
              icon: Icon(
                Icons.more_horiz,
                color: cPink,
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size(context, 0.4),
              padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
              margin: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
              color: Colors.redAccent[700],
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: constraints.maxHeight * 0.2,
                        child: svgLogoAuchan,
                      ),
                      BarcodeWidget(
                        height: constraints.maxHeight * 0.7,
                        padding: EdgeInsets.all(_hor),
                        barcode: Barcode.code128(),
                        data: '0232229565613578',
                        style: TextStyle(fontSize: _hor * 2),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: _vert),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: _hor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Заметки',
                          style: style2(context)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        CustomRedRightArrow(
                          onPressed: () {
                            final Widget _notesPage = NotesPage();
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(seconds: 1),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        _notesPage,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1.0, indent: _hor),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: _hor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Изображения',
                          style: style2(context)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        CustomRedRightArrow(
                          onPressed: () => displayCardImages(context),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
