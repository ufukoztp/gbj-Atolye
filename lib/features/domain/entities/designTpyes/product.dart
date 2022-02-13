import 'package:gbjatolye/features/domain/entities/designTpyes/design_types.dart';
import 'package:gbjatolye/features/domain/entities/designTpyes/spect_list_dtos.dart';

class ProductDetail {

  int productId;
  int variantId;
  int mixQuantity;
  double weight;
  int costType;
  int productType;
  double cost;
  int minimumOrderQuantity;
  int bulkQuantity;
  double bulkCost;
  int bulkQuantity2;
  double bulkCost2;
  List<SpectListDtos> spectListDtos;
  List<DesignProduct> designTypes;

	ProductDetail.fromJsonMap(Map<String, dynamic> map):
		productId = map["productId"],
		variantId = map["variantId"],
		mixQuantity = map["mixQuantity"],
		weight = map["weight"],
		costType = map["costType"],
		productType = map["productType"],
		cost = map["cost"],
		minimumOrderQuantity = map["minimumOrderQuantity"],
		bulkQuantity = map["bulkQuantity"],
		bulkCost = map["bulkCost"],
		bulkQuantity2 = map["bulkQuantity2"],
		bulkCost2 = map["bulkCost2"],
		designTypes = List<DesignProduct>.from(map["designTypes"].map((it) => DesignProduct.fromJsonMap(it))),
	  spectListDtos = List<SpectListDtos>.from(map["spectListDtos"].map((it) => SpectListDtos.fromJsonMap(it)));


	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['productId'] = productId;
		data['variantId'] = variantId;
		data['mixQuantity'] = mixQuantity;
		data['weight'] = weight;
		data['costType'] = costType;
		data['productType'] = productType;
		data['cost'] = cost;
		data['minimumOrderQuantity'] = minimumOrderQuantity;
		data['bulkQuantity'] = bulkQuantity;
		data['bulkCost'] = bulkCost;
		data['bulkQuantity2'] = bulkQuantity2;
		data['bulkCost2'] = bulkCost2;
		data['spectListDtos'] = spectListDtos;
		data['designTypes'] = designTypes != null ? 
			this.designTypes.map((v) => v.toJson()).toList()
			: null;
		data['spectListDtos'] = spectListDtos != null ?
		this.spectListDtos.map((v) => v.toJson()).toList()
				: null;
		return data;
	}
}
