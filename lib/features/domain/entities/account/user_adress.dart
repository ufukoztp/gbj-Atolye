import 'package:json_annotation/json_annotation.dart';

part 'user_adress.g.dart';

@JsonSerializable()
class UserAdressRequest {

  String userid;

  String countrycode;

  @JsonKey(includeIfNull: false)
  String city;

  @JsonKey(includeIfNull: false)
  String district;

  @JsonKey(includeIfNull: false)
  String address;

  @JsonKey(includeIfNull: false)
  String zipcode;

  @JsonKey(includeIfNull: false)
  String password;

  @JsonKey(includeIfNull: false)
  String phone;

  UserAdressRequest(
      {
        this.userid,
        this.countrycode,
        this.city,
        this.district,
        this.address,
        this.zipcode,
      });

  Map<String, dynamic> toJson() => _$UserAdressRequestToJson(this);

}

@JsonSerializable()
class UserAdressResponse {

  bool success;
  String message;

  UserAdressResponse(
      {
        this.success,
        this.message
      });

  factory UserAdressResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAdressResponseFromJson(json);

}
