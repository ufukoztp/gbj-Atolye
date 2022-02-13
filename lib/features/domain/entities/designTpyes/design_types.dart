import 'package:gbjatolye/features/domain/entities/designTpyes/options.dart';

class DesignProduct {

  int id;
  String name;
  bool multiselect;
  bool required;
  List<OptionProduct> options;

	DesignProduct.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		multiselect = map["multiselect"],
		required = map["required"],
		options = List<OptionProduct>.from(map["options"].map((it) => OptionProduct.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['multiselect'] = multiselect;
		data['required'] = required;
		data['options'] = options != null ? 
			this.options.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
