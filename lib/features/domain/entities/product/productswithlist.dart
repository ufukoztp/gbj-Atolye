
class ProductsWithList {

  int variantId;
  int productId;
  int status;
  String updateDate;
  String blobUrl;
  int likeCount;
  String lastLikeDate;
	bool selected = false;
	int parentId;
	int jeweleryTypeId;


	ProductsWithList.fromJsonMap(Map<String, dynamic> map): 
		variantId = map["variantId"],
		productId = map["productId"],
		status = map["status"],
		updateDate = map["updateDate"],
		blobUrl = map["blobUrl"],
		likeCount = map["likeCount"],
		parentId = map["parentId"],
		jeweleryTypeId = map["jeweleryTypeId"],
		lastLikeDate = map["lastLikeDate"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['variantId'] = variantId;
		data['productId'] = productId;
		data['status'] = status;
		data['updateDate'] = updateDate;
		data['blobUrl'] = blobUrl;
		data['likeCount'] = likeCount;
		data['lastLikeDate'] = lastLikeDate;
		return data;
	}
}
