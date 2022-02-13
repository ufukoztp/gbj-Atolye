import 'package:gbjatolye/features/domain/entities/account/user_auth.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:gbjatolye/app.dart';


abstract class LoginProviderUseCases {
  void updateCountryDialCode(String countryDialCode);
  void doLogin();
}

class LoginProvider with ChangeNotifier implements LoginProviderUseCases  {
  bool rememberMeState=false;
SharedPreferences prf;
  Map _source = {ConnectivityResult.none: false};
  bool _obscureText = true;
  bool _eyeClosed = false;
  // ignore: non_constant_identifier_names
  bool _eye_opened = false;
  bool _switchRememberme = true;
  bool _autoValidate = false;
  GlobalKey<FormState> _formKey;
  MaskTextInputFormatter _maskFormatter;
  TextEditingController _userGsmController;
  TextEditingController _passwordController;
  BuildContext _context;
  UseCases _useCases;
  double _numberInputWidth;


  ///Getter
  ///
  GlobalKey<FormState> get formKey => _formKey;

  Map get source => _source;

  double get numberInputWidth => _numberInputWidth;

  MaskTextInputFormatter get maskFormatter => _maskFormatter;

  TextEditingController get userGsmController => _userGsmController;

  TextEditingController get passwordController => _passwordController;

  BuildContext get context => _context;

  UseCases get useCases => _useCases;

  bool get eyeOpened => _eye_opened;

  bool get eyeClosed => _eyeClosed;

  bool get obscureText => _obscureText;

  bool get switchRememberme => _switchRememberme;

  bool get autoValidate => _autoValidate;

  ///Setters
  ///
  set userGsmController(TextEditingController value) {
    _userGsmController = value;
    notifyListeners();
  }

  set numberInputWidth(double value) {
    _numberInputWidth = value;
    notifyListeners();
  }


  set source(Map value) {
    _source = value;
    notifyListeners();
  }

  set switchRememberme(bool value) {
    _switchRememberme = value;
    notifyListeners();
  }

  set autoValidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }

  set passwordController(TextEditingController value) {
    _passwordController = value;
    notifyListeners();
  }

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  set eyeClosed(bool value) {
    _eyeClosed = value;
    notifyListeners();
  }

  set eyeOpened(bool value) {
    _eye_opened = value;
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

  LoginProvider() {
    this._obscureText = true;
    this._eyeClosed = false;
    this._eye_opened = false;
    this._userGsmController = new TextEditingController();
    this._passwordController = new TextEditingController();
    this._switchRememberme = true;
    this._autoValidate = false;
    this._formKey = GlobalKey<FormState>();
    this._numberInputWidth=80;

    this._maskFormatter = new MaskTextInputFormatter(
        mask: '+90(###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});

   // this._maskFormatter = new MaskTextInputFormatter(mask: '#################', filter: {"#": RegExp(r'[0-9]')});
    notifyListeners();
  }

  reLoginProvider() {
    notifyListeners();
  }

  ///LoginProvider UseCases
  ///
@override
void doLogin() async {
  if (this.formKey.currentState.validate()) {
    showPreloader(context, "");

    var username = "";

     if (maskFormatter.getUnmaskedText().toString() == "" ||
        maskFormatter.getUnmaskedText().toString() == null)
      username ="90"+ _maskFormatter.unmaskText(userGsmController.text).toString();
    else
      username ="90"+ maskFormatter.getUnmaskedText().toString();
print(maskFormatter.getUnmaskedText().toString());
print(username);
    var result = await useCases.getUserToken(
        AppApi.getRequestUrl(AppApi.TOKEN_API),
        UserTokenRequest(password: this.passwordController.text, phone: username));

    result.fold((exception) {

      hidePreloader(context);

      SnackbarErrors(context: context, exp: exception);

    }, (model) async {

      var resultLocalData = await useCases.saveLocalUserToken(model.token);

      resultLocalData.fold((exception) {

        hidePreloader(context);

        SnackbarErrors(context: context, exp: exception);

      }, (success) async {

        var resultRememberMeData =
        await useCases.saveRememberMe(rememberMeState);

        resultRememberMeData.fold((exception) {
          hidePreloader(context);

          SnackbarErrors(context: context, exp: exception);
        }, (success) async {

          hidePreloader(context);

          this.formKey.currentState.save();

          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.drawermain, (Route<dynamic> route) => false);

        });
      });
    });
  } else {
    this.autoValidate = true;
  }
}

prefdoldur()async{
  prf=await SharedPreferences.getInstance();
  if(prf.getBool("remember_me_State")!=null){
    switchRememberme=prf.getBool("remember_me_State");}
  passwordController.text="";
  if(switchRememberme==true){
   userGsmController.text= _maskFormatter.maskText(prf.getString("number"));
  }
}



  @override
  void updateCountryDialCode(String countryDialCode) {
      switch(int.parse(countryDialCode).toString().length){
        case 1:
          numberInputWidth=75.0;
          break;
        case 2:
          numberInputWidth=80.0;
          break;
        case 3:
          numberInputWidth=90.0;
          break;
        case 4:
          numberInputWidth=95.0;
          break;
      }
  }





}
