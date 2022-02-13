// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homecategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCategory _$HomeCategoryFromJson(Map<String, dynamic> json) {
  return HomeCategory(
    supplierId: json['supplierId'],
    collectionGroupId:json['collectionGroupId'] as int ,
    jewelrytypeid: json['jewelrytypeid'] as int,
    jeweleryType: json['jeweleryType'] as String,
    titleName: json['titleName'] as String,
    subtype: json['subtype'] as bool,
  );
}

Map<String, dynamic> _$HomeCategoryToJson(HomeCategory instance) =>
    <String, dynamic>{
  'supplierId':instance.supplierId,
     'collectionGroupId': instance.collectionGroupId,
     'jeweleryType': instance.jeweleryType,
      'titleName': instance.titleName,
      'subtype': instance.subtype,
      'jewelrytypeid': instance.jewelrytypeid,
    };
