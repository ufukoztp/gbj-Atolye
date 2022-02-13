import 'package:json_annotation/json_annotation.dart';
part 'user_auth.g.dart';

@JsonSerializable()
class UserTokenRequest {

  final String password;
  final String phone;

  UserTokenRequest({
    this.password,
    this.phone,
  });

  Map<String, dynamic> toJson() => _$UserTokenRequestToJson(this);

}



@JsonSerializable()
class UserTokenResponse {

  final String token;
  final String expiration;
  final bool success;
  final String message;

  UserTokenResponse({
    this.token,
    this.expiration,
    this.success,
    this.message,
  });

  factory UserTokenResponse.fromJson(Map<String, dynamic> json) => _$UserTokenResponseFromJson(json);

}


