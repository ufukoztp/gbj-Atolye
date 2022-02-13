import 'package:gbjatolye/features/domain/entities/product/options.dart';

class PersonalizeOptions {

  int id;
  String name;
  bool multiselect;
  String stoneName;
  bool required;
  bool customize;
  List<Options>options;




  bool changed=false;

  PersonalizeOptions({this.stoneName,this.options,this.name,this.id,this.changed,this.multiselect});

	PersonalizeOptions.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
				customize = map["customize"],
		required = map["required"],
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
