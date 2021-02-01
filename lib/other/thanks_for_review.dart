import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';

class ThanksForReviewPage extends StatelessWidget {
  const ThanksForReviewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->ThanksForReviewPage');
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    final double _height = size(context, 0.01);
    final TextStyle _style2 = style2(context);
    final TextStyle _style3 = style3(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: _hor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size(context, 0.04)),
                  Text(
                    'Спасибо за ваш отзыв!',
                    style: style1(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: _hor / 2),
                    child: Text(
                      'Скоро мы его опубликуем. Укажите следующую информацию и получите еще баллы.',
                      style: _style3,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Какого рода посещение?',
                        style: _style3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '+5 баллов',
                        style: _style3.copyWith(
                          color: cPink,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Друзья', style: _style2),
                      CustomRedRightArrow(onPressed: null),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.0, height: 0.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: _hor),
              child: Column(
                children: [
                  SizedBox(height: _height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Какой уровень цен?',
                        style: _style3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '+5 баллов',
                        style: _style3.copyWith(
                          color: cPink,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Выбрать', style: _style2),
                      CustomRedRightArrow(onPressed: null),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.0, height: 0.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: _hor,
                vertical: _height,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Фото заведения',
                        style: _style3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '+25 баллов',
                        style: _style3.copyWith(
                          color: cPink,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: _height),
                  ImageListView(),
                ],
              ),
            ),
            Divider(thickness: 1.0, height: 0.0),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: _hor,
                vertical: _height,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Фото чека',
                        style: _style3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '+25 баллов',
                        style: _style3.copyWith(
                          color: cPink,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: _height,
                    ),
                    child: Text(
                      'Для контроля работы системы и решения спорных вопросов',
                      style: _style3.copyWith(color: Colors.grey[600]),
                    ),
                  ),
                  ImageListView(),
                ],
              ),
            ),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: _hor,
                vertical: _vert,
              ),
              child: CustomButton(
                onTap: null,
                text: 'Отправить',
                color: cPink,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageListView extends StatelessWidget {
  const ImageListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size(context, 0.1),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: size(context, 0.01));
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: size(context, 0.1),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/png/grid/no_photo.png'),
                )),
          );
        },
      ),
    );
  }
}
