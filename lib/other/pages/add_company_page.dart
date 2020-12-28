import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/main/pages/discount/thanks_page.dart';
import 'package:kinda_work/shared_widgets.dart';

class AddCompanyPage extends StatelessWidget {
  const AddCompanyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Добавить компанию'),
        body: SingleChildScrollView(
          child: Container(
            height: _size.height - MediaQuery.of(context).padding.top - 48.0,
            padding: EdgeInsets.symmetric(
              horizontal: _size.width * cHorizont,
              vertical: _size.height * cVertical,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                        'Размещение на нашем портале абсолютно бесплатное! Заполните эту заявку - и в ближайшее время мы с свяжемся с Вами!'),
                    SizedBox(height: 15.0),
                    TextField(
                      // controller: emailPhoneController,
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Название компании',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.05),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      // controller: emailPhoneController,
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Вид деятельности (кафе, боулинг...)',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.05),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      // controller: emailPhoneController,
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Контактное лицо',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.05),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      // controller: emailPhoneController,
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Телефон',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.05),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      // controller: emailPhoneController,
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Email',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.05),
                      ),
                    )
                  ],
                ),
                CustomButton(
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ThanksPage(
                        text:
                            'В ближайшее время с Вами свяжется аккаунт-менеджер',
                      ),
                    ),
                  ),
                  buttonText: 'Отправить',
                  buttonColor: cPink,
                  buttonTextColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
