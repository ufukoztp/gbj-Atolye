import 'package:gbjatolye/features/domain/entities/product/design_types_response2.dart';

class DesignTypesHome {
  bool success;
  DesignTypes designTypes;

	DesignTypesHome.fromJsonMap(Map<String, dynamic> map):
		success = map["success"],
		designTypes = DesignTypes.fromJsonMap(map["designTypes"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = success;
		data['designTypes'] = designTypes == null ? null : designTypes.toJson();
		return data;
	}
}
