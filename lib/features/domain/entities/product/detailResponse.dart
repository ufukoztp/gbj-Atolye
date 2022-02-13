import 'package:gbjatolye/features/domain/entities/product/detailResponse2.dart';
class DetailResponse {

  bool success;
  Product product;
  String message;

	DetailResponse.fromJsonMap(Map<String, dynamic> map):
			message=map["message"],
		success = map["success"],
		product = Product.fromJsonMap(map["product"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = success;
		data['product'] = product == null ? null : product.toJson();
		return data;
	}
}
