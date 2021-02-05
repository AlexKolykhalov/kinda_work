import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kinda_work/cards/bloc/cards_bloc.dart';
import 'package:kinda_work/constants.dart';
import 'package:kinda_work/models.dart';

import 'package:kinda_work/shared_widgets/app_bars.dart';
import 'package:kinda_work/shared_widgets/common_widgets.dart';
import 'package:kinda_work/styles.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('***CardsPage***');
    return BlocBuilder<CardsBloc, CardsState>(
      builder: (context, state) {
        if (state is CardsLoaded) {
          if (state.cards.isEmpty) {
            return Scaffold(
              appBar: CustomAppBar(
                height: appBarHeight(context),
                title: 'Карты',
                showBackArrow: false,
              ),
              body: NoCardsPage(),
            );
          }
          return Scaffold(
            appBar: CustomAppBar(
              height: appBarHeight(context),
              title: 'Карты',
              showBackArrow: false,
              actions: [CustomFlatButton(icon: Icon(Icons.add, color: cPink))],
            ),
            body: CurrentCardsPage(cards: state.cards),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
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

class NoCardsPage extends StatelessWidget {
  const NoCardsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mq = MediaQuery.of(context);
    final double _h = _mq.size.height * 0.15;
    final double _hor = _mq.size.height * hor;
    final double _vert = _mq.size.height * vert;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
      child: Column(
        children: [
          Expanded(child: Container()),
          Column(
            children: [
              Container(
                width: _h,
                height: _h,
                child: SvgPicture.asset('assets/svg/cards.svg'),
              ),
              SizedBox(height: _vert * 2),
              Text(
                'Добавьте карту',
                style: style1(context).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: _vert),
              Text(
                'Сделать это можно за пару секунд!',
                textAlign: TextAlign.center,
                style: style3(context),
              ),
            ],
          ),
          Expanded(child: Container()),
          CustomButton(
            onTap: () {
              return null;
              // final Widget _addCardPage = AddCardPage();
              // Navigator.push(
              //     context,
              //     PageRouteBuilder(
              //       pageBuilder:
              //           (context, animation, secondaryAnimation) =>
              //               _addCardPage,
              //     ),
              //     (route) => false);
            },
            text: 'Добавить карту',
            color: cPink,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class CurrentCardsPage extends StatelessWidget {
  const CurrentCardsPage({
    Key key,
    @required this.cards,
  }) : super(key: key);

  final List<UserCard> cards;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mq = MediaQuery.of(context);
    final double _hor = _mq.size.height * hor;
    final double _vert = _mq.size.height * vert;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _hor, vertical: _vert),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Вы посетили',
            style: style3(context).copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: _vert),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.5,
                  crossAxisCount: 2,
                  mainAxisSpacing: _hor,
                  crossAxisSpacing: _hor,
                ),
                itemBuilder: (context, index) => CardWidget(),
                itemCount: cards.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => null,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
              Positioned(
                top: constraints.maxHeight * 0.1,
                right: constraints.maxHeight * 0.1,
                child: Container(
                  width: constraints.maxHeight * 0.15,
                  height: constraints.maxHeight * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cPink,
                  ),
                  child: Center(
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Icon(Icons.check,
                            color: Colors.white,
                            size: constraints.maxHeight * 0.7);
                      },
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
