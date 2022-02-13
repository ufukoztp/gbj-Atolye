import 'package:json_annotation/json_annotation.dart';
part 'currency.g.dart';

@JsonSerializable()
class CurrencyResponse {

 List<Currency> currencylist;
 bool success;
 String message;
 CurrencyResponse(this.currencylist, this.success,this.message);

 factory CurrencyResponse.fromJson(Map<String, dynamic> json) => _$CurrencyResponseFromJson(json);

}

@JsonSerializable()
class Currency{

  final int id;
  final String name;

  Currency({this.id, this.name});

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);

}