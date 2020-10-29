import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/registaration/widgets/edit_profile_page/fillout_profile.dart';
import 'package:kinda_work/registaration/widgets/edit_profile_page/profile_changings.dart';
import 'package:kinda_work/registaration/widgets/edit_profile_page/profile_data.dart';

//TODO implement BLoC for this page
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Container(
              width: _size.height * 0.05,
              height: _size.height * 0.04,
              child: SvgPicture.asset(
                'assets/svg/left_arrow.svg',
                fit: BoxFit.contain,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Редактирование профиля',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                padding: EdgeInsets.fromLTRB(
                  0.0,
                  _size.height * cVertical,
                  0.0,
                  0.0,
                ),
                child: FillOutProfile(size: _size)),
            Divider(color: Colors.grey[600]),
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _size.width * cHorizont,
                  vertical: _size.height * cVertical,
                ),
                child: ProfileData(size: _size)),
            Divider(color: Colors.grey[600]),
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _size.width * cHorizont,
                  vertical: _size.height * cVertical,
                ),
                child: ProfileChangings(size: _size)),
          ]),
        ),
      ),
    );
  }
}
