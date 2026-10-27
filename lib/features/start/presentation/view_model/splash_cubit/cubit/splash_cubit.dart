import 'package:bloc/bloc.dart';
import 'package:kynex/features/start/data/repo/splash_repository.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.splashRepository}) : super(SplashInitial());
  final SplashRepository splashRepository;
  Future getData() async {
    final data = await splashRepository.getUserSetupData();
    data.fold(
      (l) {
        emit(FiledGetData(filedMassage: l));
      },
      (r) {
        emit(
          SuccessGetData(
            isSetupComplete: r['isComplete'],
            whichPage: r['pageComplete'],
            successMassage: 'welcome ${r['userName']}',
          ),
        );
      },
    );
  }
}
