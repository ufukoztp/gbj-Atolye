
class IdToJson{
  IdToJson({this.id,this.id2});

  int id;
  String id2;
 Map<String, dynamic> toJsonRequestid() {
   final Map<String, dynamic> data = new Map<String, dynamic>();
   data['id'] = id;
   return data;
 }
  Map<String, dynamic> toJsonRequestId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id2;
    return data;
  }



}

class SubJeweleryId{
  SubJeweleryId({this.jeweleryId,this.collectionId});


  String jeweleryId;
  String collectionId;


  Map<String, dynamic> toJsonSubJeweleryId() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = jeweleryId;
    data['CollectionGroupId'] = collectionId;

    return data;
  }

}