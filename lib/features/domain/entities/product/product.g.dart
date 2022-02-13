// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productOld.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



Map<String, dynamic> _$ProductRequestToJson(ProductRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'subtype': instance.subtype,
      'jewelrytypeid': instance.jewelrytypeid,
      'collectiongroupid': instance.collectionGroupId
    };

ProductOldResponse _$ProductResponseFromJson(Map<String, dynamic> json) {
  return ProductOldResponse(
    (json['productlist'] as List)
        ?.map((e) =>
            e == null ? null : ProductOld.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['success'] as bool,
    json['message'] as String,
    json['pagecount'] as int,
    json['recordcount'] as int,
  );
}


ProductOld _$ProductFromJson(Map<String, dynamic> json) {
  return ProductOld(
    id: json['id'] as int,
    createdate: json['createdate'] as String,
    updatedate: json['updatedate'] as String,
    productcode: json['productcode'] as String,
    boxno: json['boxno'] as String,
    moldno: json['moldno'] as String,
    weight: (json['weight'] as num)?.toDouble(),
    costtypeid: json['costtypeid'] as int,
    percost: (json['percost'] as num)?.toDouble(),
    totalcost: (json['totalcost'] as num)?.toDouble(),
    isactive: json['isactive'] as bool,
    productstatusid: json['productstatusid'] as int,
    supplierid: json['supplierid'] as int,
    description: json['description'] as String,
    ispackage: json['ispackage'] as bool,
    packagequantity: json['packagequantity'] as int,
    stockquantity: json['stockquantity'] as int,
    iscompleted: json['iscompleted'] as bool,
    vatpercentage: (json['vatpercentage'] as num)?.toDouble(),
    currencyid: json['currencyid'] as int,
    profitrateid: json['profitrateid'] as int,
    minimumorderquantity: json['minimumorderquantity'] as int,
    imagelist: (json['imagelist'] as List)?.map((e) => e as String)?.toList(),
    likecount: json['likecount'] as int,
    salesprice: (json['salesprice'] as num)?.toDouble(),
    sizes: (json['sizes'] as List)
        ?.map((e) =>
            e == null ? null : SizeGroup.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    specifications: (json['specifications'] as List)
        ?.map((e) => e == null
            ? null
            : SpecificationGroup.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
  )..selected = json['selected'] as bool;
}


SpecificationGroup _$SpecificationGroupFromJson(Map<String, dynamic> json) {
  return SpecificationGroup(
    titleid: json['titleid'] as int,
    titlename: json['titlename'] as String,
    multiselect: json['multiselect'] as bool,
    specifications: (json['specifications'] as List)
        ?.map((e) => e == null
            ? null
            : Specification.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}


Specification _$SpecificationFromJson(Map<String, dynamic> json) {
  return Specification(
    id: json['id'] as int,
    name: json['name'] as String,
    selected: json['selected'] as bool,
    icon: json['icon'] as String,
  );
}



SizeGroup _$SizeGroupFromJson(Map<String, dynamic> json) {
  return SizeGroup(
    sizetitlename: json['sizetitlename'] as String,
    sizes: (json['sizes'] as List)
        ?.map(
            (e) => e == null ? null : Size.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isdefault: json['isdefault'] as bool,
  );
}


Size _$SizeFromJson(Map<String, dynamic> json) {
  return Size(
    sizeid: json['sizeid'] as int,
    name: json['name'] as String,
    selected: json['selected'] as bool,
  );
}

