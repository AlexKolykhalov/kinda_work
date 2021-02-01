import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/red_arrow_icon.dart';
import 'package:kinda_work/styles.dart';

List _users = [
  {
    'img': 'assets/png/face.png',
    'name': 'Роман Красновский',
    'birthday': '18.09.1980',
    'visits': 8,
  },
  {
    'img': 'assets/png/face.png',
    'name': 'Наталья',
    'birthday': '07.01.1966',
    'visits': 12,
  },
  {
    'img': 'assets/png/face.png',
    'name': 'Денис Иванов',
    'birthday': '22.10.1987',
    'visits': 1,
  },
  {
    'img': 'assets/png/face.png',
    'name': 'Галина Александрова',
    'birthday': '30.03.1979',
    'visits': 23,
  },
];

class UsersPage extends StatelessWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('-->UsersPage');
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    final double _heightImg = size(context, 0.07);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Пользователи',
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: _vert),
          child: ListView.separated(
            separatorBuilder: (context, index) => (index < _users.length - 1)
                ? Divider(thickness: 1, indent: _hor)
                : Divider(thickness: 1),
            itemCount: _users.length + 1,
            itemBuilder: (context, index) => (index < _users.length)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: _hor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: _heightImg,
                                  height: _heightImg,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage(_users[index]['img'])),
                                  ),
                                ),
                                SizedBox(width: _hor),
                                Text(
                                  _users[index]['name'],
                                  style: style3(context),
                                ),
                              ],
                            ),
                            CustomRedRightArrow(
                              onPressed: () =>
                                  _displayBottomSheet(context, _users[index]),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Container(),
          ),
        ),
      ),
    );
  }
}

void _displayBottomSheet(
  BuildContext context,
  Map user,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      final double _hor = size(context, hor);
      return Container(
        height: size(context, 0.45),
        padding: EdgeInsets.symmetric(horizontal: _hor),
        color: cGrey,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: constraints.maxWidth * 0.1,
                  height: constraints.maxHeight * 0.01,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: constraints.maxHeight * 0.35,
                      height: constraints.maxHeight * 0.35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(user['img']),
                        ),
                      ),
                    ),
                    SizedBox(height: _hor),
                    Text(
                      user['name'],
                      style:
                          style1(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: _hor / 2),
                    Text(
                      user['birthday'],
                      style: style3(context),
                    ),
                  ],
                ),
                CustomButton(
                  onTap: null,
                  text: 'Посетил ${user['visits']} раз',
                  color: cPink,
                  textColor: Colors.white,
                )
              ],
            );
          },
        ),
      );
    },
  );
}
