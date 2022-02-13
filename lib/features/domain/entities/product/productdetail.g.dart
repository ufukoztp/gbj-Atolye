// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$ProductDetailRequestToJson(
        ProductDetailRequest instance) =>
    <String, dynamic>{
      'Id': instance.id,
    };

ProductDetailResponse _$ProductDetailResponseFromJson(
    Map<String, dynamic> json) {
  return ProductDetailResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    product: json['product'] == null
        ? null
        : ProductOld.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductDetailUpdateRequestToJson(
    ProductDetailUpdateRequest instance) {
  final val = <String, dynamic>{
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ProductId', instance.productid);
  writeNotNull('isPackage', instance.ispackage);
  writeNotNull('weight', instance.weight);
  writeNotNull('productId', instance.productid);
  writeNotNull('productid', instance.productid2);
  writeNotNull('cost', instance.totalcost);
  writeNotNull('isPackage', instance.ispackage);
  writeNotNull('bulkCost', instance.bulkCost);
  writeNotNull('bulkCost2', instance.bulkCost2);
  writeNotNull('bulkQuantity2', instance.bulkQentity2);
  writeNotNull('bulkQuantity', instance.bulkQentity);
  writeNotNull('variantId', instance.variantId);
  writeNotNull('designTypes', instance.designTypes);
  writeNotNull('spectListDtos', instance.spectListRequest);
  writeNotNull('minimumOrderQuantity', instance.minOrderQ);
  writeNotNull('costType', instance.cosType);
  writeNotNull('isPackage', instance.ispackage);
  writeNotNull('mixQuantity', instance.mixQuantity);
  writeNotNull('optionidlist', instance.optionidlist);
  writeNotNull('optiongrouplist', instance.avaliableOptionList);
  writeNotNull('sizeList', instance.sizeList);

  return val;
}



Map<String, dynamic> _$SelectedDetailOptionRequestToJson(
        SelectedDetailOptionRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

ProductDetailUpdateResponse _$ProductDetailUpdateResponseFromJson(
    Map<String, dynamic> json) {
  return ProductDetailUpdateResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
  );
}
