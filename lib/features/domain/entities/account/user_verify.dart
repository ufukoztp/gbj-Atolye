import 'package:json_annotation/json_annotation.dart';

part 'user_verify.g.dart';

@JsonSerializable()
class SendSmsCodeRequest {

  String number;
  String brand="GBJAtolye";
  String apiKey = "304b8c2b";
  String apiSecret = "eG1890656";
  String pinExpiry = "3600";
  //String next_event_wait = "60";

  SendSmsCodeRequest({this.number});

  Map<String, dynamic> toJson() => _$SendSmsCodeRequestToJson(this);

}

@JsonSerializable()
class RequestIdStatusRequest {

  String requestId;
  String apiKey = "304b8c2b";
  String apiSecret = "eG1890656";

  RequestIdStatusRequest({this.requestId});

  Map<String, dynamic> toJson() => _$RequestIdStatusRequestToJson(this);

}

@JsonSerializable()
class ResendSmsCodeRequest {

  String requestId;
  String apiKey = "304b8c2b";
  String apiSecret = "eG1890656";


  ResendSmsCodeRequest({this.requestId});

  Map<String, dynamic> toJson() => _$ResendSmsCodeRequestToJson(this);

}

@JsonSerializable()
class VerifySmsCodeRequest {

  String requestId;
  String code;
  String apiKey = "304b8c2b";
  String apiSecret = "eG1890656";


  VerifySmsCodeRequest({this.requestId,this.code});

  Map<String, dynamic> toJson() => _$VerifySmsCodeRequestToJson(this);

}

@JsonSerializable()
class SmsCodeExternalServerResponse {

  String requestId;
  String status;
  String errorText;

  SmsCodeExternalServerResponse(
      {this.requestId, this.status, this.errorText});

  factory SmsCodeExternalServerResponse.fromJson(Map<String, dynamic> json) =>
      _$SmsCodeExternalServerResponseFromJson(json);
}

@JsonSerializable()
class VerifySmsCodeGbjRequest {

  String requestid;
  String code;
  String phone;


  VerifySmsCodeGbjRequest({this.requestid,this.code,this.phone});

  Map<String, dynamic> toJson() => _$VerifySmsCodeGbjRequestToJson(this);

}

@JsonSerializable()
class VerifySmsCodeGbjResponse{

  bool success;
  String status;
  String message;

  VerifySmsCodeGbjResponse({this.success, this.status, this.message});

  factory VerifySmsCodeGbjResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifySmsCodeGbjResponseFromJson(json);

}
