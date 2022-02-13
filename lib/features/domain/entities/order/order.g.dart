// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponseOld _$OrderResponseFromJson(Map<String, dynamic> json) {
  return OrderResponseOld(
    (json['orderlist'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['success'] as bool,
    json['message'] as String,
  );
}


Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    orderid: json['orderid'] as int,
    orderdate: json['orderdate'] as String,
    productlist: (json['productlist'] as List)
        ?.map((e) =>
            e == null ? null : OrderProduct.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}


OrderProduct _$OrderProductFromJson(Map<String, dynamic> json) {
  return OrderProduct(
    id: json['id'] as int,
    productcode: json['productcode'] as String,
    cost: (json['cost'] as num)?.toDouble(),
    weight: (json['weight'] as num)?.toDouble(),
    totalquantity: json['totalquantity'] as int,
    quantity: json['quantity'] as int,
    orderstatus: json['orderstatus'] as int,
    productsize: json['productsize'] as String,
    note: json['note'] as String,
    image: json['image'] as String,
    jewelrytype: json['jewelrytype'] as String,
    packagequantity: json['packagequantity'] as String,
    orderdate: json['orderdate'] as String,
  )..selected = json['selected'] as bool;
}

