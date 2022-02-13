class CurrencyRespons{

	bool success;
	String message;
	List<Currencies> currencies;


	CurrencyRespons({this.success, this.message,this.currencies});

  CurrencyRespons.fromJsonMap(Map<String, dynamic> map):
				success = map["success"],
				message = map["message"],
				currencies = List<Currencies>.from(map["currencies"].map((it) => Currencies.fromJsonMap(it)));

}
class Currencies {

  int id;
  String name;

	Currencies.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		return data;
	}
}