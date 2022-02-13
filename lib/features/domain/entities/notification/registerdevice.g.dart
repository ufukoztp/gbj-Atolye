// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registerdevice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDeviceResponse _$RegisterDeviceResponseFromJson(
    Map<String, dynamic> json) {
  return RegisterDeviceResponse(
    json['success'] as bool,
    json['message'] as String,
  );
}



Map<String, dynamic> _$RegisterDeviceToJson(RegisterDevice instance) =>
    <String, dynamic>{
      'devicetoken': instance.devicetoken,
      'token': instance.token,
      'tags': instance.tags,
    };


Map<String, dynamic> _$TagRequestToJson(TagRequest instance) =>
    <String, dynamic>{
      'tag': instance.tag,
    };
