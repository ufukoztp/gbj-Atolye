import 'package:gbjatolye/features/domain/entities/product/personalize_options.dart';

class Opsiyonlar {
  String message;
  bool success;
  List<PersonalizeOptions> personalizeOptions;
  Opsiyonlar();

	Opsiyonlar.fromJsonMap(Map<String, dynamic> map):
			message=map["message"],
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

	Map<String,dynamic> toJsonId(String jeweleryId,String variantId,List<String> designId){

		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["id"]=jeweleryId.toString();
		data["VariantId"]=variantId.toString();
		return data;

	}
}
