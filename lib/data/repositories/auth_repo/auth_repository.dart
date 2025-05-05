import 'dart:convert';

import 'package:ahmoma_app/data/api/api_client.dart';
import 'package:ahmoma_app/data/models/user.dart';
import 'package:ahmoma_app/data/repositories/auth_repo/i_auth_repo.dart';
import 'package:ahmoma_app/data/requests/login_request.dart';
import 'package:ahmoma_app/data/requests/signup_request.dart';
import 'package:ahmoma_app/data/responses/base_response.dart';
import 'package:ahmoma_app/data/responses/login_response.dart';
import 'package:ahmoma_app/data/responses/signup_response.dart';
import 'package:ahmoma_app/utils/constants/api_constants.dart';
import 'package:ahmoma_app/utils/local_storage/app_local_storages.dart';
import 'package:ahmoma_app/utils/logging/app_logging.dart';

class AuthRepository extends IAuthenticationRepository {
  @override
  Future<DefaultResponse<LoginResponse>> login(LoginRequest request) async {
    try {
      final responseJson = await ApiClient().requestPost(
        loginPath,
        request.toJson(),
      );

      final LoginResponse loginResponse = LoginResponse.fromJson(responseJson);
      final response = DefaultResponse.fromMap(responseJson);

      if (loginResponse.user != null) {
        AppLogger.info(response.data.toString());
        return DefaultResponse(data: loginResponse);
      } else {
        AppLogger.error(response.error.toString(), response.error);
        return DefaultResponse(error: response.error);
      }
    } catch (e) {
      AppLogger.error(e.toString(), e);
      return DefaultResponse.withError(DefaultError(message: e.toString()));
    }
  }

  @override
  Future<void> saveToken(String token) {
    return AppLocalStorage().save(key: 'token', value: token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    return await AppLocalStorage().save(key: 'refresh_token', value: token);
  }

  @override
  Future<void> saveInfo(User user) async {
    final String userJson = jsonEncode(user);
    return await AppLocalStorage().save(key: 'user', value: userJson);
  }

  @override
  Future<User?> getUser() async {
    final String userJson = await AppLocalStorage().read('user') ?? "";

    if (userJson.isNotEmpty == true) {
      User user =  User.fromJson(jsonDecode(userJson));

      return user;
    }

    return null;
  }

  @override
  Future<void> logout() async {
    await AppLocalStorage().deleteAll();
  }

  @override
  Future<DefaultResponse<SignUpResponse>> signUp(SignUpRequest request) async {
    try {
      final responseJson = await ApiClient().requestPost(
        signUpPath,
        request.toJson(),
        enableRefreshToken: false,
      );

      final SignUpResponse signUpResponse = SignUpResponse.fromJson(responseJson);
      final response = DefaultResponse.fromMap(responseJson);

      if (signUpResponse.msg != null) {
        AppLogger.info(response.toString());
        return DefaultResponse(data: signUpResponse);
      } else {
        AppLogger.error(response.error.toString(), response.error);
        return DefaultResponse(error: response.error);
      }
    } catch (e) {
      AppLogger.error(e.toString(), e);
      return DefaultResponse.withError(DefaultError(message: e.toString()));
    }
  }

  // @override
  // Future<DefaultResponse<UploadAvatarResponse>> updateAvatar(File? file) async {
  //   try {
  //     final responseJson = await ApiClient().uploadFile(
  //       updateAvatarPath,
  //       file!,
  //     );
  //
  //     final UploadAvatarResponse uploadAvatarResponse = UploadAvatarResponse.fromJson(responseJson);
  //     final response = DefaultResponse.fromMap(responseJson);
  //
  //     if (uploadAvatarResponse.url != null) {
  //       User? user = await getUser();
  //
  //       user?.avatar = uploadAvatarResponse.url;
  //       await saveInfo(user!);
  //
  //       return DefaultResponse(data: uploadAvatarResponse);
  //     } else {
  //       return DefaultResponse(error: response.error);
  //     }
  //   } catch (e) {
  //     return DefaultResponse.withError(DefaultError(message: e.toString()));
  //   }
  // }
}