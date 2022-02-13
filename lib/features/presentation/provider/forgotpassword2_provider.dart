import 'package:gbjatolye/features/domain/entities/account/user_forgot_password.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';

import '../../../app.dart';

abstract class ForgotPassword2UseCases {
  void updateSupplierPassword();
}

class ForgotPassword2Provider
    with ChangeNotifier
    implements ForgotPassword2UseCases {

  bool _autoValidate = false;
  bool _obscureText = true;
  bool _eyeClosed = false;
  bool _eyeOpened = false;
  TextEditingController _passwordController;
  GlobalKey<FormState> _forgotPassword2FormKey;
  UserForgotPasswordRequest _userForgotPasswordRequest;
  BuildContext _context;
  UseCases _useCases;

  ///Getters
  ///
  bool get eyeOpened => _eyeOpened;

  bool get eyeClosed => _eyeClosed;

  bool get obscureText => _obscureText;

  bool get autoValidate => _autoValidate;

  TextEditingController get passwordController => _passwordController;

  BuildContext get context => _context;

  UseCases get useCases => _useCases;

  GlobalKey<FormState> get forgotPassword2FormKey => _forgotPassword2FormKey;

  UserForgotPasswordRequest get userForgotPasswordRequest =>
      _userForgotPasswordRequest;


  ///Setters
  ///
  set passwordController(TextEditingController value) {
    _passwordController = value;
    notifyListeners();
  }

  set userForgotPasswordRequest(UserForgotPasswordRequest value) {
    _userForgotPasswordRequest = value;
    notifyListeners();
  }

  set autoValidate(bool value) {
    _autoValidate = value;
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
    _eyeOpened = value;
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

  set forgotPassword2FormKey(GlobalKey<FormState> value) {
    _forgotPassword2FormKey = value;
    notifyListeners();
  }

  ForgotPassword2Provider() {
    this._autoValidate = false;
    this._obscureText = true;
    this._eyeClosed = false;
    this._eyeOpened = false;
    this._passwordController = new TextEditingController();
    this.forgotPassword2FormKey = GlobalKey<FormState>();
    notifyListeners();
  }

  @override
  void updateSupplierPassword() async {

    if (_forgotPassword2FormKey.currentState.validate()) {
      _forgotPassword2FormKey.currentState.save();

      showPreloader(context, "");

      userForgotPasswordRequest.password=passwordController.text.toString();


      var resultChangedPassword = await useCases.changeUserPassword(
          AppApi.getRequestUrl(AppApi.CHANGEPASSWORD_API),
          userForgotPasswordRequest
      );

      resultChangedPassword.fold((exception) {
        print('hata yeni şifre'+exception.toString());
        hidePreloader(context);

        SnackbarErrors(context: context, exp: exception);

      }, (model) async {

        hidePreloader(context);

        appIntent.data = userForgotPasswordRequest.phone;

        Navigator.pushNamed(context, AppRoutes.forgotpassword3);

      });

    } else {
      autoValidate = true;
    }
  }
}
