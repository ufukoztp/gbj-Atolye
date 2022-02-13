
class CollectionGroups {

  int collectionGroupId;
  String collectionGroupName;
  String description;
  String bannerLandscape;
  String bannerPortrait;
  int sequence;
  bool hasLike;

	CollectionGroups.fromJsonMap(Map<String, dynamic> map): 
		collectionGroupId = map["collectionGroupId"],
		collectionGroupName = map["collectionGroupName"],
		description = map["description"],
		bannerLandscape = map["bannerLandscape"],
		bannerPortrait = map["bannerPortrait"],
		hasLike = map["hasLike"],
		sequence = map["sequence"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['collectionGroupId'] = collectionGroupId;
		data['collectionGroupName'] = collectionGroupName;
		data['description'] = description;
		data['bannerLandscape'] = bannerLandscape;
		data['bannerPortrait'] = bannerPortrait;
		data['sequence'] = sequence;
		return data;
	}
}
