import 'package:ahmoma_app/data/models/user.dart';
import 'package:ahmoma_app/data/responses/login_response.dart';

sealed class AuthState {}

final class AuthenticationInitial extends AuthState {}

final class LoadInfoUser extends AuthState {
  final User? user;

  LoadInfoUser(this.user);
}

final class AuthenticationInProgress extends AuthState {
  AuthenticationInProgress();
}

final class LoginSuccess extends AuthState {
  final LoginResponse loginResponse;

  LoginSuccess(this.loginResponse);
}

final class LoginFailure extends AuthState {
  LoginFailure();
}

final class SignUpSuccess extends AuthState {
  final String message;

  SignUpSuccess(this.message);
}

final class SignUpFailure extends AuthState {
  final String message;

  SignUpFailure(this.message);
}

final class ShowPassword extends AuthState {
  final bool isShowPassword;

  ShowPassword(this.isShowPassword);
}

final class SelectCheckbox extends AuthState {
  final bool isSelectRemember;

  SelectCheckbox(this.isSelectRemember);
}

final class LogoutSuccess extends AuthState {}

final class UploadAvatarSuccess extends AuthState{}

final class UploadAvatarFail extends AuthState{}