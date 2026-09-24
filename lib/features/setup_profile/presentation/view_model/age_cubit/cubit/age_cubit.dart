import 'package:bloc/bloc.dart';

class AgeCubit extends Cubit<int> {
  AgeCubit() : super(0);
  void itemSelected(int index) {
    emit(index);
  }
}
