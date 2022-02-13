import 'package:json_annotation/json_annotation.dart';

part 'registerdevice.g.dart';

@JsonSerializable()
class RegisterDeviceResponse {

  bool success;
  String message;
  RegisterDeviceResponse(this.success,this.message);

  factory RegisterDeviceResponse.fromJson(Map<String, dynamic> json) => _$RegisterDeviceResponseFromJson(json);

}

@JsonSerializable()
class RegisterDevice{

  final String devicetoken;
  final String token;
  final List<TagRequest> tags;

  RegisterDevice({this.devicetoken, this.token,this.tags});

  Map<String, dynamic> toJson() => _$RegisterDeviceToJson(this);

}


@JsonSerializable()
class TagRequest {

  String tag;

  Map<String, dynamic> toJson() => _$TagRequestToJson(this);

}