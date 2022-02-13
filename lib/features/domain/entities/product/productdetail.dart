import 'package:gbjatolye/features/domain/entities/product/RequestId.dart';
import 'package:gbjatolye/features/domain/entities/product/productOld.dart';
import 'package:json_annotation/json_annotation.dart';
part 'productdetail.g.dart';

@JsonSerializable()
class ProductDetailRequest {

  String id;

  ProductDetailRequest(
      {
        this.id,
      });

  Map<String, dynamic> toJson() => _$ProductDetailRequestToJson(this);

}

@JsonSerializable()
class ProductDetailResponse {

  bool success;
  String message;
  ProductOld product;

  ProductDetailResponse(
      {
        this.success,
        this.message,
        this.product
      });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailResponseFromJson(json);

}

/*
@JsonSerializable()
class ProductDetailUpdateRequest {

  String productid;

  @JsonKey(includeIfNull: false)
  String jewelrytypeid;

  String ispackage;

  @JsonKey(includeIfNull: false)
  String description;

  String weight;

  String totalcost;

  String subtype;

  String packagequantity;

  @JsonKey(includeIfNull: false)
  List<SelectedDetailOptionRequest> specifications;

  @JsonKey(includeIfNull: false)
  List<SelectedDetailOptionRequest> sizes;

  ProductDetailUpdateRequest(
      {
        this.productid,
        this.jewelrytypeid,
        this.ispackage,
        this.description,
        this.weight,
        this.totalcost,
        this.subtype,
        this.packagequantity,
        this.specifications,
        this.sizes
      });

  Map<String, dynamic> toJson() => _$ProductDetailUpdateRequestToJson(this);

}


@JsonSerializable()
class SelectedDetailOptionRequest {
  String id;
  SelectedDetailOptionRequest(
      {
        this.id,
      });
  Map<String, dynamic> toJson() => _$SelectedDetailOptionRequestToJson(this);
}
*/

@JsonSerializable()
class ProductDetailUpdateRequest {

  int productid;

  int productid2;

  @JsonKey(includeIfNull: false)
  int jewelrytypeid;

  @JsonKey(includeIfNull: false)
  bool ispackage;

  @JsonKey(includeIfNull: false)
  String description;

  @JsonKey(includeIfNull: false)
  double weight;

  @JsonKey(includeIfNull: false)
  double totalcost;

  @JsonKey(includeIfNull: false)
  bool subtype;



  @JsonKey(includeIfNull: false)
  List<SelectedDetailOptionRequest> specifications;

  @JsonKey(includeIfNull: false)
  List<SelectedDetailOptionRequest> sizes;
  @JsonKey(includeIfNull: false)
  int bulkQentity;

  @JsonKey(includeIfNull: false)
  int bulkQentity2;

  @JsonKey(includeIfNull: false)
   double bulkCost;

  @JsonKey(includeIfNull: false)
  double bulkCost2;

  @JsonKey(includeIfNull: false)
  int variantId;

 @JsonKey(includeIfNull: false)
 List<Map> designTypes;

  @JsonKey(includeIfNull: false)
  List<Map> spectListRequest;

  @JsonKey(includeIfNull: false)
  List<IdToJson> optionidlist;

  @JsonKey(includeIfNull: false)
  int minOrderQ;

  @JsonKey(includeIfNull: false)
  int cosType;

  @JsonKey(includeIfNull: false)
  int mixQuantity;

  @JsonKey(includeIfNull: false)
  List<Map> avaliableOptionList;


  @JsonKey(includeIfNull: false)
  List<Map> sizeList;



  ProductDetailUpdateRequest(
      {
        this.designTypes,
        this.variantId,
        this.bulkQentity2,
        this.bulkQentity,
        this.bulkCost,
        this.bulkCost2,
        this.productid,
        this.ispackage,
        this.weight,
        this.totalcost,
        this.spectListRequest,
        this.minOrderQ,
        this.cosType,
        this.mixQuantity,
        this.optionidlist,
        this.productid2,
        this.avaliableOptionList,
        this.sizeList

      });

  Map<String, dynamic> toJson() => _$ProductDetailUpdateRequestToJson(this);

}


@JsonSerializable()
class SelectedDetailOptionRequest {

  int id;

  SelectedDetailOptionRequest(
      {
        this.id,
      });
  Map<String, dynamic> toJson() => _$SelectedDetailOptionRequestToJson(this);
}


@JsonSerializable()
class ProductDetailUpdateResponse {

  bool success;
  String message;

  ProductDetailUpdateResponse(
      {
        this.success,
        this.message
      });

  factory ProductDetailUpdateResponse.fromJson(Map<String, dynamic> json) => _$ProductDetailUpdateResponseFromJson(json);

}

class AvailableRequest{
  int optionGroupId;
  List<int> optionIdList;
  AvailableRequest({this.optionGroupId, this.optionIdList});

  Map<String, dynamic> toJsonRequestId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionidlist'] = this.optionIdList;
    data['optiongroupid'] = this.optionGroupId;
    return data;
}}
