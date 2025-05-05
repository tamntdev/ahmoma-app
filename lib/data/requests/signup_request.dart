class SignUpRequest {
  SignUpRequest(this.userName, this.password, this.fullName);

  SignUpRequest.fromJson(dynamic json)
      : userName = json['username'] ?? "",
        password = json['password'] ?? "",
        fullName = json['fullName'] ?? "";

  String? userName;
  String? password;
  String? fullName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = userName;
    map['password'] = password;
    map['fullName'] = fullName;
    return map;
  }
}
