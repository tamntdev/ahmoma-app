import 'package:ahmoma_app/data/models/user.dart';
import 'package:ahmoma_app/data/requests/login_request.dart';
import 'package:ahmoma_app/data/requests/signup_request.dart';
import 'package:ahmoma_app/data/responses/base_response.dart';
import 'package:ahmoma_app/data/responses/login_response.dart';
import 'package:ahmoma_app/data/responses/signup_response.dart';

abstract class IAuthenticationRepository{
  Future<DefaultResponse<LoginResponse>> login(LoginRequest request);
  Future<DefaultResponse<SignUpResponse>> signUp(SignUpRequest request);
  Future<void> logout();
  Future<void> saveToken(String token);
  Future<void> saveRefreshToken(String token);
  Future<void> saveInfo(User user);
  Future<User?> getUser();
  // Future<DefaultResponse<UploadAvatarResponse>> updateAvatar(File? file);
}