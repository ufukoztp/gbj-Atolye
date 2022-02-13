import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/features/domain/entities/account/user_adress.dart';
import 'package:gbjatolye/features/domain/entities/account/user_forgot_password.dart';
import 'package:gbjatolye/features/domain/entities/account/user_register.dart';
import 'package:gbjatolye/features/domain/entities/account/user_verify.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class Register2UseCases {
  void requestSmsCode();

  void reSendSmsCode(String requestId);

  void reSendCode();

  void getRequestIdStatus(String requestId);

  void resume();

  String getSmsErrorMessage(String errorCode);
}

class Register2Provider with ChangeNotifier implements Register2UseCases {

  bool _autoValidate = false;
  GlobalKey<FormState> _register2FormKey;
  MaskTextInputFormatter _maskFormatter;
  PageIntents _pageIntent;
  UserRegisterRequest _userRegisterRequest;
  BuildContext _context;
  UseCases _useCases;
  String _smsRequestId;
  int _countResend;

  ///Getters
  ///
  bool get autoValidate => _autoValidate;

  int get countResend => _countResend;

  String get smsRequestId => _smsRequestId;

  GlobalKey<FormState> get register2FormKey => _register2FormKey;

  PageIntents get pageIntent => _pageIntent;

  UserRegisterRequest get userRegisterRequest => _userRegisterRequest;

  UseCases get useCases => _useCases;

  BuildContext get context => _context;

  MaskTextInputFormatter get maskFormatter => _maskFormatter;

  ///Setters
  ///
  set autoValidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }

  set userRegisterRequest(UserRegisterRequest value) {
    _userRegisterRequest = value;
    notifyListeners();
  }

  set countResend(int value) {
    _countResend = value;
    notifyListeners();
  }

  set smsRequestId(String value) {
    _smsRequestId = value;
    notifyListeners();
  }

  set pageIntent(PageIntents value) {
    _pageIntent = value;
    notifyListeners();
  }

  set register2FormKey(GlobalKey<FormState> value) {
    _register2FormKey = value;
    notifyListeners();
  }

  set context(BuildContext value) {
    _context = value;
    notifyListeners();
  }

  set useCases(UseCases value) {
    _useCases = value;
    notifyListeners();
  }

  set maskFormatter(MaskTextInputFormatter value) {
    _maskFormatter = value;
    notifyListeners();
  }

  Register2Provider() {
    this._autoValidate = false;
    this.register2FormKey = GlobalKey<FormState>();
    this.countResend = 0;
    this._maskFormatter = new MaskTextInputFormatter(
        mask: '# # # #', filter: {"#": RegExp(r'[0-9]')});
    notifyListeners();
  }

  @override
  void requestSmsCode() async {

    showPreloader(context, "");

    var result = await useCases.requestSmsCode(
        AppApi.REQUESTSMSCODE_API,
        SendSmsCodeRequest(
            number: userRegisterRequest.phone));

    result.fold((exception) {

      hidePreloader(context);

      if (exception.runtimeType == ServerFailure)
        appSnackbar(
            context, getSmsErrorMessage((exception as ServerFailure).message));
      else
        SnackbarErrors(context: context, exp: exception);

    }, (model) async {

      var saveSmsRequestId =
          await useCases.saveSmsRequestId( model.requestId);

      saveSmsRequestId.fold((exception) {
        hidePreloader(context);

        SnackbarErrors(context: context, exp: exception);
      }, (bool) async {
        hidePreloader(context);

        appSnackbar(context, AppLocalizations.of(context).txtSBSentSmsCode);
      });
    });
  }

  @override
  void reSendCode() async {

    var getRequestId = await useCases.getSmsRequestId();

    getRequestId.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (requestId) async {
      //RequestId empty?
      if (requestId != "" && requestId != null) {
        reSendSmsCode(requestId);
      } else {
        //cancelSmsCode(requestId);
        appSnackbar(context, AppLocalizations.of(context).txtErSmsCodeTimeOut);
      }
    });
  }

  @override
  void reSendSmsCode(String requestId) async {
    showPreloader(context, "");

    var result = await useCases.resendSmsCode(
        AppApi.RESENDSMSCODE_API,
         ResendSmsCodeRequest(requestId: requestId));

    result.fold((exception) {
      hidePreloader(context);

      if (exception.runtimeType == ServerFailure)
        appSnackbar(
            context, getSmsErrorMessage((exception as ServerFailure).message));
      else
        SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      smsRequestId = model.requestId;

      var saveSmsRequestId =
          await useCases.saveSmsRequestId( model.requestId);

      saveSmsRequestId.fold((exception) {
        hidePreloader(context);

        SnackbarErrors(context: context, exp: exception);
      }, (bool) async {
        hidePreloader(context);

        appSnackbar(context, AppLocalizations.of(context).txtSBReSentSmsCode);
      });
    });
  }

  @override
  void getRequestIdStatus(String requestId) async {
    var result = await useCases.requestIdStatus(AppApi.REQUESTIDSTATUS_API,
        RequestIdStatusRequest(requestId: requestId));

    result.fold((exception) {
      if (exception.runtimeType == ServerFailure)
        appSnackbar(
            context, getSmsErrorMessage((exception as ServerFailure).message));
      else
        SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      switch (model.status) {
        case "IN PROGRESS":
          reSendSmsCode(requestId);
          break;
        default:
          requestSmsCode();
          break;
      }
    });
  }

  @override
  void resume() async {

    if (register2FormKey.currentState.validate()) {

      register2FormKey.currentState.save();

      showPreloader(context, "");

      var getRequestId = await useCases.getSmsRequestId();

      getRequestId.fold((exception) {

        hidePreloader(context);

        SnackbarErrors(context: context, exp: exception);

      }, (requestId) async {

        //RequestId empty?

        if (requestId != "" && requestId != null) {

          if (_pageIntent == PageIntents.ToVerifyCodeFromForgetPassword) {

            ///forgot password doğrula ve sms kodu db ye kaydet daha sonra şifreyi değiştir

            var result = await useCases.verifySmsCodeGbj(
                AppApi.getRequestUrl(AppApi.FORGOTPASSWORDVERIFY_API),
                VerifySmsCodeGbjRequest(
                    code: _maskFormatter.getUnmaskedText().toString(),
                    requestid: requestId,
                    phone: userRegisterRequest.phone
                ));

            result.fold((exception) {

              hidePreloader(context);

              SnackbarErrors(context: context, exp: exception);

            }, (model) async {

              hidePreloader(context);

              appIntent.data =  UserForgotPasswordRequest(
                  phone: userRegisterRequest.phone,
                  verifycode: _maskFormatter.getUnmaskedText().toString()
              );
              if(model.success==false){
                appSnackbar(context, model.message);
              }else{
                Navigator.pushNamedAndRemoveUntil(context,
                    AppRoutes.forgotpassword2, (Route<dynamic> route) => false);
              }



            });



          } else {

            // Verify sms code ?
            var result = await useCases.verifySmsCode(
               AppApi.VERIFYSMSCODE_API,
                VerifySmsCodeRequest(
                    code: _maskFormatter.getUnmaskedText().toString(),
                    requestId: requestId));

            result.fold((exception) {

              hidePreloader(context);

              if (exception.runtimeType == ServerFailure)
                appSnackbar(context, getSmsErrorMessage((exception as ServerFailure).message));
              else
                SnackbarErrors(context: context, exp: exception);

            }, (model) async {

              //Register user

              var saveUserResponse = await useCases.saveUser(AppApi.getRequestUrl(AppApi.REGISTER_API), userRegisterRequest);

              saveUserResponse.fold((exception) {

                hidePreloader(context);

                SnackbarErrors(context: context, exp: exception);

              }, (model) async {


                UserAdressRequest userAdressRequest=UserAdressRequest();
                userAdressRequest.userid=model.userid.toString();
                userAdressRequest.password=userRegisterRequest.password;
                userAdressRequest.phone=userRegisterRequest.phone;

                appIntent.data = userAdressRequest;

                hidePreloader(context);

             Navigator.pushNamedAndRemoveUntil(context, AppRoutes.register3,
                    (Route<dynamic> route) => false);

              });
            });
          }

        } else {

          hidePreloader(context);

          appSnackbar(context, AppLocalizations.of(context).txtErSmsCodeTimeOut);

        }
      });
    } else {
      autoValidate = true;
    }

  }

  @override
  String getSmsErrorMessage(String errorCode) {
    switch (errorCode) {
      case "1":
        return AppLocalizations.of(context).txtErSmsCode1;
        break;
      case "2":
        return AppLocalizations.of(context).txtErSmsCode2;
        break;
      case "3":
        return AppLocalizations.of(context).txtErSmsCode3;
        break;
      case "4":
        return AppLocalizations.of(context).txtErSmsCode4;
        break;
      case "5":
        return AppLocalizations.of(context).txtErSmsCode5;
        break;
      case "6":
        return AppLocalizations.of(context).txtErSmsCode6;
        break;
      case "7":
        return AppLocalizations.of(context).txtErSmsCode7;
        break;
      case "9":
        return AppLocalizations.of(context).txtErSmsCode9;
        break;
      case "10":
        return AppLocalizations.of(context).txtErSmsCode10;
        break;
      case "15":
        return AppLocalizations.of(context).txtErSmsCode15;
        break;
      case "16":
        return AppLocalizations.of(context).txtErSmsCode16;
        break;
      case "17":
        return AppLocalizations.of(context).txtErSmsCode17;
        break;
      case "18":
        return AppLocalizations.of(context).txtErSmsCode18;
        break;
      case "101":
        return AppLocalizations.of(context).txtErSmsCode101;
        break;
      default:
        return AppLocalizations.of(context).txtErSmsCodeGeneral;
        break;
    }
  }
}
