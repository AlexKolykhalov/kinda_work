import 'package:bloc/bloc.dart';

class SwitcherBottomAppBarCubit extends Cubit<int> {
  SwitcherBottomAppBarCubit() : super(1);

  void changed(int number) => emit(number);
}
