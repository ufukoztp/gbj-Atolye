import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:inject/inject.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {

  final DataConnectionChecker connectionChecker;

  @provide
  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

}
