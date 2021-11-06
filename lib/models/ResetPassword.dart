// To parse this JSON data, do
//
//     final resetPassword = resetPasswordFromJson(jsonString);

import 'dart:convert';

ResetPassword resetPasswordFromJson(String str) => ResetPassword.fromJson(json.decode(str));

String resetPasswordToJson(ResetPassword data) => json.encode(data.toJson());

class ResetPassword {
  ResetPassword({
    this.data,
    this.message,
  });

  Data data;
  String message;

  factory ResetPassword.fromJson(Map<String, dynamic> json) => ResetPassword(
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.status,
  });

  int status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}
