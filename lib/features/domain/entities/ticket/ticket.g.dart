// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketResponse _$TicketResponseFromJson(Map<String, dynamic> json) {
  return TicketResponse(
    (json['ticketlist'] as List)
        ?.map((e) =>
            e == null ? null : Ticket.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['success'] as bool,
    json['message'] as String,
  );
}


Ticket _$TicketFromJson(Map<String, dynamic> json) {
  return Ticket(
    ticketid: json['ticketid'] as int,
    connectedid: json['connectedid'] as int,
    ticketdetail: json['ticketdetail'] as String,
    image: json['image'] as String,
    createdate: json['createdate'] as String,
    priority: json['priority'] as int,
    type: json['type'] as int,
  );
}

