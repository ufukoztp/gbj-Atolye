import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:flutter/cupertino.dart';

class SnackbarErrors {

  SnackbarErrors({BuildContext context, Failure exp}) {
    switch (exp.runtimeType) {
      case CacheFailure:
        print( (exp as CacheFailure).message);
        appSnackbar(context, (exp as CacheFailure).message);
        break;
      case ServerFailure:
        print((exp as ServerFailure).message);
        appSnackbar(context, (exp as ServerFailure).message);
        break;
      case SocketFailure:
        appSnackbar(context, AppLocalizations.of(context).txtErInternetError);
        break;
    }
  }

}
