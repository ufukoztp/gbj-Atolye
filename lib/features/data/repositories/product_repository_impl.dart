import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/core/network/network_info.dart';
import 'package:gbjatolye/features/data/datasources/local_data_db_source.dart';
import 'package:gbjatolye/features/data/datasources/local_data_pref_source.dart';
import 'package:gbjatolye/features/data/datasources/remote_data_source.dart';
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
import 'package:gbjatolye/features/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
// ignore: implementation_imports
import 'package:http/src/multipart_request.dart';
import 'package:inject/inject.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataPrefSource localDataPrefSource;
  final LocalDataDbSource localDataDbSource;
  final NetworkInfo networkInfo;

  @provide
  ProductRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataPrefSource,
    @required this.localDataDbSource,
    @required this.networkInfo,
  });

  /// Server Processing Start
  ///
  @override
  Future<Either<Failure, ProductList>> getProductList(
      String url, ProductRequest productRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
        await remoteDataSource.getProductList(url, productRequest);

        if (response.success==false)
          return Left(ServerFailure(response.message));

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }


  Future<Either<Failure, SettingResponse>>  changeRegisterDevice(String url, String deviceid) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
        await remoteDataSource.changeRegisterDevice(url, deviceid);

        if (response.success==false)
          return Left(ServerFailure("Hata"));

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }


  @override
  Future<Either<Failure, OrderResponse>> getOrderList(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getOrderList(url);

        print(response.orderList.toString()+' order lenght');

        if (!response.success && response.message != null)
          return Left(ServerFailure(response.message));

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, TicketResponse>> getTicketList(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getTicketList(url);

        if (!response.success && response.message != null)
          return Left(ServerFailure(response.message));

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, NotificationResponse>> getNotificationList(
      String url, NotificationRequest notificationRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getNotificationList(
            url, notificationRequest);

        if (!response.success && response.message != null)
          return Left(ServerFailure(response.message));

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  Future<Either<Failure, NotificationResponse>> setNotificationRead(
      SetNotification notfIdList,url) async {
    if (await networkInfo.isConnected) {
      try {

        final response = await remoteDataSource.setNotificationRead(
            url, notfIdList);

        if (!response.success && response.message != null)
          return Left(ServerFailure(response.message));

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }


  @override
  Future<Either<Failure, HomeResponse>> getHomeInfo(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getHomeInfo(url);

        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, JeweleryResponse>> getJeweleryTypes(String url,int collectionGroupId) async {
    // TODO: implement getJeweleryTypes
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getJeweleryTypes(url,collectionGroupId);

        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }
  Future<Either<Failure, SubJeweleryResponse>> getSubJeweleryTypes(String url,int subJeweleryId,int collectionGroupId) async {
    // TODO: implement getJeweleryTypes
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getSubJeweleryTypes(url, subJeweleryId,collectionGroupId);

        if (!response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }




  @override
  Future<Either<Failure, ProductStatusResponse>> setProductStatus(
      String url, ProductStatusRequest productStatusRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
        await remoteDataSource.setProductStatus(url, productStatusRequest);
        print(" set Status success: "+response.success.toString());

        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, DetailResponse>> getProductDetail(
      String url, ProductDetailRequest productDetailRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
        await remoteDataSource.getProductDetail(url, productDetailRequest);


        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, OrderStatusResponse>> setOrderStatus(
      String url, OrderStatusRequest orderStatusRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
        await remoteDataSource.setOrderStatus(url, orderStatusRequest);

        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, ProductStatusResponse>> deleteProductList(
      String url, ProductStatusRequest productStatusRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
        await remoteDataSource.deleteProductList(url, productStatusRequest);

        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        print(ex.toString());
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addProductImages(
      MultipartRequest multipartRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
        await remoteDataSource.addProductImages(multipartRequest);
        print(response);
        if (!response) {
          return Left(ServerFailure("A error was occured"));
        }
        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, ProductDetailUpdateResponse>> sendProductApproved(
      String url, ProductDetailUpdateRequest productDetailUpdateRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.sendProductApproved(
            url, productDetailUpdateRequest);
        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, ProductNoteResponse>> setProductNote(
      String url, ProductNoteRequest productNoteRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
        await remoteDataSource.setProductNote(url, productNoteRequest);

        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, SettingsTagsResponse>> changeSettingsTags(
      String url, SettingsTagsRequest settingsTagsRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
        await remoteDataSource.changeSettingsTags(url, settingsTagsRequest);

        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  /// Local Database Processing Start
  ///Setters

  // ignore: missing_return
  Future<Either<Failure, bool>> insertLocalDbProduct(
      List<ProductOld> productList) async {
    try {
      //final response = await localDataDbSource.insertLocalDbProduct();

      //return Right(response);

    } catch (ex) {
      return Left(ex);
    }
  }

  ///Getters
  ///

  /// Local Database Processing Finish

  /// Prefs Processing Start
  ///Setters

  @override
  Future<Either<Failure, bool>> saveUpdateDate(String updateDate) async {
    try {
      final saveLocalData =
      await localDataPrefSource.saveUpdateDate(updateDate);
      return Right(saveLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> changeCustomNotificationStatus(
      bool status) async {
    try {
      final saveLocalData =
      await localDataPrefSource.changeCustomNotificationStatus(status);
      return Right(saveLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> changeAllNotificationStatus(
      bool status) async {
    try {
      final saveLocalData =
      await localDataPrefSource.changeAllNotificationStatus(status);
      return Right(saveLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> changeOrderNotificationStatus(
      bool status) async {
    try {
      final saveLocalData =
      await localDataPrefSource.changeOrderNotificationStatus(status);
      return Right(saveLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> changeProductAddedNotificationStatus(
      bool status) async {
    try {
      final saveLocalData = await localDataPrefSource
          .changeProductAddedNotificationStatus(status);
      return Right(saveLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> changeProductLikeNotificationStatus(
      bool status) async {
    try {
      final saveLocalData =
      await localDataPrefSource.changeProductLikeNotificationStatus(status);
      return Right(saveLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> revealHomeShowcaseView(bool status) async {
    try {
      final response = await localDataPrefSource.revealHomeShowcaseView(status);
      return Right(response);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> revealProductDetailShowcaseView(
      bool status) async {
    try {
      final response =
      await localDataPrefSource.revealProductDetailShowcaseView(status);
      return Right(response);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> revealProductListShowcaseView(
      bool status) async {
    try {
      final response =
      await localDataPrefSource.revealProductListShowcaseView(status);
      return Right(response);
    } catch (ex) {
      return Left(ex);
    }
  }

  ///Getters
  ///
  @override
  Future<Either<Failure, String>> getUpdateDate() async {
    try {
      final getLocalData = await localDataPrefSource.getUpdateDate();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }
  @override
  Future<Either<Failure, bool>> getAllNotificationStatus() async {
    try {
      final getLocalData =
      await localDataPrefSource.getAllNotificationStatus();

      print("local data: "+getLocalData.toString());
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }
  @override
  Future<Either<Failure, bool>> getCustomNotificationStatus() async {
    try {
      final getLocalData =
      await localDataPrefSource.getCustomNotificationStatus();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }



  @override
  Future<Either<Failure, bool>> getOrderNotificationStatus() async {
    try {
      final getLocalData =
      await localDataPrefSource.getOrderNotificationStatus();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> getProductAddedNotificationStatus() async {
    try {
      final getLocalData =
      await localDataPrefSource.getProductAddedNotificationStatus();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> getProductLikeNotificationStatus() async {
    try {
      final getLocalData =
      await localDataPrefSource.getProductLikeNotificationStatus();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> getHomeShowcaseView() async {
    try {
      final getLocalData = await localDataPrefSource.getHomeShowcaseView();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> getProductDetailShowcaseView() async {
    try {
      final getLocalData =
      await localDataPrefSource.getProductDetailShowcaseView();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> getProductListShowcaseView() async {
    try {
      final getLocalData =
      await localDataPrefSource.getProductListShowcaseView();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, Collections>> getCollectionList(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getCollectionList(url);

        if (response.messages != null && !response.success) {
          return Left(ServerFailure(response.messages));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }
  Future<Either<Failure, Home>>getHome(String url) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getHome(url);

        if (response.messages != null && !response.success) {
          return Left(ServerFailure(response.messages));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, DesignTypesHome>> getDesignTypes(String url,IdToJson productId) async{
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getDesignTypes(url,productId);

        if ( !response.success) {
          return Left(ServerFailure(response.success.toString()));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, Opsiyonlar>> getOpsiyonlar(String url, String jeweleryId,int variantId,List<int>designId) async{
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getOpsiyonlar(url, jeweleryId,variantId,designId);

        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, OtherOption>> getOtherOption(String url,String productId,String variantId) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getOtherOption(url, productId,variantId);


        print(response.optionGroups.toString()+'options success');

        if (response.message != null && !response.success) {
          return Left(ServerFailure(response.message));
        }

        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }





/// Prefs Processing Finish

}
