import 'package:gbjatolye/features/domain/entities/product/option_groups.dart';

class OtherOption {

  bool success;
  List<OptionGroups> optionGroups;
  String message;
  OtherOption();

	OtherOption.fromJsonMap(Map<String, dynamic> map):
			message=map["message"],
		success = map["success"],
		optionGroups = List<OptionGroups>.from(map["optionGroups"].map((it) => OptionGroups.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = success;
		data['optionGroups'] = optionGroups != null ? 
			this.optionGroups.map((v) => v.toJson()).toList()
			: null;
		return data;
	}

	toJsonId(productId,variantId){
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Id'] = productId;
		data['VariantId'] = variantId;

		return data;

	}
}
