import 'package:gbjatolye/features/domain/entities/product/personalize_options.dart';

class Response {

  bool success;
  List<PersonalizeOptions> personalizeOptions;

	Response.fromJsonMap(Map<String, dynamic> map): 
		success = map["success"],
		personalizeOptions = List<PersonalizeOptions>.from(map["personalizeOptions"].map((it) => PersonalizeOptions.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = success;
		data['personalizeOptions'] = personalizeOptions != null ? 
			this.personalizeOptions.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
