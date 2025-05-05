class LoginRequest {
  final String email;
  String? password;
  // String? refreshToken;

  LoginRequest({
    required this.email,
    this.password,
    // this.refreshToken,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    // map['refreshToken'] = refreshToken;

    return map;
  }
}