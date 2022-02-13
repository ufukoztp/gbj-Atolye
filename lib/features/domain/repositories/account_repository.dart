import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/features/domain/entities/account/__currencies.dart';
import 'package:gbjatolye/features/domain/entities/account/user_adress.dart';
import 'package:gbjatolye/features/domain/entities/account/user_auth.dart';
import 'package:gbjatolye/features/domain/entities/account/user_exist.dart';
import 'package:gbjatolye/features/domain/entities/account/user_forgot_password.dart';
import 'package:gbjatolye/features/domain/entities/account/user_register.dart';
import 'package:gbjatolye/features/domain/entities/account/user_verify.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevice.dart';
import 'package:dartz/dartz.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevicee.dart';

abstract class AccountRepository {

  /// Server Processing
  Future<Either<Failure, CurrencyRespons>> getCurrencyList(String url);
  Future<Either<Failure, UserTokenResponse>> getUserToken(String url, UserTokenRequest userTokenRequest);
  Future<Either<Failure, SmsCodeExternalServerResponse>> requestSmsCode(String url, SendSmsCodeRequest sendSmsCodeRequest);
  Future<Either<Failure, SmsCodeExternalServerResponse>> resendSmsCode(String url, ResendSmsCodeRequest resendSmsCodeRequest);
  Future<Either<Failure, SmsCodeExternalServerResponse>> requestIdStatus(String url, RequestIdStatusRequest requestIdStatusRequest);
  Future<Either<Failure, SmsCodeExternalServerResponse>> verifySmsCode(String url, VerifySmsCodeRequest verifySmsCodeRequest);
  Future<Either<Failure, VerifySmsCodeGbjResponse>> verifySmsCodeGbj(String url, VerifySmsCodeGbjRequest verifySmsCodeRequest);
  Future<Either<Failure, UserRegisterResponse>> saveUser(String url, UserRegisterRequest userRegisterRequest);
  Future<Either<Failure, UserAdressResponse>> updateAdress(String url, UserAdressRequest userAdressRequest);
  Future<Either<Failure, UserExistResponse>> existUser(String url, UserExistRequest userExistRequest);
  Future<Either<Failure, UserExistResponse>> forgotPasswordCheckUser(String url, UserExistRequest userExistRequest);
  Future<Either<Failure, UserForgotPasswordResponse>> changeUserPassword(String url, UserForgotPasswordRequest userForgotPasswordRequest);
  Future<Either<Failure, RegisterDeviceResponse>> registerDevice(String url, Registerdevice registerDevice);

  /// Prefs Processing

  ///Setters
  Future<Either<Failure, bool>> saveLocalUserToken(String token);
  Future<Either<Failure, bool>> saveSmsRequestId(String requestId);
  Future<Either<Failure, bool>> saveRememberMe(bool rememberMe);
  Future<Either<Failure, bool>> savePriceType(String priceType);

  ///Getters
  Future<Either<Failure, String>> getLocalUserToken();
  Future<Either<Failure, String>> getPriceType();
  Future<Either<Failure, String>> getSmsRequestId();
  Future<Either<Failure, bool>> getRememberMe();

}
