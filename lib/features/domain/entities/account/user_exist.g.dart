// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_exist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UserExistRequestToJson(UserExistRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
    };

UserExistResponse _$UserExistResponseFromJson(Map<String, dynamic> json) {
  return UserExistResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
  );
}

