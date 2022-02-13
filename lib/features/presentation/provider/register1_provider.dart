import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/features/domain/entities/account/__currencies.dart';
import 'package:gbjatolye/features/domain/entities/account/currency.dart';
import 'package:gbjatolye/features/domain/entities/account/user_exist.dart';
import 'package:gbjatolye/features/domain/entities/account/user_register.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app.dart';

abstract class Register1UseCases {
  void resume();
  List<Widget> getCurrencyWidgetList();
  void getCurrencyList();
}

class Register1Provider with ChangeNotifier implements Register1UseCases {
  SharedPreferences prf;
  bool loadingCurrency=false;
   List<Currencies> currencies;
  bool _autoValidate = false;
  bool _eyeClosed = false;
  bool _eyeOpened = false;
  bool _obscureText = true;
  bool _checkTermOfUse = false;
  int _radioValue = 3;
  TextEditingController _companyNameController;
  TextEditingController _userGsmController;
  TextEditingController _personNameController;
  TextEditingController _personSurnameController;
  TextEditingController _passwordController;
  FocusNode _companyName=FocusNode();

  FocusNode get companyName => _companyName;

  set companyName(FocusNode value) {
    _companyName = value;
  }

  FocusNode _userGsm=FocusNode();
  FocusNode _personName=FocusNode();
  FocusNode _personSurname=FocusNode();
  FocusNode _password=FocusNode();
  BuildContext _context;
  UseCases _useCases;
  MaskTextInputFormatter _maskFormatter;
  GlobalKey<FormState> _register1FormKey;
  List<Currency> _currencyList;


  ///Getter
  ///
  BuildContext get context => _context;

  TextEditingController get personSurnameController => _personSurnameController;

  List<Currency> get currencyList =>_currencyList;

  UseCases get useCases => _useCases;

  MaskTextInputFormatter get maskFormatter => _maskFormatter;

  int get radioValue => _radioValue;

  bool get checkTermOfUse => _checkTermOfUse;

  bool get eyeOpened => _eyeOpened;

  bool get autoValidate => _autoValidate;

  bool get obscureText => _obscureText;

  bool get eyeClosed => _eyeClosed;

  FocusNode get userGsm => _userGsm;

  FocusNode get personName => _personName;

  FocusNode get personSurname => _personSurname;

  FocusNode get password => _password;

  TextEditingController get userGsmController => _userGsmController;

  TextEditingController get companyNameController => _companyNameController;

  TextEditingController get personNameController => _personNameController;

  TextEditingController get passwordController => _passwordController;

  GlobalKey<FormState> get register1FormKey => _register1FormKey;

  ///Setter
  ///
  set checkTermOfUse(bool value) {
    _checkTermOfUse = value;
    notifyListeners();
  }

  set personSurnameController(TextEditingController value) {
    _personSurnameController = value;
    notifyListeners();
  }

  set register1FormKey(GlobalKey<FormState> value) {
    _register1FormKey = value;
    notifyListeners();
  }

  set radioValue(int value) {
    _radioValue = value;
    notifyListeners();
  }

  set context(BuildContext value) {
    _context = value;
    notifyListeners();
  }

  set companyNameController(TextEditingController value) {
    _companyNameController = value;
    notifyListeners();
  }

  set userGsmController(TextEditingController value) {
    _userGsmController = value;
    notifyListeners();
  }

  set currencyList(List<Currency> value) {
    _currencyList = value;
    notifyListeners();
  }


  set personNameController(TextEditingController value) {
    _personNameController = value;
    notifyListeners();
  }

  set passwordController(TextEditingController value) {
    _passwordController = value;
    notifyListeners();
  }

  set autoValidate(bool value) {
    _autoValidate = value;
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

  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  set userGsm(FocusNode value) {
    _userGsm = value;
  }


  set personName(FocusNode value) {
    _personName = value;
  }


  set personSurname(FocusNode value) {
    _personSurname = value;
  }


  set password(FocusNode value) {
    _password = value;
  }

  set useCases(UseCases value) {
    _useCases = value;
    notifyListeners();
  }

  set maskFormatter(MaskTextInputFormatter value) {
    _maskFormatter = value;
    notifyListeners();
  }

  Register1Provider() {
    this._autoValidate = false;
    this._obscureText = true;
    this._eyeClosed = false;
    this._eyeOpened = false;
    this._checkTermOfUse = false;
    this._userGsmController = new TextEditingController();
    this._passwordController = new TextEditingController();
    this._personNameController = new TextEditingController();
    this._personSurnameController = new TextEditingController();
    this._companyNameController = new TextEditingController();
    this._register1FormKey = GlobalKey<FormState>();
    this.currencyList=List<Currency>();
    this._maskFormatter = new MaskTextInputFormatter(
        mask: '+90(###) ### ## ##', filter: {"#": RegExp(r'[0-9]')});
    notifyListeners();
  }

  reRegister1Provider() {
    notifyListeners();
  }

  @override
  void resume() async {
    showPreloader(context, "");

    if (register1FormKey.currentState.validate()) {
      register1FormKey.currentState.save();

      if (!checkTermOfUse) {
        hidePreloader(context);
        appSnackbar(context, AppLocalizations.of(context).txtSBTermOfCond);
        return;
      }

      UserRegisterRequest sr = UserRegisterRequest(
          name: personNameController.text,
          lastName: personSurnameController.text,
          brandName: companyNameController.text,
          phone: "90" + maskFormatter.getUnmaskedText().toString(),
          password: passwordController.text,
          currencyid: radioValue.toString(),
      );
      var saveLocalPriceType = await useCases.savePriceType(radioValue.toString());


      var existUser = await useCases.existUser(
          AppApi.getRequestUrl(AppApi.EXISTUSER_API),
          UserExistRequest(phone: "90" + maskFormatter.getUnmaskedText().toString()));

      existUser.fold((exception) {
        hidePreloader(context);

        SnackbarErrors(context: context, exp: exception);

       if((exception as ServerFailure).message=="Bu numaraya ait kullanıcı bulunmaktadır."){

         Navigator.of(context).pop();

       }

      }, (model) async {
        hidePreloader(context);

        appIntent.intent = PageIntents.ToVerifyCodeFromRegister;

        appIntent.data = sr;

        Navigator.pushNamed(context, AppRoutes.register2);
      });
    } else {
      hidePreloader(context);

      autoValidate = true;

    }

  }

  @override
  void getCurrencyList() async {

    var result = await useCases.getCurrencyList(AppApi.getRequestUrl(AppApi.CURRENCYLIST_API));

    result.fold((exception) {

      SnackbarErrors(context: context, exp: exception);

    }, (success) async {
      List<Currencies> temp = List<Currencies>();

      for(var i in success.currencies){
        temp.add(i);
      }
      currencies=temp;
      loadingCurrency=true;


    });
    notifyListeners();


  }


  @override
  List<Widget> getCurrencyWidgetList() {
   List<Widget> widgets=List<Widget>();
   for(Currencies c in currencies){
     widgets.add(new Row(
       children: <Widget>[
         new Radio(
           value: c.id,
           activeColor: AppTheme.aqua[50],
           groupValue: radioValue,
           onChanged: (value) {
             radioValue = value;
           },
         ),
         Expanded(
             child: InkWell(
               child: Container(
                 height: 50.0,
                 width: double.minPositive,
                 alignment: Alignment.centerLeft,
                 child: new Text(
                     c.name,
                     style: Theme.of(context).textTheme.headline4,
                 ),
               ),
               onTap: () {
                    radioValue = c.id;
               },
             ))
       ],
     ));
   }
    return widgets;
  }




}
