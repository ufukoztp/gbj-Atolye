import 'package:after_layout/after_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbjatolye/features/presentation/provider/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';


class SplashScreen extends StatefulWidget {

  final _useCases;

  SplashScreen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {

  SplashProvider splashProvider;

  @override
  void afterFirstLayout(BuildContext context) async {
    //splashProvider.playerController=  VideoPlayerController.asset('videos/bijuteri_splash.mp4')..play();

    splashProvider.initializeVideo();
    splashProvider.playerController.play();


    splashProvider.startTime();
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  void deactivate() {
    if (splashProvider.playerController != null) {
      splashProvider.playerController.setVolume(0.0);
      splashProvider.playerController.removeListener(splashProvider.listener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (splashProvider.playerController != null) splashProvider.playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    splashProvider = Provider.of<SplashProvider>(context);
    splashProvider.useCases=widget._useCases;
    splashProvider.context=context;

    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
          new AspectRatio(
              aspectRatio: 9 / 16,
              child: Container(
                child: (splashProvider.playerController != null
                    ? VideoPlayer(
                  splashProvider.playerController,
                ) : Container()),
              )),
        ]));
  }
}
