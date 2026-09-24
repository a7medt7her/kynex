import 'package:bloc/bloc.dart';

class OnboardCubit extends Cubit<int> {
  OnboardCubit() : super(0);
  void navigatorPage(int index) {
    emit(index);
  }
}
