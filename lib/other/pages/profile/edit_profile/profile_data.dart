import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/shared_widgets/text_fields.dart';
import 'package:kinda_work/styles.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: _vert),
          child: Text(
            'Данные профиля',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: _hor),
          child: CustomTextField(text: 'Фредди Макгрегор'),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: _hor),
          child: CustomTextField(
            text: 'Мужской',
            popupMenuItems: ['Мужской', 'Женский'],
          ),
        ),
        Container(
          height: math.min(size(context, 0.075), 48.0),
          margin: EdgeInsets.only(bottom: _hor),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  text: '19.08.1980',
                  popupMenuItems: [''],
                ),
              ),
              SizedBox(width: _hor),
              IconButton(
                icon: Icon(Icons.remove_red_eye, color: Colors.grey[600]),
                onPressed: () => null,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: _hor),
          child: CustomTextField(
            text: 'freddy_mack@gmail.com',
            isEnabled: false,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: _hor),
          child: CustomTextField(text: '+375 (50) 780-99-01'),
        ),
        CustomTextField(
          text: 'О да, я крут!',
          isMultiLines: true,
        ),
      ],
    );
  }
}
