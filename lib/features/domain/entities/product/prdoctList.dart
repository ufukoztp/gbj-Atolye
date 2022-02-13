 import 'package:gbjatolye/features/domain/entities/product/productswithlist.dart';

class ProductList {

  bool success;
  List<ProductsWithList> products;
  String message;

	ProductList.fromJsonMap(Map<String, dynamic> map):
			message=map["message"],
		success = map["success"],
		products = List<ProductsWithList>.from(map["products"].map((it) => ProductsWithList.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = success;
		data['products'] = products != null ? 
			this.products.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
