import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

abstract class SplashProviderUseCases {
  startTime();

  navigationPage();

  initializeVideo();
}

class SplashProvider with ChangeNotifier implements SplashProviderUseCases {

  VideoPlayerController _playerController;
  VoidCallback _listener;
  BuildContext _context;
  UseCases _useCases;

  SplashProvider() {

    this._listener = listener = () {
      notifyListeners();
    };


    notifyListeners();
  }

  reSplashProvider() {
    notifyListeners();
  }


  @override
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  @override
  navigationPage() async {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);

    var resultRememberMe = await _useCases.getRememberMe();

    resultRememberMe.fold((exception) {

     SnackbarErrors(context: context, exp: exception);

    }, (rememberMe) async {

      if(rememberMe){

        var result = await _useCases.getLocalUserToken();

        result.fold((exception) {

          SnackbarErrors(context: context, exp: exception);

        }, (token) async {

          if (token != "" || token == null)
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.drawermain, (Route<dynamic> route) => false);

          else
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.splash, (Route<dynamic> route) => false);
        });

      }else{
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.onboarding, (Route<dynamic> route) => false);
      }

    });

  }

  @override
  initializeVideo() {
    playerController = VideoPlayerController.asset('videos/bijuteri_splash.mp4')
      ..addListener(listener)
      ..setVolume(0.0)
      ..initialize()
      ..play();
  }

  ///Getters
  ///
  VoidCallback get listener => _listener;

  VideoPlayerController get playerController => _playerController;

  // ignore: unnecessary_getters_setters
  BuildContext get context => _context;

  // ignore: unnecessary_getters_setters
  UseCases get useCases => _useCases;

  ///Setters
  ///
  set listener(VoidCallback value) {
    _listener = value;
    notifyListeners();
  }

  set playerController(VideoPlayerController value) {
    _playerController = value;
    notifyListeners();
  }

  // ignore: unnecessary_getters_setters
  set context(BuildContext value) {
    _context = value;
  }

  // ignore: unnecessary_getters_setters
  set useCases(UseCases value) {
    _useCases = value;
  }
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
      //super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('Provider', Provider));
  }
}
