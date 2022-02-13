// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_verify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



Map<String, dynamic> _$SendSmsCodeRequestToJson(SendSmsCodeRequest instance) =>
    <String, dynamic>{
      'number': instance.number,
      'brand': instance.brand,
      'api_key': instance.apiKey,
      'api_secret': instance.apiSecret,
      'pin_expiry': instance.pinExpiry,
    };

Map<String, dynamic> _$RequestIdStatusRequestToJson(
        RequestIdStatusRequest instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'api_key': instance.apiKey,
      'api_secret': instance.apiSecret,
    };



Map<String, dynamic> _$ResendSmsCodeRequestToJson(
        ResendSmsCodeRequest instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'api_key': instance.apiKey,
      'api_secret': instance.apiSecret,
    };


Map<String, dynamic> _$VerifySmsCodeRequestToJson(
        VerifySmsCodeRequest instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'code': instance.code,
      'api_key': instance.apiKey,
      'api_secret': instance.apiSecret,
    };

SmsCodeExternalServerResponse _$SmsCodeExternalServerResponseFromJson(
    Map<String, dynamic> json) {
  return SmsCodeExternalServerResponse(
    requestId: json['request_id'] as String,
    status: json['status'] as String,
    errorText: json['error_text'] as String,
  );
}

Map<String, dynamic> _$VerifySmsCodeGbjRequestToJson(
        VerifySmsCodeGbjRequest instance) =>
    <String, dynamic>{
      'requestid': instance.requestid,
      'code': instance.code,
      'phone': instance.phone,
    };

VerifySmsCodeGbjResponse _$VerifySmsCodeGbjResponseFromJson(
    Map<String, dynamic> json) {
  return VerifySmsCodeGbjResponse(
    success: json['success'] as bool,
    status: json['status'] as String,
    message: json['message'] as String,
  );
}

