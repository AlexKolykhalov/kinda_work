import 'package:flutter/material.dart';

import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/styles.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('***CardsPage***');
    return Scaffold(
      appBar: CustomAppBar(
        height: appBarHeight(context),
        title: 'Карты',
        showBackArrow: false,
      ),
      body: Column(
        children: [
          Text('Все карты'),
          // Column(children: _getCards()),
        ],
      ),
      // body: Stack(
      //   children: [
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Container(
      //             margin: EdgeInsets.only(bottom: 20.0),
      //             height: _size.height * 0.2,
      //             child: SvgPicture.asset(
      //                 'assets/svg/bottombar_icons/cards.svg')),
      //         Padding(
      //           padding: EdgeInsets.only(bottom: 10.0),
      //           child: Text(
      //             'Добавьте карту',
      //             style: TextStyle(
      //               fontSize: _size.height * 0.03,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ),
      //         Text(
      //           'Сделать это можно за пару секунд!',
      //           style: TextStyle(
      //             fontSize: _size.height * 0.021,
      //           ),
      //         ),
      //       ],
      //     ),
      //     Positioned(
      //       left: 0.0,
      //       right: 0.0,
      //       bottom: 25.0,
      //       child: Padding(
      //         padding: EdgeInsets.symmetric(
      //           horizontal: _size.width * cHorizont,
      //         ),
      //         child: CustomButton(
      //           onTap: null,
      //           buttonText: 'Добавить карту',
      //           buttonColor: cPink,
      //           buttonTextColor: Colors.white,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );

    // Navigator(
    //   onGenerateRoute: (settings) {
    //     return MaterialPageRoute(
    //       settings: settings,
    //       builder: (context) {
    //         return

    //       },
    //     );
    //   },
    // );
  }
}
