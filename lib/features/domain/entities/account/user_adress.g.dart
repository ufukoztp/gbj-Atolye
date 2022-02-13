// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_adress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
/*
UserAdressRequest _$UserAdressRequestFromJson(Map<String, dynamic> json) {
  return UserAdressRequest(
    userid: json['userid'] as String,
    countrycode: json['countrycode'] as String,
    city: json['city'] as String,
    district: json['district'] as String,
    address: json['address'] as String,
    zipcode: json['zipcode'] as String,
  )
    ..password = json['password'] as String
    ..phone = json['phone'] as String;
}
*/
Map<String, dynamic> _$UserAdressRequestToJson(UserAdressRequest instance) {
  final val = <String, dynamic>{
    'userid': instance.userid,
    'countrycode': instance.countrycode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('city', instance.city);
  writeNotNull('district', instance.district);
  writeNotNull('address', instance.address);
  writeNotNull('zipcode', instance.zipcode);
  writeNotNull('password', instance.password);
  writeNotNull('phone', instance.phone);
  return val;
}

UserAdressResponse _$UserAdressResponseFromJson(Map<String, dynamic> json) {
  return UserAdressResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
  );
}
/*
Map<String, dynamic> _$UserAdressResponseToJson(UserAdressResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
*/