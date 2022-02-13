// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settingstags.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



Map<String, dynamic> _$SettingsTagsRequestToJson(
        SettingsTagsRequest instance) =>
    <String, dynamic>{
      'token': instance.token,
      'tags': instance.tags,
    };

SettingsTagsResponse _$SettingsTagsResponseFromJson(Map<String, dynamic> json) {
  return SettingsTagsResponse(
    json['success'] as bool,
    json['message'] as String,
  );
}

Map<String, dynamic> _$TagRequestToJson(TagRequest instance) =>
    <String, dynamic>{
      'tag': instance.tag,
    };
