// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
/*
UserTokenRequest _$UserTokenRequestFromJson(Map<String, dynamic> json) {
  return UserTokenRequest(
    password: json['password'] as String,
    phone: json['phone'] as String,
  );
}
*/
Map<String, dynamic> _$UserTokenRequestToJson(UserTokenRequest instance) =>
    <String, dynamic>{
      'password': instance.password,
      'phone': instance.phone,
    };

UserTokenResponse _$UserTokenResponseFromJson(Map<String, dynamic> json) {
  return UserTokenResponse(
    token: json['token'] as String,
    expiration: json['expiration'] as String,
    success: json['success'] as bool,
    message: json['message'] as String,
  );
}
