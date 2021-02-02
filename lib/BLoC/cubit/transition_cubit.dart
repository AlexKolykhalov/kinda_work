import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transition_state.dart';

class TransitionCubit extends Cubit<TransitionState> {
  TransitionCubit() : super(TransitionInitial());

  void loading() {
    return emit(TransitionLoading());
  }
}
