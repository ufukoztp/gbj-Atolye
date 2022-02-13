// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderstatus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$OrderStatusRequestToJson(OrderStatusRequestOld instance) =>
    <String, dynamic>{
      'supplierorderstatus': instance.supplierorderstatus,
      'idlist': instance.idlist,
    };

OrderStatusResponse _$OrderStatusResponseFromJson(Map<String, dynamic> json) {
  return OrderStatusResponse(
    json['success'] as bool,
    json['message'] as String,
  );
}

