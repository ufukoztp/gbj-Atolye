import 'package:json_annotation/json_annotation.dart';

part 'id.g.dart';

@JsonSerializable()
class Id {

  int id;

  Id({this.id});

  Map<String, dynamic> toJson() => _$IdToJson(this);


}
