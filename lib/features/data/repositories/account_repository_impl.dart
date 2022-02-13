import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/core/network/network_info.dart';
import 'package:gbjatolye/features/data/datasources/local_data_db_source.dart';
import 'package:gbjatolye/features/data/datasources/local_data_pref_source.dart';
import 'package:gbjatolye/features/data/datasources/remote_data_source.dart';
import 'package:gbjatolye/features/domain/entities/account/__currencies.dart';
import 'package:gbjatolye/features/domain/entities/account/user_adress.dart';
import 'package:gbjatolye/features/domain/entities/account/user_auth.dart';
import 'package:gbjatolye/features/domain/entities/account/user_exist.dart';
import 'package:gbjatolye/features/domain/entities/account/user_forgot_password.dart';
import 'package:gbjatolye/features/domain/entities/account/user_register.dart';
import 'package:gbjatolye/features/domain/entities/account/user_verify.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevice.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevicee.dart';
import 'package:gbjatolye/features/domain/repositories/account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:inject/inject.dart';
import 'package:meta/meta.dart';

class AccountRepositoryImpl implements AccountRepository {

  final RemoteDataSource remoteDataSource;
  final LocalDataPrefSource localDataPrefSource;
  final LocalDataDbSource localDataDbSource;
  final NetworkInfo networkInfo;

  @provide
  AccountRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataPrefSource,
    @required this.localDataDbSource,
    @required this.networkInfo,
  });

  /// Server Processing Start



  @override
  Future<Either<Failure, RegisterDeviceResponse>> registerDevice(String url, Registerdevice registerdevice) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.registerDevice(url,registerdevice);
        if (response.success==false && response.message!=null) {
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
  Future<Either<Failure, CurrencyRespons>> getCurrencyList(String url) async{
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getCurrencyList(url);
        if (response.success==false && response.message!=null) {
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
  Future<Either<Failure, UserTokenResponse>> getUserToken(
      String url, UserTokenRequest userTokenRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUserToken = await remoteDataSource.getUserToken(
            url,
            UserTokenRequest(
                phone: userTokenRequest.phone,
                password: userTokenRequest.password));

        var userTokenResponse = UserTokenResponse(
            token: remoteUserToken.token,
            expiration: remoteUserToken.expiration,
            success: remoteUserToken.success,
            message: remoteUserToken.message);

        if (userTokenResponse.success==false && userTokenResponse.message!=null) {
          return Left(ServerFailure(userTokenResponse.message));
        }

        return Right(userTokenResponse);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, SmsCodeExternalServerResponse>> requestSmsCode(
      String url, SendSmsCodeRequest sendSmsCodeRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final smsCodeResponse = await remoteDataSource.requestSmsCode(url, sendSmsCodeRequest);

        if (smsCodeResponse.errorText != null &&
            smsCodeResponse.status != null &&
            smsCodeResponse.status != "0") {
          return Left(ServerFailure(smsCodeResponse.status));
        }

        return Right(smsCodeResponse);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }


  @override
  Future<Either<Failure, SmsCodeExternalServerResponse>> resendSmsCode(
      String url, ResendSmsCodeRequest resendSmsCodeRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final resendSmsCodeResponse = await remoteDataSource.resendSmsCode(url, resendSmsCodeRequest);

        if (resendSmsCodeResponse.errorText != null &&
            resendSmsCodeResponse.status != null) {
          return Left(ServerFailure(resendSmsCodeResponse.status));
        }

        return Right(resendSmsCodeResponse);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, SmsCodeExternalServerResponse>> requestIdStatus(String url, RequestIdStatusRequest requestIdStatusRequest) async {
    if (await networkInfo.isConnected) {
      try {

        final smsStatusResponse = await remoteDataSource.requestIdStatus(url, requestIdStatusRequest);

        if (smsStatusResponse.errorText != null &&
            smsStatusResponse.status != null) {
          return Left(ServerFailure(smsStatusResponse.status));
        }

        return Right(smsStatusResponse);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }

  @override
  Future<Either<Failure, SmsCodeExternalServerResponse>> verifySmsCode(String url, VerifySmsCodeRequest verifySmsCodeRequest) async {

    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.verifySmsCode(
            url,verifySmsCodeRequest
        );

        if (response.errorText != null &&
            response.status != null &&
            response.status != "0") {
          return Left(ServerFailure(response.status));
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
  Future<Either<Failure, VerifySmsCodeGbjResponse>> verifySmsCodeGbj(String url, VerifySmsCodeGbjRequest verifySmsCodeRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.verifySmsCodeGbj(
            url,
            verifySmsCodeRequest
        );

        if (!response.success && response.message != null) {
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
  Future<Either<Failure, UserRegisterResponse>> saveUser(String url, UserRegisterRequest userRegisterRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.saveUser(
            url,
            userRegisterRequest
        );

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
  Future<Either<Failure, UserAdressResponse>> updateAdress(String url, UserAdressRequest userAdressRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.updateAdress(
            url,
            userAdressRequest
        );

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
  Future<Either<Failure, UserExistResponse>> existUser(String url, UserExistRequest userExistRequest) async {

    if (await networkInfo.isConnected) {

      try {

        final response = await remoteDataSource.existUser(url, userExistRequest);

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
  Future<Either<Failure, UserExistResponse>> forgotPasswordCheckUser(String url, UserExistRequest userExistRequest) async {
    if (await networkInfo.isConnected) {

      try {

        final response = await remoteDataSource.existUser(url,userExistRequest);

        if (response.success) {
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
  Future<Either<Failure, UserForgotPasswordResponse>> changeUserPassword(String url, UserForgotPasswordRequest userForgotPasswordRequest) async {
    if (await networkInfo.isConnected) {
      try {

        final response = await remoteDataSource.changeUserPassword(url, userForgotPasswordRequest);

        if (!response.success) {
          return Left(ServerFailure(response.userid.toString()));
        }
        return Right(response);
      } catch (ex) {
        return Left(ex);
      }
    } else {
      return Left(SocketFailure());
    }
  }


  /// Prefs Processing Start

  ///Setters

  @override
  Future<Either<Failure, bool>> saveLocalUserToken(String token) async {
    try {
      final saveLocalData = await localDataPrefSource.saveToken(token);
      return Right(saveLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> saveSmsRequestId(String requestId) async {
    try {
      final saveLocalData =
      await localDataPrefSource.saveSmsRequestId(requestId);
      return Right(saveLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> saveRememberMe(bool rememberMe) async {
    try {
      final saveLocalData =
      await localDataPrefSource.saveRememberMe(rememberMe);
      return Right(saveLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> savePriceType(String priceType) async {
    try {
      final saveLocalData = await localDataPrefSource.savePriceType(priceType);
      return Right(saveLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }


  ///Getters

  @override
  Future<Either<Failure, String>> getLocalUserToken() async {
    try {
      final getLocalData = await localDataPrefSource.getToken();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, String>> getSmsRequestId() async {
    try {
      final getLocalData = await localDataPrefSource.getSmsRequestId();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, bool>> getRememberMe() async {
    try {
      final getLocalData = await localDataPrefSource.getRememberMe();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }

  @override
  Future<Either<Failure, String>> getPriceType() async {
    try {
      final getLocalData = await localDataPrefSource.getPriceType();
      return Right(getLocalData);
    } catch (ex) {
      return Left(ex);
    }
  }







  /// Prefs Processing Finish

}
