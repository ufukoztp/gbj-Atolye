
class Options {

  int id;
  String name;
  bool selected;
  String icon;
  int stoneId;
  String stoneName;

	Options.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		selected = map["selected"],
		stoneId = map["stoneid"],
		stoneName = map["stonename"],
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
