import 'package:json_annotation/json_annotation.dart';
part 'user_exist.g.dart';

@JsonSerializable()
class UserExistRequest {
  String phone;
  UserExistRequest(
      {
        this.phone
      });

  Map<String, dynamic> toJson() => _$UserExistRequestToJson(this);
}

@JsonSerializable()
class UserExistResponse {

  bool success;
  String message;

  UserExistResponse(
      {
        this.success,
        this.message
      });

  factory UserExistResponse.fromJson(Map<String, dynamic> json) =>
      _$UserExistResponseFromJson(json);

}