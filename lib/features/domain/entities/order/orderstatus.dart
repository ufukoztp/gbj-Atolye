import 'package:json_annotation/json_annotation.dart';
import '../id.dart';

part 'orderstatus.g.dart';

@JsonSerializable()
class OrderStatusRequestOld {

  String supplierorderstatus;
  List<Id> idlist;

  OrderStatusRequestOld({
    this.supplierorderstatus,
    this.idlist
  });

  Map<String, dynamic> toJson() => _$OrderStatusRequestToJson(this);

}

@JsonSerializable()
class OrderStatusResponse {

  bool success;
  String message;

  OrderStatusResponse(this.success, this.message);

  factory OrderStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusResponseFromJson(json);

}