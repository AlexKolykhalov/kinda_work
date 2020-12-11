import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/styles.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({Key key}) : super(key: key);

  @override
  _ProfileDataState createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  Size _size;
  TextEditingController _name;
  TextEditingController _sex;
  TextEditingController _birthday;
  TextEditingController _email;
  TextEditingController _phone;
  TextEditingController _text;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _sex = TextEditingController();
    _birthday = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _text = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _name.dispose();
    _sex.dispose();
    _birthday.dispose();
    _email.dispose();
    _phone.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _name.text = 'Фредди Макгрегор';
    _sex.text = 'Мужской';
    _birthday.text = '04.09.1980';
    _email.text = 'freddy_mack@gmail.com';
    _phone.text = '+375 (50) 780-99-01';
    _text.text = 'О, да, я крут!';
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: _size.height * 0.03),
            child: Text(
              'Данные профиля',
              style: style3(context).copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _size.height * 0.02),
            child: Container(
              child: TextField(
                controller: _name,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _size.height * 0.02),
            child: Container(
              child: TextField(
                controller: _sex,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                  suffixIcon: PopupMenuButton<String>(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: cPink,
                      ),
                      onSelected: (String val) {
                        _sex.text = val;
                      },
                      itemBuilder: (context) => ['Мужской', 'Женский']
                          .map<PopupMenuItem<String>>((String val) =>
                              PopupMenuItem(child: Text(val), value: val))
                          .toList()),
                  isCollapsed: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _size.height * 0.02),
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: _size.width * 0.75,
                    child: TextField(
                      controller: _birthday,
                      keyboardType: TextInputType.datetime,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: _size.width * 0.05),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          color: cPink,
                          onPressed: () => null,
                        ),
                        isCollapsed: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey[600],
                      ),
                      onPressed: () => null,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _size.height * 0.02),
            child: Container(
              child: TextField(
                controller: _email,
                style: TextStyle(color: Colors.grey[600]),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                  enabled: false,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _size.height * 0.02),
            child: Container(
              child: TextField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: _size.width * 0.05),
                  filled: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _size.height * 0.02),
            child: Container(
              child: TextField(
                controller: _text,
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
