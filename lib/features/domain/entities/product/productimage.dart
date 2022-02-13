import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
part 'productimage.g.dart';


class ProductImageRequest {

  List<File> imagelist;
  int jewelrytypeid;
  bool subtype;

  ProductImageRequest(
      {
        this.imagelist,
        this.jewelrytypeid,
        this.subtype
      });

}

@JsonSerializable()
class ProductImageResponse {

  bool success;
  String message;

  ProductImageResponse(this.success,this.message);

  factory ProductImageResponse.fromJson(Map<String, dynamic> json) => _$ProductImageResponseFromJson(json);

}
