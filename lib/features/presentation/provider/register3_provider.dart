import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/features/domain/entities/account/user_adress.dart';
import 'package:gbjatolye/features/domain/entities/account/user_auth.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';

abstract class Register3UseCases {
  void complete();
  void doLogin();
}

class Register3Provider with ChangeNotifier implements Register3UseCases {
  bool _autoValidate = false;
  GlobalKey<FormState> _register3FormKey;
  BuildContext _context;
  UseCases _useCases;
  String _userId;
  UserAdressRequest _userAdressRequest;
  int _countryCode;
  String _countryName;
  TextEditingController _cityController;
  TextEditingController _adressController;

  Register3Provider() {
    this._autoValidate = false;
    this._register3FormKey = GlobalKey<FormState>();
    this.countryCode = 90;
    this.countryName = "Türkiye";
    _cityController = new TextEditingController();
    _adressController = new TextEditingController();
    notifyListeners();
  }

  ///Getters
  ///
  GlobalKey<FormState> get register3FormKey => _register3FormKey;

  String get userId => _userId;

  String get countryName => _countryName;

  UserAdressRequest get userAdressRequest => _userAdressRequest;

  bool get autoValidate => _autoValidate;

  TextEditingController get cityController => _cityController;

  BuildContext get context => _context;

  UseCases get useCases => _useCases;

  int get countryCode => _countryCode;

  TextEditingController get adressController => _adressController;

  ///Setters
  ///
  set register3FormKey(GlobalKey<FormState> value) {
    _register3FormKey = value;
    notifyListeners();
  }


  set userId(String value) {
    _userId = value;
    notifyListeners();
  }

  set adressController(TextEditingController value) {
    _adressController = value;
    notifyListeners();
  }

  set userAdressRequest(UserAdressRequest value) {
    _userAdressRequest = value;
    notifyListeners();
  }

  set autoValidate(bool value) {
    _autoValidate = value;
    notifyListeners();
  }

  set context(BuildContext value) {
    _context = value;
    notifyListeners();
  }

  set cityController(TextEditingController value) {
    _cityController = value;
    notifyListeners();
  }

  set countryCode(int value) {
    _countryCode = value;
    notifyListeners();
  }

  set useCases(UseCases value) {
    _useCases = value;
    notifyListeners();
  }

  set countryName(String value) {
    _countryName = value;
    notifyListeners();
  }

  @override
  void complete() async {

    if (register3FormKey.currentState.validate()) {

      register3FormKey.currentState.save();

      showPreloader(context, "");

      userAdressRequest.countrycode=countryCode.toString();
      userAdressRequest.city=cityController.text.toString();
      userAdressRequest.address=adressController.text.toString();

      doLogin();

    } else {
      autoValidate = true;
    }
  }

  @override
  void doLogin() async {
    var result = await useCases.getUserToken(
        AppApi.getRequestUrl(AppApi.TOKEN_API),
        UserTokenRequest(
            password: userAdressRequest.password,
            phone: userAdressRequest.phone
        ));

    result.fold((exception) {

      hidePreloader(context);

      SnackbarErrors(context: context, exp: exception);

    }, (model) async {
      hidePreloader(context);

      var resultLocalData =
          await useCases.saveLocalUserToken(model.token);

      resultLocalData.fold((exception) {
        SnackbarErrors(context: context, exp: exception);
      }, (success) async {
        Navigator.pushNamed(context, "");
      });
    });
  }
}
