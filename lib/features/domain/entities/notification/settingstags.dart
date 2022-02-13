import 'package:json_annotation/json_annotation.dart';

part 'settingstags.g.dart';

@JsonSerializable()
class SettingsTagsRequest {

  String token;

  List<TagRequest> tags;

  SettingsTagsRequest({this.token, this.tags});

  Map<String, dynamic> toJson() => _$SettingsTagsRequestToJson(this);

}

@JsonSerializable()
class SettingsTagsResponse {

  bool success;

  String message;

  SettingsTagsResponse(this.success, this.message);

  factory SettingsTagsResponse.fromJson(Map<String, dynamic> json) => _$SettingsTagsResponseFromJson(json);

}

@JsonSerializable()
class TagRequest {

  String tag;

  Map<String, dynamic> toJson() => _$TagRequestToJson(this);

}
