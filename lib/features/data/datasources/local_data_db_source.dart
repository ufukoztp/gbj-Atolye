import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalDataDbSource {

  ///Setters
  ///

  //Future<bool> insertLocalDbProduct(List<ProductModel> productList);


  ///Getters
  ///


}

class LocalDataDbSourceImp implements LocalDataDbSource {

  final Database database;

  LocalDataDbSourceImp({@required this.database});


  ///Setters
  ///
  /*
  @override
  Future<bool> insertLocalDbProduct(List<ProductModel> productList) {
    return null;
  }
  */


  ///Getters
  ///


}
