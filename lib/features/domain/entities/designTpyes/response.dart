import 'package:gbjatolye/features/domain/entities/designTpyes/product.dart';

class DetailProduct {
  String message;
  bool success;
	ProductDetail product;

	DetailProduct.fromJsonMap(Map<String, dynamic> map):
		success = map["success"],
		product = ProductDetail.fromJsonMap(map["product"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = success;
		data['product'] = product == null ? null : product.toJson();
		return data;
	}
}
