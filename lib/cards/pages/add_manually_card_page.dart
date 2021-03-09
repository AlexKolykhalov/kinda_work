import 'package:flutter/material.dart';
import 'package:kinda_work/cards/pages/edit_card_page.dart';
import 'package:kinda_work/cards/widgets.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/repository.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class AddManuallyCardPage extends StatelessWidget {
  const AddManuallyCardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('***AddManuallyCardPage***');
    final MediaQueryData _mq = MediaQuery.of(context);
    final double _hor = _mq.size.height * hor;
    final double _vert = _mq.size.height * vert;
    final double _h = _mq.size.height - _mq.padding.top - appBarHeight(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Добавить карту',
        ),
        body: SingleChildScrollView(
          child: Container(
            height: _mq.viewInsets.bottom > 0.0 ? _h * 0.65 : _h,
            child: Column(
              children: [
                Container(
                  height: _h * 0.2,
                  child: BannerWidget(),
                ),
                Flexible(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
                    child: Column(
                      children: [
                        BarcodeTextField(),
                        SizedBox(height: _hor),
                        CustomTextField(
                          hintText: 'Название',
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: _hor),
                        Visibility(
                          visible: true,
                          child: Column(
                            children: [
                              Row(
                                children: cards
                                    .asMap()
                                    .entries
                                    .map(
                                      (entry) => Row(
                                        children: [
                                          CardIconWidget(),
                                          Visibility(
                                            visible:
                                                entry.key != cards.length - 1,
                                            child: SizedBox(width: _hor),
                                          )
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                              SizedBox(height: _hor),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                onTap: () => null,
                                text: 'Отмена',
                                color: Colors.white,
                                textColor: Colors.grey[600],
                              ),
                            ),
                            SizedBox(width: _hor),
                            Expanded(
                              child: CustomButton(
                                onTap: () {
                                  final Widget _editCardPage = EditCardPage();
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          _editCardPage,
                                    ),
                                  );
                                },
                                text: 'Сохранить',
                                color: cPink,
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
