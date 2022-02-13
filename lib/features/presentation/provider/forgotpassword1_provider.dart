import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/features/domain/entities/account/user_exist.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


abstract class ForgotPassword1UseCases {
  void sendVerifyCode();
}

class ForgotPassword1Provider
    with ChangeNotifier
    implements ForgotPassword1UseCases {

  bool _autoValidate = false;
  TextEditingController _userGsmController;
  MaskTextInputFormatter _maskFormatter;
  GlobalKey<FormState> _forgotPassword1FormKey;
  BuildContext _context;
  UseCases _useCases;

  ///Getters
  ///
  bool get autoValidate => _autoValidate;

  TextEditingController get userGsmController => _userGsmController;

  BuildContext get context => _context;

  UseCases get useCases => _useCases;

  MaskTextInputFormatter get maskFormatter => _maskFormatter;

  GlobalKey<FormState> get forgotPassword1FormKey => _forgotPassword1FormKey;

  ///Setters
  ///
  set autoValidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }

  set forgotPassword1FormKey(GlobalKey<FormState> value) {
    _forgotPassword1FormKey = value;
    notifyListeners();
  }

  set userGsmController(TextEditingController value) {
    _userGsmController = value;
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

  ForgotPassword1Provider() {
    this._autoValidate = false;
    this._userGsmController = new TextEditingController();
    this._forgotPassword1FormKey = GlobalKey<FormState>();
    this._maskFormatter = new MaskTextInputFormatter(
        mask: '+90(###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});
    notifyListeners();
  }

  @override
  void sendVerifyCode() async {
    if (_forgotPassword1FormKey.currentState.validate()) {
      showPreloader(context, "");


      forgotPassword1FormKey.currentState.save();

      UserExistRequest sr = UserExistRequest(
        phone: "90" + maskFormatter.getUnmaskedText().toString(),
      );

      var existUser = await useCases.forgotPasswordCheckUser(AppApi.getRequestUrl(AppApi.EXISTUSER_API), UserExistRequest(
          phone:  "90" + maskFormatter.getUnmaskedText().toString()
      ));

      ///User varsa

      existUser.fold((exception) {

        hidePreloader(context);

        appSnackbar(context, 'kullanıcı bulunamadı');

        //SnackbarErrors(context: context, exp: exception);

      }, (model) async {


        hidePreloader(context);

        appIntent.intent = PageIntents.ToVerifyCodeFromForgetPassword;

        appIntent.data = "90" + maskFormatter.getUnmaskedText().toString();

        Navigator.pushNamed(context, AppRoutes.register2);

      });






    } else {
      autoValidate = true;
    }
  }
}
