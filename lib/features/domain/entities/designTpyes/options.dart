
class OptionProduct {

  int id;
  String name;
  bool selected;
  Object icon;

	OptionProduct.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		name = map["name"],
		selected = map["selected"],
		icon = map["icon"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['selected'] = selected;
		data['icon'] = icon;
		return data;
	}
}
