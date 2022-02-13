import 'package:json_annotation/json_annotation.dart';
part 'homecategory.g.dart';

@JsonSerializable()
class HomeCategory{
 final int collectionGroupId;
 final String jeweleryType;
 final String subCategory;
  final String titleName;
  final bool subtype;
  final int jewelrytypeid;
  final int supplierId;

  HomeCategory({this.subCategory,this.supplierId,this.collectionGroupId,this.jewelrytypeid, this.titleName,this.subtype,this.jeweleryType});

  factory HomeCategory.fromJson(Map<String, dynamic> json) => _$HomeCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$HomeCategoryToJson(this);

}