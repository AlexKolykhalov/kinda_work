import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:kinda_work/constants.dart';
import 'package:kinda_work/login/widgets/logo_part.dart';
import 'package:kinda_work/registaration/widgets/bottom_text_part.dart';
import 'package:kinda_work/registaration/widgets/registration_data_part.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    print('-->RegistrationPage');
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                left: 15.0,
                top: 15.0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: _size.height * 0.05,
                    height: _size.height * 0.04,
                    child: SvgPicture.asset(
                      'assets/svg/left_arrow.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Container(
                height: _size.height - MediaQuery.of(context).padding.top,
                padding: EdgeInsets.symmetric(
                  horizontal: _size.width * cLoginPageHorizontal,
                  vertical: _size.height * cLoginPageVertical,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LogoPart(size: _size),
                    RegistrationDataPart(size: _size),
                    BottomTextPart(size: _size),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
