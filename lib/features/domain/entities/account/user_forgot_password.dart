import 'package:json_annotation/json_annotation.dart';

part 'user_forgot_password.g.dart';

@JsonSerializable()
class UserForgotPasswordRequest {

  String password;

  String phone;

  String verifycode;

  UserForgotPasswordRequest(
      {
        this.password,
        this.phone,
        this.verifycode
      });

  Map<String, dynamic> toJson() => _$UserForgotPasswordRequestToJson(this);

}

@JsonSerializable()
class UserForgotPasswordResponse {

  bool success;
  int userid;
  String message;

  UserForgotPasswordResponse(
      {
        this.success,
        this.userid,
        this.message
      });

  factory UserForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$UserForgotPasswordResponseFromJson(json);

}
