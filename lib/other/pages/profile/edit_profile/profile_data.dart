import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

class ProfileData extends StatelessWidget {
  const ProfileData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.03)),
            child: Text(
              'Данные профиля',
              style: style3(context).copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.02)),
            child: CustomTextField(text: 'Фредди Макгрегор'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.02)),
            child: CustomTextField(
              text: 'Мужской',
              popupMenuItems: ['Мужской', 'Женский'],
            ),
          ),
          Container(
            height: math.min(size(context, 0.075), 48.0),
            margin: EdgeInsets.only(bottom: size(context, 0.02)),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    text: '19.08.1980',
                    popupMenuItems: [''],
                  ),
                ),
                SizedBox(width: size(context, 0.02)),
                IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey[600],
                  ),
                  onPressed: () => null,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.02)),
            child: CustomTextField(
              text: 'freddy_mack@gmail.com',
              isEnabled: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size(context, 0.02)),
            child: CustomTextField(text: '+375 (50) 780-99-01'),
          ),
          CustomTextField(
            text: 'О да, я крут!',
            isMultiLines: true,
          ),
        ],
      ),
    );
  }
}
