import 'app_injector.dart' as _i1;
import 'app_module.dart' as _i2;
// ignore: implementation_imports
import 'package:http/src/client.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i4;
import '../features/data/datasources/local_data_pref_source.dart' as _i5;
import '../features/data/datasources/remote_data_source.dart' as _i6;
import 'package:sqflite/sqlite_api.dart' as _i7;
import '../features/data/datasources/local_data_db_source.dart' as _i8;
import 'package:data_connection_checker/data_connection_checker.dart' as _i9;
import '../core/network/network_info.dart' as _i10;
import '../features/domain/repositories/product_repository.dart' as _i11;
import '../features/domain/repositories/account_repository.dart' as _i12;
import '../features/domain/usecases/usecases.dart' as _i13;
import 'dart:async' as _i14;
import '../app.dart' as _i15;

class AppInjector$Injector implements _i1.AppInjector {
  AppInjector$Injector._(this._appModule);

  final _i2.AppModule   _appModule;

  _i3.Client _singletonClient;

  _i4.SharedPreferences _sharedPreferences;

  _i5.LocalDataPrefSource _singletonLocalDataPrefSource;

  String _string;

  _i6.RemoteDataSource _singletonRemoteDataSource;

  _i7.Database _database;

  _i8.LocalDataDbSource _singletonLocalDataDbSource;

  _i9.DataConnectionChecker _singletonDataConnectionChecker;

  _i10.NetworkInfo _singletonNetworkInfo;

  _i11.ProductRepository _singletonProductRepository;

  _i12.AccountRepository _singletonAccountRepository;

  _i13.UseCases _singletonUseCases;

  static _i14.Future<_i1.AppInjector> create(_i2.AppModule appModule) async {
    final injector = AppInjector$Injector._(appModule);
    injector._sharedPreferences =
    await injector._appModule.provideSharedPrefObj();
    injector._string = await injector._appModule.provideDeviceLanguage();
    injector._database = await injector._appModule.provideSharedDbObj();
    return injector;
  }

  _i15.App _createApp() => _i15.App(_createUseCases());
  _i13.UseCases _createUseCases() =>
      _singletonUseCases ??= _appModule.provideRepository(
          _createProductRepository(), _createAccountRepository());
  _i11.ProductRepository _createProductRepository() =>
      _singletonProductRepository ??= _appModule.provideRepositoryImpl(
          _createRemoteDataSource(),
          _createLocalDataPrefSource(),
          _createLocalDataDbSource(),
          _createNetworkInfo());
  _i6.RemoteDataSource _createRemoteDataSource() =>
      _singletonRemoteDataSource ??= _appModule.provideRemoteDataSourceImp(
          _createClient(), _createLocalDataPrefSource(), _createString());
  _i3.Client _createClient() => _singletonClient ??= _appModule.client();
  _i5.LocalDataPrefSource _createLocalDataPrefSource() =>
      _singletonLocalDataPrefSource ??=
          _appModule.provideLocalPrefDataSourceImp(_createSharedPreferences());
  _i4.SharedPreferences _createSharedPreferences() => _sharedPreferences;
  String _createString() => _string;
  _i8.LocalDataDbSource _createLocalDataDbSource() =>
      _singletonLocalDataDbSource ??=
          _appModule.provideLocalDbDataSourceImp(_createDatabase());
  _i7.Database _createDatabase() => _database;
  _i10.NetworkInfo _createNetworkInfo() => _singletonNetworkInfo ??=
      _appModule.provideNetworkInfoImpl(_createDataConnectionChecker());
  _i9.DataConnectionChecker _createDataConnectionChecker() =>
      _singletonDataConnectionChecker ??= _appModule.dtc();
  _i12.AccountRepository _createAccountRepository() =>
      _singletonAccountRepository ??= _appModule.provideAccountRepositoryImpl(
          _createRemoteDataSource(),
          _createLocalDataPrefSource(),
          _createLocalDataDbSource(),
          _createNetworkInfo());
  @override
  _i15.App get app => _createApp();
}
