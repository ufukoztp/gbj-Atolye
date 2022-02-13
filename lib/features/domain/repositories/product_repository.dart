import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/features/domain/entities/Home.dart';
import 'package:gbjatolye/features/domain/entities/collections.dart';
import 'package:gbjatolye/features/domain/entities/home/home.dart';
import 'package:gbjatolye/features/domain/entities/jewelerytypes.dart';
import 'package:gbjatolye/features/domain/entities/notification/notification.dart';
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
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

/*
Writing a contract of the Repository, which in the case of Dart is an abstract class,
will allow us to write tests (TDD style) for the UseCases without having an actual Repository implementation.
* */

abstract class ProductRepository {

  /// Server Processing
  ///

  Future<Either<Failure, ProductList>> getProductList(String url, ProductRequest productRequest);
  Future<Either<Failure, SettingResponse>>  changeRegisterDevice(String url, String deviceid);
  Future<Either<Failure, HomeResponse>> getHomeInfo(String url);
  Future<Either<Failure, DesignTypesHome>> getDesignTypes(String url,IdToJson productId);
  Future<Either<Failure, OtherOption>> getOtherOption(String url,String productId,String variantId);
  Future<Either<Failure, Home>> getHome(String url);
  Future<Either<Failure, Collections>> getCollectionList(String url);
  Future<Either<Failure, JeweleryResponse>> getJeweleryTypes(String url,int collectionGroupId);
  Future<Either<Failure, SubJeweleryResponse>> getSubJeweleryTypes(String url,int subJeweleryId,int collectionGroupId);
  Future<Either<Failure, ProductStatusResponse>> setProductStatus(String url,ProductStatusRequest productStatusRequest);
  Future<Either<Failure, ProductStatusResponse>> deleteProductList(String url,ProductStatusRequest productStatusRequest);
  Future<Either<Failure, bool>> addProductImages(MultipartRequest multipartRequest);
  Future<Either<Failure, DetailResponse>> getProductDetail(String url,ProductDetailRequest productDetailRequest);
  Future<Either<Failure, Opsiyonlar>> getOpsiyonlar(String url,String productId,int variantId,List<int>designId);
  Future<Either<Failure, ProductDetailUpdateResponse>> sendProductApproved(String url,ProductDetailUpdateRequest productDetailUpdateRequest);
  Future<Either<Failure, NotificationResponse>> getNotificationList(String url,NotificationRequest notificationRequest);
  Future<Either<Failure, NotificationResponse>> setNotificationRead(SetNotification notfIdList,url);
   Future<Either<Failure, OrderResponse>> getOrderList(String url);
  Future<Either<Failure, OrderStatusResponse>> setOrderStatus(String url,OrderStatusRequest orderStatusRequest);
  Future<Either<Failure, TicketResponse>> getTicketList(String url);
  Future<Either<Failure, ProductNoteResponse>> setProductNote(String url,ProductNoteRequest productNoteRequest);
  Future<Either<Failure, SettingsTagsResponse>> changeSettingsTags(String url,SettingsTagsRequest settingsTagsRequest);

  /// Prefs Processing
  ///Setters

  Future<Either<Failure, bool>> saveUpdateDate(String updateDate);
  Future<Either<Failure, bool>> changeOrderNotificationStatus(bool status);
  Future<Either<Failure, bool>> changeProductAddedNotificationStatus(bool status);
  Future<Either<Failure, bool>> changeProductLikeNotificationStatus(bool status);
  Future<Either<Failure, bool>> changeCustomNotificationStatus(bool status);
  Future<Either<Failure, bool>> changeAllNotificationStatus(bool status);
  Future<Either<Failure, bool>> revealHomeShowcaseView(bool status);
  Future<Either<Failure, bool>> revealProductListShowcaseView(bool status);
  Future<Either<Failure, bool>> revealProductDetailShowcaseView(bool status);

  ///Getters
  ///
  Future<Either<Failure, String>> getUpdateDate();
  Future<Either<Failure, bool>> getOrderNotificationStatus();
  Future<Either<Failure, bool>> getProductAddedNotificationStatus();
  Future<Either<Failure, bool>> getProductLikeNotificationStatus();
  Future<Either<Failure, bool>> getCustomNotificationStatus();
  Future<Either<Failure, bool>> getAllNotificationStatus();
  Future<Either<Failure, bool>> getHomeShowcaseView();
  Future<Either<Failure, bool>> getProductListShowcaseView();
  Future<Either<Failure, bool>> getProductDetailShowcaseView();

  /// Database Processing
  ///Setters
  //Future<Either<Failure, bool>> insertLocalDbProduct(List<Product> productList);


}
