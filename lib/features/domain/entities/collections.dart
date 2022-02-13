import 'package:gbjatolye/features/domain/entities/collection_groups.dart';

class Collections {
  String messages;
  bool success;
  List<CollectionGroups> collectionGroups;

	Collections.fromJsonMap(Map<String, dynamic> map){
		success = map["success"];
		messages=map['messages'];

		collectionGroups = List<CollectionGroups>.from(map["collectionGroups"].map((it) => CollectionGroups.fromJsonMap(it)));
	}

	Map<String, dynamic> collectionsToJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['success'] = success;
		data['collectionGroups'] = collectionGroups != null ? 
			this.collectionGroups.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
