import 'package:ahmoma_app/modules/splash/splash_cubit/splash_state.dart';
import 'package:ahmoma_app/utils/local_storage/app_local_storages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState(isSplashDone: false));

  void checkLoadSplashDone() async {
    await Future.delayed(const Duration(milliseconds: 300));
    String? token = await AppLocalStorage().read("token");

    emit(SplashState(isSplashDone: true, isSigned: token != null && token.isNotEmpty));
  }
}
