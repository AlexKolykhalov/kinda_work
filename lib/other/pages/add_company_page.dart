import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/main_page.dart';
import 'package:kinda_work/other/pages/discount/thanks_page.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class AddCompanyPage extends StatelessWidget {
  const AddCompanyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->AddCompanyPage');
    MediaQueryData _mq = MediaQuery.of(context);
    final double _hor = _mq.size.height * hor;
    final double _vert = _mq.size.height * vert;
    final double _appBarHeight = appBarHeight(context);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Добавить компанию',
        ),
        body: SingleChildScrollView(
          child: Container(
            height: _mq.size.height -
                _mq.padding.top -
                _appBarHeight -
                bottomAppHeight,
            padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Размещение на нашем портале абсолютно бесплатное! Заполните эту заявку - и в ближайшее время мы с свяжемся с Вами!',
                      style: style2(context),
                    ),
                    SizedBox(height: _vert),
                    CustomTextField(hintText: 'Название компании'),
                    SizedBox(height: _hor),
                    CustomTextField(
                      hintText: 'Вид деятельности (кафе, боулинг...)',
                    ),
                    SizedBox(height: _hor),
                    CustomTextField(hintText: 'Контактное лицо'),
                    SizedBox(height: _hor),
                    CustomTextField(hintText: 'Телефон'),
                    SizedBox(height: _hor),
                    CustomTextField(hintText: 'Email'),
                  ],
                ),
                CustomButton(
                  onTap: () {
                    final Widget _thanksPage = ThanksPage(
                      text:
                          'В ближайшее время с Вами свяжется аккаунт-менеджер',
                    );
                    return Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            _thanksPage,
                      ),
                    );
                  },
                  text: 'Отправить',
                  color: cPink,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
