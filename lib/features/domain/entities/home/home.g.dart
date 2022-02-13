// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) {
  return HomeResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    ordercount: json['ordercount'] as int,
    notificationcount: json['notificationcount'] as int,
    categorylist: (json['categorylist'] as List)
        ?.map((e) =>
            e == null ? null : CategoryList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pricetype: json['pricetype'] as String,
  );
}


CategoryList _$CategoryListFromJson(Map<String, dynamic> json) {
  return CategoryList(
    id: json['id'] as int,
    name: json['name'] as String,
    bannerimage: json['bannerimage'] as String,
    subcategorylist: (json['subcategorylist'] as List)
        ?.map((e) => e == null
            ? null
            : SubCategoryList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}


SubCategoryList _$SubCategoryListFromJson(Map<String, dynamic> json) {
  return SubCategoryList(
    id: json['id'] as int,
    name: json['name'] as String,
    icon: json['icon'] as String,
  );
}

