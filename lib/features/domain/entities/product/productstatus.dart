import 'package:json_annotation/json_annotation.dart';
part 'productstatus.g.dart';


@JsonSerializable()
class ProductStatusRequest {

  List<int> productidlist;

  ProductStatusRequest(
      {
        this.productidlist
      }

      );

  Map<String, dynamic> toJson() => _$ProductStatusRequestToJson(this);

}

@JsonSerializable()
class ProductStatusResponse {

  bool success;
  String message;

  ProductStatusResponse(this.success,this.message);

  factory ProductStatusResponse.fromJson(Map<String, dynamic> json) => _$ProductStatusResponseFromJson(json);

}
