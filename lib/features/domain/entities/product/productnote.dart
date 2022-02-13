import 'package:json_annotation/json_annotation.dart';

part 'productnote.g.dart';

@JsonSerializable()
class ProductNoteRequest {

  String variantId;
  String note;

  ProductNoteRequest(
      {
        this.variantId,
        this.note
      });

  Map<String, dynamic> toJson() => _$ProductNoteRequestToJson(this);

}

@JsonSerializable()
class ProductNoteResponse {

  bool success;
  String message;

  ProductNoteResponse(this.success,this.message);

  factory ProductNoteResponse.fromJson(Map<String, dynamic> json) => _$ProductNoteResponseFromJson(json);

}
