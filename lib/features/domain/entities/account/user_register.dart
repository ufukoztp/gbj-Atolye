import 'package:json_annotation/json_annotation.dart';

part 'user_register.g.dart';

@JsonSerializable()
class UserRegisterRequest {

  String name;
  String lastName;
  String brandName;
  String password;
  String phone;
  String currencyid;

  UserRegisterRequest(
      {  this.name,
         this.lastName,
         this.brandName,
         this.password,
         this.phone,
         this.currencyid,
      });

  Map<String, dynamic> toJson() => _$UserRegisterRequestToJson(this);

}

@JsonSerializable()
class UserRegisterResponse {

  bool success;
  String message;
  int userid;


  UserRegisterResponse(
      {
         this.success,
         this.userid,
         this.message
      });

  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterResponseFromJson(json);

}
