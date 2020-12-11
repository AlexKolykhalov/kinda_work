import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/other/pages/ptofile/edit_profile/fillout_profile.dart';
import 'package:kinda_work/other/pages/ptofile/edit_profile/profile_changings.dart';
import 'package:kinda_work/other/pages/ptofile/edit_profile/profile_data.dart';
import 'package:kinda_work/widgets.dart';

//TODO implement BLoC for this page
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Редактирование профиля'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(
                    0.0,
                    _size.height * cVertical,
                    0.0,
                    0.0,
                  ),
                  child: FillOutProfile()),
              Divider(color: Colors.grey[600]),
              Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _size.width * cHorizont,
                    vertical: _size.height * cVertical,
                  ),
                  child: ProfileData()),
              Divider(color: Colors.grey[600]),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _size.width * cHorizont,
                  vertical: _size.height * cVertical,
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
