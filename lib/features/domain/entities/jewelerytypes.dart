
class JeweleryResponse {
	String message;
  bool success;
  List<Jewelrytypes> jewelrytypes;

	JeweleryResponse.fromJsonMap(Map<String, dynamic> map):
			message=map["message"],
		success = map["success"],
		jewelrytypes = List<Jewelrytypes>.from(map["jewelrytypes"].map((it) => Jewelrytypes.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = success;
		data['jewelrytypes'] = jewelrytypes != null ? 
			this.jewelrytypes.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}


class Jewelrytypes {
	bool exp=false;
	bool state;
	int totalproductcount;
	int id;
	String name;
	String bannerimage;
	String collectiongroupname;
	int sequence;
	List<Subjewelrytypes> subjewelrytypes;

	Jewelrytypes.fromJsonMap(Map<String, dynamic> map):
				id = map["id"],
				totalproductcount = map["totalproductcount"],
				name = map["name"],
				bannerimage = map["bannerimage"],
				sequence = map["sequence"],
				collectiongroupname=map["collectiongroupname"],
				subjewelrytypes = List<Subjewelrytypes>.from(map["subjewelrytypes"].map((it) => Subjewelrytypes.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['totalproductcount'] = totalproductcount;
		data['bannerimage'] = bannerimage;
		data['sequence'] = sequence;
		data['subjewelrytypes'] = subjewelrytypes != null ?
		this.subjewelrytypes.map((v) => v.toJson()).toList()
				: null;
		return data;
	}
}
class SubJeweleryResponse {
String message;
bool success;
List<Subjewelrytypes> jewelrytypes;

SubJeweleryResponse.fromJsonMap(Map<String, dynamic> map):
message=map["message"],
success = map["success"],
jewelrytypes = List<Subjewelrytypes>.from(map["subjewelrytypes"].map((it) => Subjewelrytypes.fromJsonMap(it)));

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['success'] = success;
data['subjewelrytypes'] = jewelrytypes != null ?
this.jewelrytypes.map((v) => v.toJson()).toList()
		: null;
return data;
}

}

class Subjewelrytypes {
	String message;
  bool success;
	int id;
	String name;
	String bannerimage;
	int sequence;
	String icon;
	int productCount;

	Subjewelrytypes.fromJsonMap(Map<String, dynamic> map):
			icon=map["icon"],
				id = map["id"],
				success = map["success"],
				name = map["name"],
				message = map["message"],
				bannerimage = map["bannerimage"],
				productCount = map["productCount"],
				sequence = map["sequence"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['bannerimage'] = bannerimage;
		data['productCount'] = productCount;
		data['sequence'] = sequence;
		return data;
	}
}
