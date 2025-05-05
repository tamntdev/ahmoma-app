import 'package:ahmoma_app/data/models/user.dart';

class LoginResponse {
  User? user;
  String? accessToken;

  LoginResponse({
    this.user,
    this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "accessToken": accessToken,
  };
}
