import 'package:bloc/bloc.dart';

class SwitcherBottomNavBarCubit extends Cubit<int> {
  SwitcherBottomNavBarCubit() : super(0);

  void changed(int page) => emit(page);
}
