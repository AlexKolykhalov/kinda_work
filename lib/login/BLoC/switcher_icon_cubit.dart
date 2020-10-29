import 'package:bloc/bloc.dart';

class SwitcherIconCubit extends Cubit<bool> {
  SwitcherIconCubit() : super(true);

  void changed() => emit(!state);
}
