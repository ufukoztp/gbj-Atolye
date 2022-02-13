import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';


@JsonSerializable()
class TicketResponse {

  List<Ticket> ticketlist;
  bool success;
  String message;

  TicketResponse(this.ticketlist, this.success, this.message);

  factory TicketResponse.fromJson(Map<String, dynamic> json) =>
      _$TicketResponseFromJson(json);

}

@JsonSerializable()
class Ticket {

  int ticketid;
  int connectedid;
  String ticketdetail;
  String image;
  String createdate;
  int priority;
  int type;

  Ticket(
      {
        this.ticketid,
        this.connectedid,
        this.ticketdetail,
        this.image,
        this.createdate,
        this.priority,
        this.type,
      });

  factory Ticket.fromJson(Map<String, dynamic> json) =>
      _$TicketFromJson(json);

}
