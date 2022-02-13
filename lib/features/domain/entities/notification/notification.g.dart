// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$NotificationRequestToJson(
        NotificationRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
    };

NotificationResponse _$NotificationResponseFromJson(Map<String, dynamic> json) {
  return NotificationResponse(
    (json['notificationlist'] as List)
        ?.map((e) => e == null
            ? null
            : NotificationItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['success'] as bool,
    json['message'] as String,
    json['pagecount'] as int,
    json['recordcount'] as int,
  );
}


NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) {
  return NotificationItem(
    id: json['id'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
    type: json['type'] as String,
    badge: json['badge'] as int,
    date: json['date'] as String,
    sound: json['sound'] as String,
     productid: json['productid'] as int,
    route: json['route'] as String,
    image: json['image'] as String,
    hasread: json['hasread'] as bool,
    jewelrytypeid: json['jewelrytypeid'] as int,
    subtype: json['subtype'] as bool,
   );
}

