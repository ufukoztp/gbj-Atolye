import 'package:gbjatolye/features/domain/entities/product/options.dart';

class OptionGroups {

  int id;
  String name;
  bool multiselect;
  String header;
  List<Options> options;
  bool changed=false;

  OptionGroups({this.header,this.options,this.name,this.id,this.changed,this.multiselect});

	OptionGroups.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		multiselect = map["multiselect"],
		header = map["header"],
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
