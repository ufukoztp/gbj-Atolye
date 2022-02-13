import 'package:gbjatolye/features/domain/entities/collection_groups.dart';

class Model {

  int supplierId;
  String currency;
  List<CollectionGroups> collectionGroups;

	Model.fromJsonMap(Map<String, dynamic> map): 
		supplierId = map["supplierId"],
		currency = map["currency"],
		collectionGroups = List<CollectionGroups>.from(map["collectionGroups"].map((it) => CollectionGroups.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['supplierId'] = supplierId;
		data['collectionGroups'] = collectionGroups != null ? 
			this.collectionGroups.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
