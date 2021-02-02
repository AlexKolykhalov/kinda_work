import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transition_event.dart';
part 'transition_state.dart';

class TransitionBloc extends Bloc<TransitionEvent, TransitionState> {
  TransitionBloc() : super(TransitionInitial());

  @override
  Stream<TransitionState> mapEventToState(
    TransitionEvent event,
  ) async* {
    if (event is Fetched) {
      yield TransitionLoading();
      Future.delayed(Duration(seconds: 3));
      yield TransitionLoaded();
    }
  }
}
