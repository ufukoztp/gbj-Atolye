class SetNotification{
List<notificationId> notfList;

SetNotification({this.notfList});


Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['notificationidlist'] = notfList != null ?
  this.notfList.map((v) => v.toJson()).toList()
      : null;
  return data;
}

}

class notificationId{
  int id;

notificationId({this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;

    return data;
  }
}