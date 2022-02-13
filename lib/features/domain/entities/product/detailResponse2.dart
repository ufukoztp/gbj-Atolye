import 'package:gbjatolye/features/domain/entities/designTpyes/design_types.dart';
import 'package:gbjatolye/features/domain/entities/designTpyes/spect_list_dtos.dart';

class Product {

  int productId;
  int variantId;
  int mixQuantity;
  double weight;
  String note;
  int costType;
  String productType;
  bool isPackage;
  double cost;
  int minimumOrderQuantity;
  int bulkQuantity;
  String productStatus;
  double bulkCost;
  String blobUrl;
  int bulkQuantity2;
  int jewelryTypeId;
  double bulkCost2;
  List<SpectListDtos> spectListDtos;
  List<SpectListDtos> optionList;
  List<DesignProduct> designTypes;
  List<SpectListDtos> sizeList;

  Product.fromJsonMap(Map<String, dynamic> map):
        productId = map["productId"],
        blobUrl = map["blobUrl"],
        productStatus = map["productStatus"],
        jewelryTypeId = map["jewelryTypeId"],
        variantId = map["variantId"],
        mixQuantity = map["mixQuantity"],
        isPackage = map["isPackage"],
        weight = map["weight"],
        note = map["note"],
        costType = map["costType"],
        productType = map["productType"],
        cost = map["cost"],
        minimumOrderQuantity = map["minimumOrderQuantity"],
        bulkQuantity = map["bulkQuantity"],
        bulkCost = map["bulkCost"],
        bulkQuantity2 = map["bulkQuantity2"],
        bulkCost2 = map["bulkCost2"],
        designTypes = List<DesignProduct>.from(map["designTypes"].map((it) => DesignProduct.fromJsonMap(it))),
        sizeList = List<SpectListDtos>.from(map["sizeList"].map((it) => SpectListDtos.fromJsonMap(it))),
        spectListDtos = List<SpectListDtos>.from(map["spectListDtos"].map((it) => SpectListDtos.fromJsonMap(it))),
        optionList = List<SpectListDtos>.from(map["optionList"].map((it) => SpectListDtos.fromJsonMap(it)));


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = productId;
    data['variantId'] = variantId;
    data['mixQuantity'] = mixQuantity;
    data['weight'] = weight;
    data['costType'] = costType;
    data['productType'] = productType;
    data['note'] = note;
    data['isPackage'] = isPackage;
    data['cost'] = cost;
    data['minimumOrderQuantity'] = minimumOrderQuantity;
    data['bulkQuantity'] = bulkQuantity;
    data['bulkCost'] = bulkCost;
    data['bulkQuantity2'] = bulkQuantity2;
    data['bulkCost2'] = bulkCost2;
    data['spectListDtos'] = spectListDtos != null ?
    this.spectListDtos.map((v) => v.toJson()).toList()
        : null;
    data['designTypes'] = designTypes != null ?
    this.designTypes.map((v) => v.toJson()).toList()
        : null;
    return data;
  }
}
