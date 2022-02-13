import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataPrefSource {

  ///Setters
  ///

  Future<bool> saveToken(String token);

  Future<bool> saveSmsRequestId(String requestId);

  Future<bool> saveRememberMe(bool rememberMe);

  Future<bool> saveUpdateDate(String updateDate);

  Future<bool> savePriceType(String priceType);

  Future<bool> changeOrderNotificationStatus(bool status);

  Future<bool> changeProductAddedNotificationStatus(bool status);

  Future<bool> changeProductLikeNotificationStatus(bool status);

  Future<bool> changeCustomNotificationStatus(bool status);

  Future<bool> changeAllNotificationStatus(bool status);

  Future<bool> revealHomeShowcaseView(bool status);
  Future<bool> revealProductListShowcaseView(bool status);
  Future<bool> revealProductDetailShowcaseView(bool status);

  ///Getters
  ///

  Future<String> getToken();

  Future<String> getSmsRequestId();

  Future<bool> getRememberMe();

  Future<String> getUpdateDate();

  Future<String> getPriceType();

  Future<bool> getOrderNotificationStatus();

  Future<bool> getProductAddedNotificationStatus();

  Future<bool> getProductLikeNotificationStatus();

  Future<bool> getCustomNotificationStatus();

  Future<bool> getAllNotificationStatus();

  Future<bool> getHomeShowcaseView();

  Future<bool> getProductListShowcaseView();

  Future<bool> getProductDetailShowcaseView();

}

class LocalDataPrefSourceImp implements LocalDataPrefSource {

  final SharedPreferences prefs;

  LocalDataPrefSourceImp({@required this.prefs});

  ///Setters
  ///

  @override
  Future<bool> saveToken(String token) async {
    try {
      prefs.setString(PrefKeys.TOKEN_KEYS, token);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> saveSmsRequestId(String requestId) async {
    try {
      prefs.setString(PrefKeys.SMSREQUSETID_KEYS, requestId);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }


  @override
  Future<bool> saveRememberMe(bool rememberMe) async {
    try {
      prefs.setBool(PrefKeys.REMEMBERME_KEYS, rememberMe);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> saveUpdateDate(String updateDate) async{
    try {
      prefs.setString(PrefKeys.UPDATEDATE_KEYS, updateDate);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> savePriceType(String priceType) async{
    try {
      prefs.setString(PrefKeys.PRICETYPE_KEYS, priceType);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> changeAllNotificationStatus(bool status) async {
    try {
      print("change value $status");
      prefs.setBool(PrefKeys.ALLNOTIFICATION_KEYS, status);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> changeCustomNotificationStatus(bool status) async {
    try {
      prefs.setBool(PrefKeys.CUSTOMNOTIFICATION_KEYS, status);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> changeOrderNotificationStatus(bool status) async {
    try {
      prefs.setBool(PrefKeys.ORDERNOTIFICATION_KEYS, status);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> changeProductAddedNotificationStatus(bool status) async {
    try {
      prefs.setBool(PrefKeys.PRODUCTADDEDNOTIFICATION_KEYS, status);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> changeProductLikeNotificationStatus(bool status) async {
    try {
      prefs.setBool(PrefKeys.PRODUCTLIKENOTIFICATION_KEYS, status);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> revealHomeShowcaseView(bool status) async {
    try {
      prefs.setBool(PrefKeys.HOMESHOWCASE_KEYS, status);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> revealProductDetailShowcaseView(bool status) async {
    try {
      prefs.setBool(PrefKeys.PRODUCTDETAILSHOWCASE_KEYS, status);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> revealProductListShowcaseView(bool status) async {
    try {
      prefs.setBool(PrefKeys.PRODUCTLISTSHOWCASE_KEYS, status);
      return true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }


  ///Getters
  ///

  @override
  Future<String> getToken() async {
    try {
      return prefs.getString(PrefKeys.TOKEN_KEYS) ?? "";
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<String> getSmsRequestId() async {
    try {
      return prefs.getString(PrefKeys.SMSREQUSETID_KEYS) ?? "";
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> getRememberMe() async {
    try {
      return prefs.getBool(PrefKeys.REMEMBERME_KEYS) ?? false;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<String> getUpdateDate() async {
    try {
      return prefs.getString(PrefKeys.UPDATEDATE_KEYS) ?? "null";
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<String> getPriceType() async{
    try {
      return prefs.getString(PrefKeys.PRICETYPE_KEYS) ?? "null";
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }


  @override
  Future<bool> getAllNotificationStatus() async {
    try {

      print("local data remote : "+ prefs.getBool(PrefKeys.ALLNOTIFICATION_KEYS).toString());

      return prefs.getBool(PrefKeys.ALLNOTIFICATION_KEYS) ?? false;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }



  @override
  Future<bool> getCustomNotificationStatus() async {
    try {
      return prefs.getBool(PrefKeys.CUSTOMNOTIFICATION_KEYS) ?? true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> getOrderNotificationStatus() async {
    try {
      return prefs.getBool(PrefKeys.ORDERNOTIFICATION_KEYS) ?? true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> getProductAddedNotificationStatus() async {
    try {
      return prefs.getBool(PrefKeys.PRODUCTADDEDNOTIFICATION_KEYS) ?? true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> getProductLikeNotificationStatus() async {
    try {
      return prefs.getBool(PrefKeys.PRODUCTLIKENOTIFICATION_KEYS) ?? true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> getHomeShowcaseView() async {
    try {
      return prefs.getBool(PrefKeys.HOMESHOWCASE_KEYS) ?? true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> getProductDetailShowcaseView() async {
    try {
      return prefs.getBool(PrefKeys.PRODUCTDETAILSHOWCASE_KEYS) ?? true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }

  @override
  Future<bool> getProductListShowcaseView() async {
    try {
      return prefs.getBool(PrefKeys.PRODUCTLISTSHOWCASE_KEYS) ?? true;
    } catch (ex) {
      return throw CacheFailure(ex.toString());
    }
  }


}
