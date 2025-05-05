class SignUpResponse {
  String? msg;

  SignUpResponse({
    this.msg,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
  };
}