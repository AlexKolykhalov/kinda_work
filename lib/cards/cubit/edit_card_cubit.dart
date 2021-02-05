import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_card_state.dart';

class EditCardCubit extends Cubit<bool> {
  EditCardCubit() : super(false);

  void changedAppBar() => emit(!state);
}
