import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Scaffold(
      appBar: CustomAppBar(
        height: appBarHeight(context),
        title: 'Заметки',
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
        child: Column(
          children: [
            CustomTextField(
              minLines: 10,
              maxLines: 10,
            ),
            Flexible(child: Container()),
            CustomButton(
              onTap: () => null,
              text: 'Сохранить заметку',
              color: cPink,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
