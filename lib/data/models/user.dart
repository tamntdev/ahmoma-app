class User {
  int? id;
  String? username;
  String? fullName;
  String? role;
  String? avatar;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.username,
    this.fullName,
    this.role,
    this.avatar,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    fullName: json["fullName"],
    role: json["role"],
    avatar: json["avatar"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "fullName": fullName,
    "role": role,
    "avatar": avatar,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}