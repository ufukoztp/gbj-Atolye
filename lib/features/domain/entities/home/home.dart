import 'package:flutter/cupertino.dart';
import 'package:gbjatolye/utils/atolyeexpansiontile.dart';
import 'package:json_annotation/json_annotation.dart';
part 'home.g.dart';

@JsonSerializable()
class HomeResponse{

  final bool success;
  final String message;
  final int ordercount;
  final int notificationcount;
  final String pricetype;
   final List<CategoryList> categorylist;

  HomeResponse({this.success, this.message,this.ordercount, this.notificationcount,this.categorylist,this.pricetype});

  factory HomeResponse.fromJson(Map<String, dynamic> json) => _$HomeResponseFromJson(json);

}

@JsonSerializable()
class CategoryList{
  GlobalKey<AppExpansionTileState> globalKeytest;
  bool state;
  bool exp=false;
  int id;
  String name;
  String bannerimage;
  List<SubCategoryList> subcategorylist;

  CategoryList({this.id, this.name, this.bannerimage,this.subcategorylist});

  factory CategoryList.fromJson(Map<String, dynamic> json) => _$CategoryListFromJson(json);

}

@JsonSerializable()
class SubCategoryList{

  int id;
  String name;
  String icon;
  SubCategoryList({this.id, this.name,this.icon});

  factory SubCategoryList.fromJson(Map<String, dynamic> json) => _$SubCategoryListFromJson(json);

}