import 'package:bloc/bloc.dart';

class SetupIndicatorCubit extends Cubit<int> {
  SetupIndicatorCubit() : super(0);
  void currentPage(int page) {
    emit(page);
  }
}
