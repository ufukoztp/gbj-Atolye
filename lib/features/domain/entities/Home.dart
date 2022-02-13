import 'package:gbjatolye/features/domain/entities/collection_gruop.dart';

class Home {
	String messages;
  bool success;
  Model model;

	Home.fromJsonMap(Map<String, dynamic> map):
		messages=map["messages"],
		success = map["success"],
		model = Model.fromJsonMap(map["model"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = success;
		data['model'] = model == null ? null : model.toJson();
		return data;
	}
}
