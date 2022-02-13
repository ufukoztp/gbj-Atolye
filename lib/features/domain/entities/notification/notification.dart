import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class NotificationRequest {
  String page;

  NotificationRequest({
    this.page,
  });

  Map<String, dynamic> toJson() => _$NotificationRequestToJson(this);
}

@JsonSerializable()
class NotificationResponse {
  List<NotificationItem> notificationlist;
  bool success;
  String message;
  int pagecount;
  int recordcount;

  NotificationResponse(this.notificationlist, this.success, this.message,
      this.pagecount, this.recordcount);

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}

@JsonSerializable()
class NotificationItem {
  int id;
  String title;
  String body;
  String type;
  String route;
  String date;
  int badge;
  String sound;
  int orderid;
  int productid;
  String image;
  bool hasread;
  int jewelrytypeid;
  bool subtype;

  NotificationItem(
      {this.id,
      this.title,
      this.body,
      this.type,
      this.badge,
      this.date,
      this.sound,
      this.orderid,
      this.productid,
      this.route,
      this.image,
      this.hasread,
      this.jewelrytypeid,
      this.subtype,
      });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}
