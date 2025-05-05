import 'package:ahmoma_app/data/models/user.dart';
import 'package:ahmoma_app/data/repositories/auth_repo/auth_repository.dart';
import 'package:ahmoma_app/data/requests/login_request.dart';
import 'package:ahmoma_app/data/requests/signup_request.dart';
import 'package:ahmoma_app/modules/authentication/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthenticationInitial());

  final _repository = AuthRepository();

  /// Load user info
  Future<void> loadInfoUser() async {
    User? user = await _repository.getUser();

    emit(LoadInfoUser(user));
  }

  /// Login method
  Future<void> login(LoginRequest request) async {
    emit(AuthenticationInProgress());

    final res = await _repository.login(request);
    await Future.delayed(const Duration(milliseconds: 500));

    if (res.data != null) {
      await _repository.saveToken(res.data!.accessToken!);
      await _repository.saveInfo(res.data!.user!);
      emit(LoginSuccess(res.data!));
    } else {
      emit(LoginFailure());
    }
  }

  /// Method sign up
  Future<void> signUp(SignUpRequest request) async {
    emit(AuthenticationInProgress());

    final res = await _repository.signUp(request);
    await Future.delayed(const Duration(milliseconds: 500));

    if (res.data != null) {
      emit(SignUpSuccess(res.data!.msg!));
    } else {
      emit(SignUpFailure(res.error?.message ?? "có lỗi xảy ra"));
    }
  }

  /// Method show/hide password
  Future<void> showPassword(bool isShowPassword) async {
    emit(ShowPassword(isShowPassword));
  }

  /// Method select remember me
  Future<void> selectCheckbox(bool isSelectRemember) async {
    emit(SelectCheckbox(isSelectRemember));
  }

  /// Logout method
  Future<void> logout() async {
    await _repository.logout();
    emit(LogoutSuccess());
  }

  /// Method update avatar
  // Future<void> updateAvatar(File? file) async {
  //   emit(AuthenticationInProgress());
  //
  //   final res = await _repository.updateAvatar(file);
  //
  //   if(res.error == null) {
  //     emit(UploadAvatarSuccess());
  //   } else {
  //     emit(UploadAvatarFail());
  //   }
  // }
}
