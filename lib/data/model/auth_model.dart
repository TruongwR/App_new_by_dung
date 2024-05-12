import 'dart:convert';

import 'package:intl/intl.dart';


Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
  String? accessToken;
  String? refreshToken;
  final User? user;
  final int? id;

  int? type;
  bool? active;

  Auth({
    this.accessToken,
    this.refreshToken,
    this.user,

    this.id,

    this.type,
    this.active,
  });

  Auth copyWith({
    String? accessToken,
    User? user,
    String? refreshToken,
    int? id,

    int? type,
    bool? active,
  }) =>
      Auth(
        accessToken: accessToken ?? this.accessToken,
        user: user ?? this.user,
        refreshToken: refreshToken ?? this.refreshToken,

        id: id ?? this.id,

        active: active ?? this.active,
        type: type ?? this.type,
      );

  factory Auth.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> jsonUser = {};
    int id = 0;


    int? type;
    bool active = true;

    if (json.containsKey('data') && json['data'] is Map<String, dynamic> && json['data'].containsKey('user')) {
      jsonUser = json["data"]["user"];
      id = json["data"]["id"];


      // active json["data"]["active"];
    } else if (json.containsKey('data') && json['data'] is Map<String, dynamic> && json['data'].containsKey('name')) {
      jsonUser = json["data"];
    }
    if (json["data"]["type"] != null) {
      type = json["data"]["type"];
    }
    if (json["data"]["active"] != null) {
      active = json["data"]["active"];
    }
    return Auth(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      user: json["data"] == null ? null : User.fromJson(jsonUser),
      id: id,

      type: type,
      active: active,
    );
  }
  factory Auth.fromJsonOld(Map<String, dynamic> json) {
    int id = 0;

    int? type;
    bool active = true;


    if (json["type"] != null) {
      type = json["type"];
    }
    if (json["active"] != null) {
      active = json["active"];
    }
    if (json["id"] != null) {
      id = json["id"];
    }
    return Auth(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      user: User.fromJson(json["user"]),
      id: id,

      type: type,
      active: active,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "access_token": accessToken,
        "refreshToken": refreshToken,
        "user": user?.toJson(),

        "type": type,
        "active": active
      };
}

class User {
  final int id;
  final String name;
  final String? email;
  final String password;
  final String? address;
  final String phone;
  final dynamic avatar;
  final String gender;
  final dynamic description;
  final Role role;
  final dynamic patient;
  final String? cccd;
  final bool? active;
  final DateTime? birthDate;

  User({
    required this.id,
    required this.name,
    this.email,
    required this.password,
    this.address,
    required this.phone,
    this.avatar,
    required this.gender,
    this.description,
    required this.role,
    this.patient,
    this.cccd,
    this.active,
    required this.birthDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        phone: json["phone"],
        avatar: json["avatar"],
        gender: json["gender"] ?? '0',
        description: json["description"],
        role: Role.fromJson(json["role"]),
        patient: json["patient"],
        birthDate: json["birthDate"] == null ? null : DateFormat('dd/MM/yyyy').parse(json["birthDate"]),
        cccd: json["cccd"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "phone": phone,
        "avatar": avatar,
        "gender": gender,
        "description": description,
        "role": role.toJson(),
        "patient": patient,
        "cccd": cccd,
        "birthDate": birthDate != null ? DateFormat('dd/MM/yyyy').format(birthDate!) : null,
        "active": active,
      };
}

class Role {
  final int id;
  final String name;

  Role({
    required this.id,
    required this.name,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
