// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



Map<String, dynamic> _$UserRegisterRequestToJson(
        UserRegisterRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'lastName': instance.lastName,
      'brandName': instance.brandName,
      'password': instance.password,
      'phone': instance.phone,
      'currencyid': instance.currencyid,
    };

UserRegisterResponse _$UserRegisterResponseFromJson(Map<String, dynamic> json) {
  return UserRegisterResponse(
    success: json['success'] as bool,
    userid: json['userid'] as int,
    message: json['message'] as String,
  );
}
