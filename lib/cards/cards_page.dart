import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/widgets.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // TODO look at back arrow
        appBar: CustomAppBar(title: 'Карты'),
        body: Column(
          children: [
            Text('Все карты'),
            Column(children: _getCards()),
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
        bottomNavigationBar: CustomBottomNavBar(size: _size, currentIndex: 3),
      ),
    );
  }
}

List<Widget> _getCards() {
  List<String> cards = ['P', 'L', 'A'];
  List<Widget> cardsWidget;

    int k = 1;
  for (var card in cards) {
    if (k<3) {
      Widget cardWidget = ;
      row.add(cardWidget);
      k+=1;
    }else{

      k=1;
    }
    
  }

  return cardsWidget;
}