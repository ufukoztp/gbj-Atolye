import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/features/domain/entities/Home.dart';
import 'package:gbjatolye/features/domain/entities/account/__currencies.dart';
import 'package:gbjatolye/features/domain/entities/account/user_adress.dart';
import 'package:gbjatolye/features/domain/entities/account/user_auth.dart';
import 'package:gbjatolye/features/domain/entities/account/user_exist.dart';
import 'package:gbjatolye/features/domain/entities/account/user_forgot_password.dart';
import 'package:gbjatolye/features/domain/entities/account/user_register.dart';
import 'package:gbjatolye/features/domain/entities/account/user_verify.dart';
import 'package:gbjatolye/features/domain/entities/collections.dart';
import 'package:gbjatolye/features/domain/entities/home/home.dart';
import 'package:gbjatolye/features/domain/entities/jewelerytypes.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevice.dart';
import 'package:gbjatolye/features/domain/entities/notification/notification.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevicee.dart';
import 'package:gbjatolye/features/domain/entities/notification/setnotification.dart';
import 'package:gbjatolye/features/domain/entities/notification/settings_response.dart';
import 'package:gbjatolye/features/domain/entities/notification/settingstags.dart';
import 'package:gbjatolye/features/domain/entities/order/order.dart';
import 'package:gbjatolye/features/domain/entities/order/orderstatus.dart';
import 'package:gbjatolye/features/domain/entities/order/orderstatusnew.dart';
import 'package:gbjatolye/features/domain/entities/order2/order_response.dart';
import 'package:gbjatolye/features/domain/entities/product/OtherOption.dart';
import 'package:gbjatolye/features/domain/entities/product/RequestId.dart';
import 'package:gbjatolye/features/domain/entities/product/design_types_response1.dart';
import 'package:gbjatolye/features/domain/entities/product/detailResponse.dart';
import 'package:gbjatolye/features/domain/entities/product/opsiyonlar.dart';
import 'package:gbjatolye/features/domain/entities/product/prdoctList.dart';
import 'package:gbjatolye/features/domain/entities/product/productOld.dart';
import 'package:gbjatolye/features/domain/entities/product/productdetail.dart';
import 'package:gbjatolye/features/domain/entities/product/productnote.dart';
import 'package:gbjatolye/features/domain/entities/product/productstatus.dart';
import 'package:gbjatolye/features/domain/entities/ticket/ticket.dart';
import 'package:gbjatolye/features/domain/repositories/account_repository.dart';
import 'package:gbjatolye/features/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:inject/inject.dart';
import 'package:http/http.dart';

class UseCases {

  final ProductRepository productRepository;
  final AccountRepository accountRepository;


  @provide
  UseCases(this.productRepository,this.accountRepository);


  /*********************************** Account UseCases Starting ***********************************/

  /// Account Server Processing

  Future<Either<Failure, RegisterDeviceResponse>> registerDevice(String url, Registerdevice registerDevice) async {
    return await accountRepository.registerDevice(url,registerDevice);
  }

  Future<Either<Failure, CurrencyRespons>> getCurrencyList(String url) async{
    return await accountRepository.getCurrencyList(url);
  }

  Future<Either<Failure, UserTokenResponse>> getUserToken(String url, UserTokenRequest userTokenRequest) async {
    return await accountRepository.getUserToken(url, userTokenRequest);
  }

  Future<Either<Failure, SmsCodeExternalServerResponse>> requestSmsCode(String url, SendSmsCodeRequest smsCodeRequest) async {
    return await accountRepository.requestSmsCode(url, smsCodeRequest);
  }

  Future<Either<Failure, SmsCodeExternalServerResponse>> resendSmsCode(String url,ResendSmsCodeRequest resendSmsCodeRequest) async{
    return await accountRepository.resendSmsCode(url, resendSmsCodeRequest);
  }

  Future<Either<Failure, SmsCodeExternalServerResponse>> requestIdStatus(String url, RequestIdStatusRequest requestIdStatusRequest) async {
    return await accountRepository.requestIdStatus(url, requestIdStatusRequest);
  }

  Future<Either<Failure, SmsCodeExternalServerResponse>> verifySmsCode(String url, VerifySmsCodeRequest verifySmsCodeRequest) async{
    return await accountRepository.verifySmsCode(url, verifySmsCodeRequest);
  }

  Future<Either<Failure, VerifySmsCodeGbjResponse>> verifySmsCodeGbj(String url, VerifySmsCodeGbjRequest verifySmsCodeGbjRequest) async {
    return await accountRepository.verifySmsCodeGbj(url, verifySmsCodeGbjRequest);
  }

  Future<Either<Failure, UserRegisterResponse>> saveUser(String url, UserRegisterRequest userRegisterRequest) async {
    return await accountRepository.saveUser(url, userRegisterRequest);
  }

  Future<Either<Failure, UserAdressResponse>> updateAdress(String url, UserAdressRequest userAdressRequest) async {
    return await accountRepository.updateAdress(url, userAdressRequest);
  }

  Future<Either<Failure, UserExistResponse>> existUser(String url, UserExistRequest userExistRequest) async {
    return await accountRepository.existUser(url, userExistRequest);
  }

  Future<Either<Failure, UserExistResponse>> forgotPasswordCheckUser(String url, UserExistRequest userExistRequest) async{
    return await accountRepository.forgotPasswordCheckUser(url, userExistRequest);
  }

  Future<Either<Failure, UserForgotPasswordResponse>> changeUserPassword(String url, UserForgotPasswordRequest userForgotPasswordRequest) async {
    return await accountRepository.changeUserPassword(url, userForgotPasswordRequest);
  }

  Future<Either<Failure, ProductNoteResponse>> setProductNote(String url,ProductNoteRequest productNoteRequest) async{
    return await productRepository.setProductNote(url, productNoteRequest);
  }


  /// Account Prefs Processing
  /// Setters

  Future<Either<Failure, bool>> saveLocalUserToken(String token) async {
    return await accountRepository.saveLocalUserToken(token);
  }

  Future<Either<Failure, bool>> saveSmsRequestId(String requestId) async {
    return await accountRepository.saveSmsRequestId(requestId);
  }

  Future<Either<Failure, bool>> saveRememberMe(bool rememberMe) async {
    return await accountRepository.saveRememberMe(rememberMe);
  }

  /// Getters

  Future<Either<Failure, String>> getLocalUserToken() async {
    return await accountRepository.getLocalUserToken();
  }

  Future<Either<Failure, String>> getSmsRequestId() async {
    return await accountRepository.getSmsRequestId();
  }

  Future<Either<Failure, bool>> getRememberMe() async {
    return await accountRepository.getRememberMe();
  }

  /*********************************** Account UseCases Finished ***********************************/



  /*********************************** Product UseCases Starting ***********************************/

  /// Product Server Processing

  Future<Either<Failure, ProductList>> getProductList(String url,ProductRequest productRequest) async {
    return await productRepository.getProductList(url, productRequest);
  }

  Future<Either<Failure, SettingResponse>>  changeRegisterDevice(String url, String deviceid) async {

    return await productRepository.changeRegisterDevice(url, deviceid);
  }

  Future<Either<Failure, TicketResponse>> getTicketList(String url) async{
    return await productRepository.getTicketList(url);
  }

  Future<Either<Failure, NotificationResponse>> getNotificationList(String url,NotificationRequest notificationRequest) async {
    return await productRepository.getNotificationList(url, notificationRequest);
  }


  Future<Either<Failure, NotificationResponse>> setNotificationRead(SetNotification notfIdList,url) async {
    return await productRepository.setNotificationRead( notfIdList,url);

  }

  Future<Either<Failure, HomeResponse>> getHomeInfo(String url) async {
    return await productRepository.getHomeInfo(url);
  }

  Future<Either<Failure, JeweleryResponse>> getJeweleryTypes(String url,int collectionGroupId) async {
    return await productRepository.getJeweleryTypes(url,collectionGroupId);
  }
  Future<Either<Failure, SubJeweleryResponse>> getSubJeweleryTypes(String url,int subJeweleryId,int collectionGroupId) async {
    return await productRepository.getSubJeweleryTypes(url,subJeweleryId,collectionGroupId);
  }

  Future<Either<Failure, Collections>> getCollectionList(String url) async {
    return await productRepository.getCollectionList(url);
  }
  Future<Either<Failure, DesignTypesHome>> getDesignTpyes(String url,IdToJson productId) async {
    return await productRepository.getDesignTypes(url,productId);
  }
  Future<Either<Failure, OtherOption>> getOtherOptions(String url,String productId,String variantId) async {
    return await productRepository.getOtherOption(url,productId,variantId);
  }

  Future<Either<Failure,Home>> getHome(String url) async {
    return await productRepository.getHome(url);
  }

  Future<Either<Failure, ProductStatusResponse>> setProductStatus(String url,ProductStatusRequest productStatusRequest) async {
    return await productRepository.setProductStatus(url,productStatusRequest);
  }

  Future<Either<Failure, ProductStatusResponse>> deleteProductList(String url, ProductStatusRequest productStatusRequest) async {
    return await productRepository.deleteProductList(url,productStatusRequest);
  }

  Future<Either<Failure, bool>> addProductImages(MultipartRequest multipartRequest) async {
    return await productRepository.addProductImages(multipartRequest);
  }

  Future<Either<Failure, DetailResponse>> getProductDetail(String url, ProductDetailRequest productDetailRequest) async{
    return await productRepository.getProductDetail(url,productDetailRequest);
  }
  Future<Either<Failure, Opsiyonlar>> getOptions(String url, String jeweleryId,int variantId,List<int>designId) async{
    return await productRepository.getOpsiyonlar(url,jeweleryId,variantId,designId);
  }

  Future<Either<Failure, ProductDetailUpdateResponse>> sendProductApproved(String url,ProductDetailUpdateRequest productDetailUpdateRequest) async {
    return await productRepository.sendProductApproved(url,productDetailUpdateRequest);
  }

  Future<Either<Failure, OrderResponse>> getOrderList(String url) async{
    return await productRepository.getOrderList(url);
  }

  Future<Either<Failure, OrderStatusResponse>> setOrderStatus(String url,OrderStatusRequest orderStatusRequest) async {
    return await productRepository.setOrderStatus(url,orderStatusRequest);
  }

  Future<Either<Failure, SettingsTagsResponse>> changeSettingsTags(String url,SettingsTagsRequest settingsTagsRequest) async {
    return await productRepository.changeSettingsTags(url,settingsTagsRequest);
  }

  /// Product Prefs Processing
  /// Setters

  Future<Either<Failure, bool>> saveUpdateDate(String updateDate) async {
    return await productRepository.saveUpdateDate(updateDate);
  }

  Future<Either<Failure, bool>> savePriceType(String priceType) async {
    return await accountRepository.savePriceType(priceType);
  }

  Future<Either<Failure, bool>> changeOrderNotificationStatus(bool status) async {
    return await productRepository.changeOrderNotificationStatus(status);
  }

  Future<Either<Failure, bool>> changeProductAddedNotificationStatus(bool status) async {
    return await productRepository.changeProductAddedNotificationStatus(status);
  }

  Future<Either<Failure, bool>> changeProductLikeNotificationStatus(bool status) async {
    return await productRepository.changeProductLikeNotificationStatus(status);
  }

  Future<Either<Failure, bool>> changeCustomNotificationStatus(bool status) async {
    return await productRepository.changeCustomNotificationStatus(status);
  }

  Future<Either<Failure, bool>> changeAllNotificationStatus(bool status) async {
    return await productRepository.changeAllNotificationStatus(status);
  }


  Future<Either<Failure, bool>> revealHomeShowcaseView(bool status) async {
    return await productRepository.revealHomeShowcaseView(status);
  }

  Future<Either<Failure, bool>> revealProductListShowcaseView(bool status) async {
    return await productRepository.revealProductListShowcaseView(status);
  }

  Future<Either<Failure, bool>> revealProductDetailShowcaseView(bool status) async {
    return await productRepository.revealProductDetailShowcaseView(status);
  }


  /// Getters

  Future<Either<Failure, String>> getUpdateDate() async{
    return await productRepository.getUpdateDate();
  }

  Future<Either<Failure, String>> getPriceType() async{
    return await accountRepository.getPriceType();
  }

  Future<Either<Failure, bool>> getOrderNotificationStatus() async {
    return await productRepository.getOrderNotificationStatus();
  }

  Future<Either<Failure, bool>> getProductAddedNotificationStatus() async {
    return await productRepository.getProductAddedNotificationStatus();
  }

  Future<Either<Failure, bool>> getProductLikeNotificationStatus() async {
    return await productRepository.getProductLikeNotificationStatus();
  }

  Future<Either<Failure, bool>> getCustomNotificationStatus() async {
    return await productRepository.getCustomNotificationStatus();
  }

  Future<Either<Failure, bool>> getAllNotificationStatus() async {
    return await productRepository.getAllNotificationStatus();
  }

  Future<Either<Failure, bool>> getHomeShowcaseView() async{
    return await productRepository.getHomeShowcaseView();
  }

  Future<Either<Failure, bool>> getProductListShowcaseView()async{
    return await productRepository.getProductListShowcaseView();
  }

  Future<Either<Failure, bool>> getProductDetailShowcaseView()async{
    return await productRepository.getProductDetailShowcaseView();
  }





/*********************************** Product UseCases Finished ***********************************/


}
