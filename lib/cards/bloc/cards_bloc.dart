import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kinda_work/models.dart';
import 'package:kinda_work/repository.dart';
import 'package:meta/meta.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc() : super(CardsInitial());

  @override
  Stream<CardsState> mapEventToState(
    CardsEvent event,
  ) async* {
    if (event is ReceivedCards) {
      yield CardsLoading();
      await Future.delayed(Duration(seconds: 2));
      yield CardsLoaded(cards: cards);
    }
  }
}
