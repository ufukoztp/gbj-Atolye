import 'dart:developer';
import 'dart:io';
import 'package:gbjatolye/features/data/repositories/account_repository_impl.dart';
import 'package:gbjatolye/features/data/repositories/product_repository_impl.dart';
import 'package:gbjatolye/features/domain/repositories/account_repository.dart';
import 'package:gbjatolye/features/domain/repositories/product_repository.dart';
import 'package:path/path.dart';
import 'package:gbjatolye/core/network/network_info.dart';
import 'package:gbjatolye/features/data/datasources/local_data_db_source.dart';
import 'package:gbjatolye/features/data/datasources/local_data_pref_source.dart';
import 'package:gbjatolye/features/data/datasources/remote_data_source.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart';
import 'package:inject/inject.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

@module
class AppModule {

  @provide
  @singleton
  Client client() => Client();

  @provide
  @asynchronous
  Future<SharedPreferences> provideSharedPrefObj() async =>
      await SharedPreferences.getInstance();

  @provide
  @asynchronous
  Future<String> provideDeviceLanguage() async {

    List preferredLanguages = ['tr'];
    if (preferredLanguages == null) return "tr";
    String selectedLanguage = preferredLanguages[0];
    var lang = "tr";
    switch (selectedLanguage) {
      case "tr-TR":
        lang = "?language=tr";
        break;
      case "en-TR":
        lang = "?language=en";
        break;
      default:
        lang = "?language=tr";
        break;
    }
    return lang;
  }

//  @provide
//  FirebaseAnalyticsObserver provideFirebaseAnalyticsObserverObj(){
//    FirebaseAnalytics analytics = FirebaseAnalytics();
//    return FirebaseAnalyticsObserver(analytics: analytics);
//  }

  /*
  @provide
  @singleton
  PermissionHandler providePermissionHandler() => PermissionHandler();
   */

  /* New Architecture */

  @provide
  @asynchronous
  // ignore: missing_return
  Future<Database> provideSharedDbObj() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      String path = join(documentsDirectory.path, "Bijuteri.db");

      return await openDatabase(path,
          version: 1,
          onOpen: (db) {},
          onUpgrade: (Database db, int oldVersion, int newVersion) async {},
          onCreate: (Database db, int version) async {
            await db.execute("CREATE TABLE Product ("
                "AtolyeminProductId INTEGER PRIMARY KEY,"
                "GBJProductCode TEXT,"
                "GBJProductId INTEGER,"
                "ProductCode TEXT,"
                "SupplierId INTEGER,"
                "MinimumOrderQuantity INTEGER,"
                "BulkQuantity INTEGER,"
                "BulkQuantity2 INTEGER,"
                "SupplierNote TEXT,"
                "CostType INTEGER,"
                "MoldNo TEXT,"
                "DefaultImage TEXT,"
                "MiniBlobUrl TEXT,"
                "Width REAL,"
                "Height REAL,"
                "Depth REAL,"
                "GemstoneWidth REAL,"
                "GemstoneHeight REAL,"
                "CZDiameter REAL,"
                "BeadDiameter REAL,"
                "Status INTEGER,"
                "UpdateDate TEXT,"
                "CollectionGroupId INTEGER,"
                "CreateDate TEXT,"
                "MaxUpdateDate TEXT,"
                "MaxUpdateDateVariants TEXT,"
                "JewelryBoxEnabled INTEGER,"
                "Mixed INTEGER"
                ")");

            await db.execute("CREATE TABLE AvailableProductOption ("
                "AtolyeminProductId INTEGER,"
                "OptionGroupId INTEGER,"
                "OptionGroupName TEXT"
                ")");

            await db.execute("CREATE TABLE ProductOption ("
                "AtolyeminProductId INTEGER,"
                "OptionGroupId INTEGER,"
                "OptionId INTEGER,"
                "OptionName TEXT,"
                "Icon TEXT,"
                "HasKarat INTEGER,"
                "StoneId INTEGER,"
                "Sequence INTEGER"
                ")");

            await db.execute("CREATE TABLE DesignType ("
                "AtolyeminProductId INTEGER,"
                "DesignTypeId INTEGER,"
                "DesignTypeName TEXT,"
                "Icon TEXT"
                ")");

            await db.execute("CREATE TABLE Variant ("
                "VariantId INTEGER PRIMARY KEY,"
                "AtolyeminProductId INTEGER,"
                "GbjVariantId INTEGER,"
                "GBJExVariantId INTEGER,"
                "Weight REAL,"
                "SilverWeight REAL,"
                "GoldWeight REAL,"
                "TotalDiamondWeight REAL,"
                "GemstoneWeight REAL,"
                "RoseCutDiamondWeight REAL,"
                "Cost REAL,"
                "ExtraCost REAL,"
                "TotalCost REAL,"
                "BulkCost REAL,"
                "BulkCost2 REAL,"
                "TotalBulkCost REAL,"
                "TotalBulkCost2 REAL,"
                "DefaultVariant INTEGER,"
                "Pure INTEGER,"
                "Millesimal INTEGER,"
                "Image TEXT,"
                "Enabled INTEGER,"
                "JewelryBoxEnabled INTEGER,"
                "UpdateDate TEXT,"
                "CreateDate TEXT,"
                "MixQuantity INTEGER"
                ")");

            await db.execute("CREATE TABLE VariantImage ("
                "VariantId INTEGER,"
                "ImageId INTEGER,"
                "Image TEXT,"
            //"Default INTEGER,"
                "Sequence INTEGER"
                ")");
          });
    } catch (ex) {
      log("Exception :" + ex.toString());
    }
  }

  @provide
  @singleton
  UseCases provideRepository(ProductRepository productRepository,
      AccountRepository accountRepository) =>
      UseCases(productRepository, accountRepository);

  @provide
  @singleton
  AccountRepository provideAccountRepositoryImpl(RemoteDataSource ards,
      LocalDataPrefSource ldps, LocalDataDbSource ldds, NetworkInfo ni) =>
      AccountRepositoryImpl(
          networkInfo: ni,
          localDataPrefSource: ldps,
          localDataDbSource: ldds,
          remoteDataSource: ards);

  @provide
  @singleton
  ProductRepository provideRepositoryImpl(RemoteDataSource ards,
      LocalDataPrefSource ldps, LocalDataDbSource ldds, NetworkInfo ni) =>
      ProductRepositoryImpl(
          networkInfo: ni,
          localDataPrefSource: ldps,
          localDataDbSource: ldds,
          remoteDataSource: ards);

  @provide
  @singleton
  LocalDataPrefSource provideLocalPrefDataSourceImp(SharedPreferences sp) =>
      LocalDataPrefSourceImp(prefs: sp);

  @provide
  @singleton
  LocalDataDbSource provideLocalDbDataSourceImp(Database obj) =>
      LocalDataDbSourceImp(database: obj);

  @provide
  @singleton
  RemoteDataSource provideRemoteDataSourceImp(Client client, LocalDataPrefSource ldps, String lang) =>
      RemoteDataSourceImp(client: client, localDataPrefSource: ldps,language:lang);

  @provide
  @singleton
  NetworkInfo provideNetworkInfoImpl(DataConnectionChecker dcc) =>
      NetworkInfoImpl(dcc);

  @provide
  @singleton
  DataConnectionChecker dtc() => DataConnectionChecker();
}
