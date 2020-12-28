import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';
import 'package:kinda_work/shared_widgets.dart';

class ThanksForReviewPage extends StatelessWidget {
  const ThanksForReviewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size(context, hor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size(context, 0.05)),
                  Text(
                    'Спасибо за ваш отзыв!',
                    style: style1(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size(context, 0.01)),
                  Text(
                    'Скоро мы его опубликуем. Укажите следующую информацию и получите еще баллы.',
                    style: style3(context),
                  ),
                  SizedBox(height: size(context, 0.02)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Какого рода посещение?',
                        style: style3(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '+5 баллов',
                        style: style3(context).copyWith(
                          color: cPink,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Друзья',
                        style: style2(context),
                      ),
                      CustomRedRightArrow(onPressed: null),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Какой уровень цен?',
                        style: style3(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '+5 баллов',
                        style: style3(context).copyWith(
                          color: cPink,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Выбрать',
                        style: style2(context),
                      ),
                      CustomRedRightArrow(onPressed: null),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Фото заведения',
                        style: style3(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '+25 баллов',
                        style: style3(context).copyWith(
                          color: cPink,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: size(context, 0.01)),
                    child: ImageListView(),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size(context, hor)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Фото чека',
                        style: style3(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '+25 баллов',
                        style: style3(context).copyWith(
                          color: cPink,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: size(context, 0.01)),
                    child: Text(
                      'Для контроля работы системы и решения спорных вопросов',
                      style: style3(context).copyWith(color: Colors.grey[600]),
                    ),
                  ),
                  ImageListView(),
                ],
              ),
            ),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size(context, hor),
                vertical: size(context, vert),
              ),
              child: CustomButton(
                onTap: null,
                buttonText: 'Отправить',
                buttonColor: cPink,
                buttonTextColor: Colors.white,
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
