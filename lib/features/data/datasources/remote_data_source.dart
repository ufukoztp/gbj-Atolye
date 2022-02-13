import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/features/domain/entities/notification/setnotification.dart';
import 'package:gbjatolye/features/domain/entities/notification/settings_response.dart';
import 'package:gbjatolye/features/domain/entities/notification/unregister_device.dart';
import 'package:gbjatolye/features/domain/entities/order/orderstatusnew.dart';
import 'package:gbjatolye/features/domain/entities/order2/order_response.dart';
import 'package:gbjatolye/features/domain/entities/product/OtherOption.dart';
import 'package:gbjatolye/features/domain/entities/product/RequestId.dart';
import 'package:gbjatolye/features/domain/entities/product/opsiyonlar.dart';
import 'package:gbjatolye/features/domain/entities/Home.dart';
import 'package:gbjatolye/features/domain/entities/account/__currencies.dart';
import 'package:gbjatolye/features/domain/entities/collections.dart';
import 'package:gbjatolye/features/domain/entities/jewelerytypes.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevicee.dart';
import 'package:gbjatolye/features/domain/entities/product/design_types_response1.dart';
import 'package:gbjatolye/features/domain/entities/product/detailResponse.dart';
import 'package:gbjatolye/features/domain/entities/product/prdoctList.dart';
import 'package:gbjatolye/features/domain/entities/product/productOld.dart';
import 'package:gbjatolye/utils/navigationservice.dart';
import 'package:gbjatolye/features/domain/entities/account/user_adress.dart';
import 'package:gbjatolye/features/domain/entities/account/user_auth.dart';
import 'package:gbjatolye/features/domain/entities/account/user_exist.dart';
import 'package:gbjatolye/features/domain/entities/account/user_forgot_password.dart';
import 'package:gbjatolye/features/domain/entities/account/user_register.dart';
import 'package:gbjatolye/features/domain/entities/account/user_verify.dart';
import 'package:gbjatolye/features/domain/entities/home/home.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevice.dart';
import 'package:gbjatolye/features/domain/entities/notification/notification.dart';
import 'package:gbjatolye/features/domain/entities/notification/settingstags.dart';
import 'package:gbjatolye/features/domain/entities/order/order.dart';
import 'package:gbjatolye/features/domain/entities/order/orderstatus.dart';
import 'package:gbjatolye/features/domain/entities/product/productdetail.dart';
import 'package:gbjatolye/features/domain/entities/product/productnote.dart';
import 'package:gbjatolye/features/domain/entities/product/productstatus.dart';
import 'package:gbjatolye/features/domain/entities/ticket/ticket.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'local_data_pref_source.dart';

abstract class RemoteDataSource {
  Future<CurrencyRespons> getCurrencyList(String url);

  Future<UserTokenResponse> getUserToken(
      String url, UserTokenRequest userTokenRequest);

  Future<ProductList> getProductList(
      String url, ProductRequest productRequest);

  Future<Opsiyonlar> getOpsiyonlar(String url,String jeweleryId,int variantId,List<int>designId);

  Future<OtherOption> getOtherOption(String url,String productId,String variantId);

  Future<SmsCodeExternalServerResponse> requestSmsCode(
      String url, SendSmsCodeRequest smsCodeRequest);

  Future<SmsCodeExternalServerResponse> resendSmsCode(
      String url, ResendSmsCodeRequest resendSmsCodeRequest);

  Future<SmsCodeExternalServerResponse> requestIdStatus(
      String url, RequestIdStatusRequest requestIdStatusRequest);

  Future<SmsCodeExternalServerResponse> verifySmsCode(
      String url, VerifySmsCodeRequest verifySmsCodeRequest);

  Future<VerifySmsCodeGbjResponse> verifySmsCodeGbj(
      String url, VerifySmsCodeGbjRequest verifySmsCodeRequest);

  //Future<SupplierRegisterResponseModel> saveSupplier(String url, SupplierRegisterRequestModel userRegisterRequestModel);

  Future<UserRegisterResponse> saveUser(
      String url, UserRegisterRequest userRegisterRequest);

  //Future<SupplierRegisterResponseModel> updateSupplier(String url,SupplierRegisterRequestModel supplierUpdateRequestModel);

  Future<UserAdressResponse> updateAdress(
      String url, UserAdressRequest userAdressRequest);

  Future<UserExistResponse> existUser(
      String url, UserExistRequest userExistRequest);

  Future<UserForgotPasswordResponse> changeUserPassword(
      String url, UserForgotPasswordRequest userForgotPasswordRequest);

  Future<HomeResponse> getHomeInfo(String url);

  Future<JeweleryResponse> getJeweleryTypes(String url,int collectionGroupId);

  Future<SubJeweleryResponse> getSubJeweleryTypes(String url,int subJeweleryId,int collectionGroupId);



  Future<Collections> getCollectionList(String url);
  Future<Home> getHome(String url);
  Future<DesignTypesHome> getDesignTypes(String url,IdToJson productId);

  Future<ProductStatusResponse> setProductStatus(
      String url, ProductStatusRequest productStatusRequest);

  Future<ProductStatusResponse> deleteProductList(
      String url, ProductStatusRequest productStatusRequest);

  Future<bool> addProductImages(MultipartRequest multipartRequest);

  Future<RegisterDeviceResponse> registerDevice(
      String url, Registerdevice registerDevice);

  Future<DetailResponse> getProductDetail(
      String url, ProductDetailRequest productDetailRequest);

  Future<ProductDetailUpdateResponse> sendProductApproved(
      String url, ProductDetailUpdateRequest productDetailUpdateRequest);

  Future<NotificationResponse> getNotificationList(
      String url, NotificationRequest notificationRequest);
  Future<NotificationResponse> setNotificationRead(
      String url, SetNotification notfIdList);


  Future<OrderResponse> getOrderList(String url);

  Future<TicketResponse> getTicketList(String url);

  Future<OrderStatusResponse> setOrderStatus(String url, OrderStatusRequest orderStatusRequest);

  Future<SettingResponse> changeRegisterDevice(String url, String deviceid);

  Future<ProductNoteResponse> setProductNote(
      String url, ProductNoteRequest productNoteRequest);

  Future<SettingsTagsResponse> changeSettingsTags(
      String url, SettingsTagsRequest settingsTagsRequest);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final String language;
  final Client client;
  final LocalDataPrefSource localDataPrefSource;

  RemoteDataSourceImp(
      {@required this.client,
      @required this.localDataPrefSource,
      @required this.language});

  @override
  Future<CurrencyRespons> getCurrencyList(String url) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url, body: null);

      return CurrencyRespons.fromJsonMap(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<UserTokenResponse> getUserToken(
      String url, UserTokenRequest userTokenRequest) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url,
          body: userTokenRequest.toJson());

      return UserTokenResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<ProductDetailUpdateResponse> sendProductApproved(
      String url, ProductDetailUpdateRequest productDetailUpdateRequest) async {

    try {
      print(productDetailUpdateRequest.toJson().toString());
      final response = await requestServiceCallWithJson(
          url: url, json: json.encode(productDetailUpdateRequest.toJson()));

         print("başarılı status remote data"+response.body.toString());

      return ProductDetailUpdateResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<HomeResponse> getHomeInfo(String url) async {
    try {
      final response = await requestServiceCall(url);

      return HomeResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }



  @override
  Future<Collections> getCollectionList(String url) async{
    try {
      final response = await requestServiceCall(url);

      return Collections.fromJsonMap(json.decode(response.body));
    } catch (ex) {
      print("collection hata");

      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }
  @override
  Future<Home> getHome(String url) async{
    try {
      final response = await requestServiceCall(url);
      print("complete Home");
      return Home.fromJsonMap(json.decode(response.body));
    } catch (ex) {
      print("Hata Home");

      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<ProductList> getProductList(
      String url, ProductRequest productRequest) async {
    try {
      final response =
          await requestServiceCall(url, body: productRequest.toJson());



   return ProductList.fromJsonMap(json.decode(response.body));



    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<SettingResponse> changeRegisterDevice(String url, String deviceid) async {
    print("gelen: "+deviceid.toString());
    try {

      final response = await requestServiceCall(url, body: UnRegister().toJson(deviceid));



      return SettingResponse.fromJsonMap(json.decode(response.body));



    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }


  @override
  Future<OrderStatusResponse> setOrderStatus(
      String url, OrderStatusRequest orderStatusRequest) async {
    try {
      print(json.encode(orderStatusRequest.toJson()));
      final response = await requestServiceCallWithJson(
          url: url, json: json.encode(orderStatusRequest.toJson()));

      print('order list response code: '+response.statusCode.toString());

      return OrderStatusResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<OrderResponse> getOrderList(String url) async {
    try {
      final response = await requestServiceCall(url, body: null);

      return OrderResponse.fromJson(json.decode(response.body));


    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<TicketResponse> getTicketList(String url) async {
    try {
      final response = await requestServiceCall(url, body: null);
      return TicketResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<NotificationResponse> getNotificationList(
      String url, NotificationRequest notificationRequest) async {
    try {
      final response =
          await requestServiceCall(url, body: notificationRequest.toJson());

      return NotificationResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }



  @override
  Future<NotificationResponse> setNotificationRead(
      String url, SetNotification notfIdList) async {
    try {
      final response =
      await requestServiceCallWithJson(url: url, json: json.encode(notfIdList));

      return NotificationResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }


  @override
  Future<SmsCodeExternalServerResponse> requestSmsCode(
      String url, SendSmsCodeRequest smsCodeRequest) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url,
          body: smsCodeRequest.toJson());
      print("detay kaydet kodu:  "+response.statusCode.toString());
      return SmsCodeExternalServerResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<SmsCodeExternalServerResponse> resendSmsCode(
      String url, ResendSmsCodeRequest resendSmsCodeRequest) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url,
          body: resendSmsCodeRequest.toJson());

      return SmsCodeExternalServerResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<SmsCodeExternalServerResponse> requestIdStatus(
      String url, RequestIdStatusRequest requestIdStatusRequest) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url,
          body: requestIdStatusRequest.toJson());

      return SmsCodeExternalServerResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<SmsCodeExternalServerResponse> verifySmsCode(
      String url, VerifySmsCodeRequest verifySmsCodeRequest) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url,
          body: verifySmsCodeRequest.toJson());

      return SmsCodeExternalServerResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<VerifySmsCodeGbjResponse> verifySmsCodeGbj(
      String url, VerifySmsCodeGbjRequest verifySmsCodeRequest) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url,
          body: verifySmsCodeRequest.toJson());
      print(response.body.toString());

      return VerifySmsCodeGbjResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<UserRegisterResponse> saveUser(
      String url, UserRegisterRequest userRegisterRequest) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url,
          body: userRegisterRequest.toJson());

      return UserRegisterResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<ProductStatusResponse> setProductStatus(
      String url, ProductStatusRequest productStatusRequest) async {

    try {
      final response = await requestServiceCallWithJson(url: url,json: json.encode(productStatusRequest.productidlist));
      print('set product Status code: '+response.statusCode.toString());

      return ProductStatusResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<SettingsTagsResponse> changeSettingsTags(
      String url, SettingsTagsRequest settingsTagsRequest) async {

    var body = json.encode(
        {
          "tags": settingsTagsRequest.tags,
          "token": settingsTagsRequest.token
        });

    try {

      final response = await requestServiceCallWithJson(url: url, json: body);

      return SettingsTagsResponse.fromJson(json.decode(response.body));

    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }


  @override
  Future<RegisterDeviceResponse> registerDevice(String url, Registerdevice registerDevice) async {

    var body = registerDevice.toJson();

    try {

      final response = await requestServiceCall( url, body: body);

      return RegisterDeviceResponse.fromJson(json.decode(response.body));

    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }

  }


  @override
  Future<DetailResponse> getProductDetail(
      String url, ProductDetailRequest productDetailRequest) async {
    try {
      final response =
          await requestServiceCall(url, body: productDetailRequest.toJson());
      print(response.body.toString()+"productDetail response code");

       return DetailResponse.fromJsonMap(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<ProductStatusResponse> deleteProductList(
      String url, ProductStatusRequest productStatusRequest) async {


    try {
      final response = await requestServiceCallWithJson(url:url,json:json.encode(productStatusRequest.productidlist));


      print(response.statusCode.toString()+'deleteden dönen status kodumuz');

      return ProductStatusResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
    else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<ProductNoteResponse> setProductNote(
      String url, ProductNoteRequest productNoteRequest) async {
    try {
      final response =
          await requestServiceCall(url, body: productNoteRequest.toJson());

      print(response.statusCode.toString()+' note code');

      return ProductNoteResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<UserAdressResponse> updateAdress(
      String url, UserAdressRequest userAdressRequest) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url,
          body: userAdressRequest.toJson());

      return UserAdressResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<UserExistResponse> existUser(
      String url, UserExistRequest userExistRequest) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url,
          body: userExistRequest.toJson());

      return UserExistResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<UserForgotPasswordResponse> changeUserPassword(
      String url, UserForgotPasswordRequest userForgotPasswordRequest) async {
    try {
      final response = await requestWithoutHeaderServiceCall(url,
          body: userForgotPasswordRequest.toJson());

      print('şifre değiştirme'+response.statusCode.toString());


      return UserForgotPasswordResponse.fromJson(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<bool> addProductImages(MultipartRequest multipartRequest) async {
    try {
      var response = await multipartRequest.send();
      print(response.statusCode.toString()+"  : statuscode");

      return true;
      /*
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
       */
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  Future<Response> requestServiceCallWithJson({String url, String json}) async {
    url = url + language;

    try {

      String token = await localDataPrefSource.getToken();

      var response = await client.post(Uri.parse(url), body: json, headers: {
        HttpHeaders.authorizationHeader: "bearer " + token,
        HttpHeaders.contentTypeHeader: "application/json"
      }).timeout(const Duration(seconds: 60));

      final int statusCode = response.statusCode;

      if (statusCode != 200 && statusCode == 401) {
        throw new ServerFailure(response.reasonPhrase);
      } else if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new ServerFailure(response.reasonPhrase);
      }

      return response;
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  Future<Response> requestServiceCall(String url, {Map<dynamic,dynamic> body}) async {
  //  url = url + language;

    print("hata2");

    try {
      var response;
      print("hata1 ilk:   "+url);

      String token = await localDataPrefSource.getToken();

      print("hata1 son :  "+url);

      if (body != null) {
        response = await client.post(Uri.parse(url), body: body, headers: {
          "Content-Type":"application/x-www-form-urlencoded",
          HttpHeaders.authorizationHeader: "Bearer " + token
        }).timeout(const Duration(seconds: 60));
        print(response.statusCode);


      } else {
        response = await client.get(Uri.parse(url), headers: {
          HttpHeaders.authorizationHeader: "bearer " + token
        }).timeout(const Duration(seconds: 60));
      }


      final int statusCode = response.statusCode;
      if (statusCode != 200 && statusCode == 401) {
        print("hata7");
        NavigationService.navigateTo(AppRoutes.login);
        throw new ServerFailure(response.reasonPhrase);
      } else if (statusCode < 200 || statusCode > 400 || json == null) {
        print("hata5");
        throw new ServerFailure(response.reasonPhrase);
      }

      return response;

    } catch (ex) {
      print("hata3");

      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  Future<Response> requestWithoutHeaderServiceCall(String url,
      {Map body}) async {

    url = url + language;

    try {
      var response;

      if (body != null) {
        response = await client
            .post(Uri.parse(url), body: body)
            .timeout(const Duration(seconds: 60));
      } else {
        response = await client.get(Uri.parse(url)).timeout(const Duration(seconds: 60));
      }

      final int statusCode = response.statusCode;

      if (statusCode != 200 && statusCode == 401) {
        throw new ServerFailure(response.reasonPhrase);
      } else if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new ServerFailure(response.reasonPhrase);
      }

      return response;
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<JeweleryResponse> getJeweleryTypes(String url, int collectionGroupId) async {
    try {
      final response = await requestServiceCall(url,body: IdToJson(id2: collectionGroupId.toString()).toJsonRequestId());

      return JeweleryResponse.fromJsonMap(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }
  Future<SubJeweleryResponse> getSubJeweleryTypes(String url,int subJeweleryId,int collectionGroupId) async {
    SubJeweleryId id=SubJeweleryId(jeweleryId: subJeweleryId.toString(),collectionId: collectionGroupId.toString());

    try {
      final response =
      await requestServiceCall(url,body: id.toJsonSubJeweleryId());


      return  SubJeweleryResponse.fromJsonMap(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<DesignTypesHome> getDesignTypes(String url,IdToJson productId) async{
    try {
      final response =
          await requestServiceCall(url,body: productId.toJsonRequestId());

      return DesignTypesHome.fromJsonMap(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<Opsiyonlar> getOpsiyonlar(String url, String jeweleryId,int variantId,List<int>designId) async {
    print(jeweleryId+" : "+variantId.toString()+" : "+url);
    try {


      final response =
          await requestServiceCallWithJson(url:url,json: json.encode(
              {
                "id":int.parse(jeweleryId),
                "variantId":variantId,
                "designTypeIdList":designId
              }));
      print("dönen "+response.body);

      return Opsiyonlar.fromJsonMap(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }

  @override
  Future<OtherOption> getOtherOption(String url, String productId,String variantId)async {
    try {
      print('request proId: '+productId.toString()+'request variantId: '+variantId.toString());
      final response =
          await requestServiceCall(url,body:OtherOption().toJsonId(productId,variantId));
      print(response.body.toString()+'options success');

      return OtherOption.fromJsonMap(json.decode(response.body));
    } catch (ex) {
      if (ex is ServerFailure)
        throw ex;
      else
        throw ServerFailure(ex.toString());
    }
  }


}
