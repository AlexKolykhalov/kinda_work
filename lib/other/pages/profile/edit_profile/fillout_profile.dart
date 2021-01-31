import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/profile/edit_profile/widgets.dart';
import 'package:kinda_work/styles.dart';

class FillOutProfile extends StatelessWidget {
  const FillOutProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _hor = size(context, hor);
    final double _vert = size(context, vert);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FillScale(value: 30),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: _hor,
              vertical: _vert,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Осталось заполнить',
                  style: style3(context).copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '+25%',
                  style: style2(context).copyWith(
                    color: cPink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                child: SocialNetworkAccountStatus(
                  imgPath: 'assets/png/facebook.png',
                  name: 'Facebook',
                  isConnected: false,
                ),
              ),
              Divider(thickness: 1.0, indent: _hor),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _hor),
                child: SocialNetworkAccountStatus(
                  imgPath: 'assets/png/vk.png',
                  name: 'ВКонтакте',
                  isConnected: true,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
