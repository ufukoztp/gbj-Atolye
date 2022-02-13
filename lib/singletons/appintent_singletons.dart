
import 'package:gbjatolye/utils/enums.dart';

class AppIntent {

  static final AppIntent _appIntent = new AppIntent._internal();

  PageIntents intent;
  var data;

  factory AppIntent() {
    return _appIntent;
  }

  AppIntent._internal();

}

final  appIntent = AppIntent();
