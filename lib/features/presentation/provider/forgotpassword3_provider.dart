import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:flutter/cupertino.dart';

abstract class ForgotPassword3UseCases {
  void doLogin();
}


class ForgotPassword3Provider with ChangeNotifier implements ForgotPassword3UseCases {

  String _supplierPhone;
  BuildContext _context;
  UseCases _useCases;


  ///Getters
  ///

  BuildContext get context => _context;
  UseCases get useCases => _useCases;
  String get supplierPhone => _supplierPhone;


  ///Setters
  ///

  set context(BuildContext value) {
    _context = value;
    notifyListeners();
  }

  set supplierPhone(String value) {
    _supplierPhone = value;
    notifyListeners();
  }


  set useCases(UseCases value) {
    _useCases = value;
    notifyListeners();
  }


  ForgotPassword3Provider() {
    notifyListeners();
  }

  @override
  void doLogin() {

    appIntent.intent=PageIntents.ToSupplierPhoneFromForgetPassword;
    appIntent.data=supplierPhone;

    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login,
            (Route<dynamic> route) => false);

  }



}
