// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_forgot_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$UserForgotPasswordRequestToJson(
        UserForgotPasswordRequest instance) =>
    <String, dynamic>{
      'Password': instance.password,
      'Number': instance.phone,
      'VerifyCode': instance.verifycode,
    };

UserForgotPasswordResponse _$UserForgotPasswordResponseFromJson(
    Map<String, dynamic> json) {
  return UserForgotPasswordResponse(
    success: json['success'] as bool,
    userid: json['userid'] as int,
    message: json['message'] as String,
  );
}
