import 'package:flutter/material.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/profile/edit_profile/fillout_profile.dart';
import 'package:kinda_work/other/pages/profile/edit_profile/profile_changings.dart';
import 'package:kinda_work/other/pages/profile/edit_profile/profile_data.dart';
import 'package:kinda_work/shared_widgets.dart';
import 'package:kinda_work/styles.dart';

//TODO implement BLoC for this page
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: appBarHeight(context),
          title: 'Редактирование профиля',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: size(context, vert)),
                child: FillOutProfile(),
              ),
              Divider(thickness: 1.0, color: Colors.grey[600]),
              Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size(context, hor),
                    vertical: size(context, vert),
                  ),
                  child: ProfileData()),
              Divider(thickness: 1.0, color: Colors.grey[600]),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size(context, hor),
                  vertical: size(context, vert),
                ),
                child: ProfileChangings(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
