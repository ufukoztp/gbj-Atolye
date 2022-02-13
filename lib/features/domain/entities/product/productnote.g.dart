// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productnote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Map<String, dynamic> _$ProductNoteRequestToJson(ProductNoteRequest instance) =>
    <String, dynamic>{
      'Id': instance.variantId,
      'Note': instance.note,
    };

ProductNoteResponse _$ProductNoteResponseFromJson(Map<String, dynamic> json) {
  return ProductNoteResponse(
    json['success'] as bool,
    json['message'] as String,
  );
}

