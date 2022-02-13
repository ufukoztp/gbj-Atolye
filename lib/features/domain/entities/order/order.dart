import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';


@JsonSerializable()
class OrderResponseOld {

  bool success;
  String message;
  List<Order> orderlist;

  OrderResponseOld(this.orderlist, this.success, this.message);

  factory OrderResponseOld.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

}

@JsonSerializable()
class Order {

  int orderid;
  String orderdate;
  List<OrderProduct> productlist;

  Order(
      {
        this.orderid,
        this.orderdate,
        this.productlist,
      });

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);

}


@JsonSerializable()
class OrderProduct {

  int id;
  String productcode;
  double cost;
  double weight;
  int totalquantity;
  int quantity;
  int orderstatus;
  String productsize;
  String note;
  String image;
  String jewelrytype;
  String packagequantity;
  String orderdate;
  bool selected=false;

  OrderProduct(
      {
        this.id,
        this.productcode,
        this.cost,
        this.weight,
        this.totalquantity,
        this.quantity,
        this.orderstatus,
        this.productsize,
        this.note,
        this.image,
        this.jewelrytype,
        this.packagequantity,
        this.orderdate,
      });

  factory OrderProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderProductFromJson(json);

}