// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



Map<String, List<int>> _$ProductStatusRequestToJson(
        ProductStatusRequest instance) =>
    <String, List<int>>{
      'body': instance.productidlist,
    };

ProductStatusResponse _$ProductStatusResponseFromJson(
    Map<String, dynamic> json) {
  return ProductStatusResponse(
    json['success'] as bool,
    json['message'] as String,
  );
}

