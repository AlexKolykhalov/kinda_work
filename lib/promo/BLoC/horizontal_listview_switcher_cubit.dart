import 'package:bloc/bloc.dart';

class SwitcherHorigontalListViewCubit extends Cubit<int> {
  SwitcherHorigontalListViewCubit() : super(0);

  void changed(int number) => emit(number);
}
