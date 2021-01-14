import 'package:flutter/material.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Пользователи',
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: size(context, vert)),
          child: ListView.separated(
            separatorBuilder: (context, index) => (index < _users.length - 1)
                ? Divider(thickness: 1, indent: size(context, hor))
                : Divider(thickness: 1),
            itemCount: _users.length + 1,
            itemBuilder: (context, index) => (index < _users.length)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size(context, hor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage(_users[index]['img'])),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Text(_users[index]['name']),
                              ],
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () =>
                                  _displayBottomSheet(context, _users[index]),
                              icon: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(Icons.keyboard_arrow_right,
                                    color: cPink),
                              ),
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
      Size _size = MediaQuery.of(context).size;
      return Container(
        height: _size.height * 0.45,
        padding: EdgeInsets.symmetric(
          horizontal: size(context, hor),
        ),
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        0.0,
                        _size.height * 0.02,
                        0.0,
                        _size.height * 0.015,
                      ),
                      child: Text(user['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: constraints.maxHeight * 0.065)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: _size.height * 0.04),
                      child: Text(user['birthday'],
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ],
                ),
                CustomButton(
                  onTap: null,
                  buttonText: 'Посетил ${user['visits']} раз',
                  buttonColor: cPink,
                  buttonTextColor: Colors.white,
                )
              ],
            );
          },
        ),
      );
    },
  );
}
