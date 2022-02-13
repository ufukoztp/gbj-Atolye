import 'package:gbjatolye/features/domain/entities/product/options.dart';

class DesignTypes {

  int id;
  String name;
  bool multiselect;
  List<Options> options;

	DesignTypes.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		multiselect = map["multiselect"],
		options = List<Options>.from(map["options"].map((it) => Options.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['multiselect'] = multiselect;
		data['options'] = options != null ? 
			this.options.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
