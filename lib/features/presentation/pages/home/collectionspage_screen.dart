import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gbjatolye/features/data/datasources/remote_data_source.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevicee.dart';
import 'package:gbjatolye/features/domain/entities/product/arguments.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/provider/homepage_provider.dart';
import 'package:gbjatolye/features/presentation/provider/notifications_provider.dart';
import 'package:gbjatolye/features/presentation/provider/orderlist_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/collectionpage_widgets.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/globals.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../app.dart';
import 'package:package_info/package_info.dart';
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("gelen data message background ${message.toString()}");

  if (message.containsKey('data')) {
    ShowNotification.showMessage(message);
  }

}
// ignore: must_be_immutable
class CollectionPageScreen extends KFDrawerContent {
  final _useCases;

  CollectionPageScreen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return CollectionPageScreenState(_useCases);
  }
}

class CollectionPageScreenState extends State<CollectionPageScreen>
    with AfterLayoutMixin<CollectionPageScreen>, SingleTickerProviderStateMixin {
  UseCases _useCases;
  CollectionPageScreenState(this._useCases);
  HomePageProvider _homePageProvider;
  Animation<Color> animation;
  AnimationController controller;
  RemoteDataSourceImp _dataSourceImp;
  @override
  void afterFirstLayout(BuildContext context) async {



    _homePageProvider.context = context;

    _homePageProvider.useCases = _useCases;

    await _homePageProvider.getCollectionList();
    _homePageProvider.getCurrencyList();
    await _homePageProvider.getHome();
    var homeShowcase = await _useCases.getHomeShowcaseView();
    _homePageProvider.getNotificationPermision();







    homeShowcase.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (val) async {
      if (val)
        WidgetsBinding.instance.addPostFrameCallback(
                (_) =>
                ShowCaseWidget.of(context).startShowCase([
                  _homePageProvider.hamburgerShowcaseKey,
                  _homePageProvider.hamburgerShowcaseKey2,
                  _homePageProvider.notShowcaseKey,
                  _homePageProvider.notShowcaseKey2,
                  _homePageProvider.orderShowcaseKey,
                  _homePageProvider.orderShowcaseKey2,
                  _homePageProvider.colShowcaseKey,
                  _homePageProvider.colShowcaseKey2,
                ]));
    });


    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('launcher_icon');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        onDidReceiveLocalNotification:onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification:onSelectNotification);


    try {
      versionCheck(context);
    } catch (e) {
      print(e);
    }
     currentScaffoldState = GlobalKeys.scaffoldKeyCollection;





  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  registerDevice(devicetoken) async {
    var responseUserToken = await _useCases.getLocalUserToken();
    responseUserToken.fold((exception) {
      print(exception.toString() + " local user");
      SnackbarErrors(context: context, exp: exception);
    }, (userToken) async {
      print(userToken + "kullanıcı token");

       var registerDevice;
      /*
       var status = await Permission.notification.status;
       var listTagRequest = List<TagRequest>();

      if (!status.isUndetermined &&
          !status.isDenied &&
          !status.isPermanentlyDenied &&
          !status.isRestricted) {

        var generalInfo = await _useCases.getCustomNotificationStatus();
        generalInfo.fold((exception) {
          SnackbarErrors(context: context, exp: exception);
        }, (status) async {
          if (status) {
            var tagRequest = TagRequest();
            tagRequest.tag = "generalinfo";
            listTagRequest.add(tagRequest);
          }
        });

        var productLike = await _useCases.getProductLikeNotificationStatus();
        productLike.fold((exception) {
          SnackbarErrors(context: context, exp: exception);
        }, (status) async {
          if (status) {
            var tagRequest = TagRequest();
            tagRequest.tag = "productlike";
            listTagRequest.add(tagRequest);
          }
        });

        var productInsert = await _useCases.getProductAddedNotificationStatus();
        productInsert.fold((exception) {
          SnackbarErrors(context: context, exp: exception);
        }, (status) async {
          if (status) {
            var tagRequest = TagRequest();
            tagRequest.tag = "productinsert";
            listTagRequest.add(tagRequest);
          }
        });

        var productOrder = await _useCases.getOrderNotificationStatus();
        productOrder.fold((exception) {
          SnackbarErrors(context: context, exp: exception);
        }, (status) async {
          var tagRequest = TagRequest();
          tagRequest.tag = "productorder";
          listTagRequest.add(tagRequest);
        });
      }
*/
      registerDevice = Registerdevice(deviceId: devicetoken,
          pushDeviceType: 1.toString(),
          pushTarget: 0.toString());
      var responseRegisterDevice = await _useCases.registerDevice(
          AppApi.getRequestUrl(AppApi.REGISTERDEVICE_API), registerDevice);
      responseRegisterDevice.fold((exception) {
        print(exception.toString() + " register device");
        SnackbarErrors(context: context, exp: exception);
      }, (success) {
        print("Success register device2: "+ success.success.toString());
      });
    });
  }



  @override
  void initState() {
    _dataSourceImp=RemoteDataSourceImp();


    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    final CurvedAnimation curve =
    CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    animation =
        ColorTween(begin: AppTheme.darkRed[50], end: AppTheme.darkTangerine[50])
            .animate(curve);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });

    ///Notification register widget class içinde

    if(true){
      ///Notification Register Started

      FirebaseMessaging firebaseMessaging = FirebaseMessaging();

      firebaseMessaging.getToken().then((token) async {
        print('token başarılı');
        await registerDevice(token);

        print(token);
      }
      );
      firebaseMessaging.subscribeToTopic("all");
      firebaseMessaging.configure(

        onBackgroundMessage: myBackgroundMessageHandler,
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          ShowNotification.showMessage(message);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          if(Platform.isAndroid)
            _homePageProvider.deepRoutingAndroid(message);
          if(Platform.isIOS)
            _homePageProvider.deepRoutingIos(message);

        },
        onResume: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
          if(Platform.isAndroid)
            _homePageProvider.deepRoutingAndroid(message);
          if(Platform.isIOS)
            _homePageProvider.deepRoutingIos(message);

        },
      );


      firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));

      firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered5: $settings");

        /*
        if(settings.alert==true){
          _homePageProvider.changeLocalAllNotificationStatus(true);
        }else{
          _homePageProvider.changeLocalAllNotificationStatus(false);

        }

         */


      });

      ///Notification Register Finished
    }






    controller.forward();

    super.initState();


  }



  @override
  Widget build(BuildContext context) {
    _homePageProvider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.white[50],
        actions: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                children: <Widget>[
                  Showcase(
                    key: _homePageProvider.hamburgerShowcaseKey2,
                    description:
                    AppLocalizations
                        .of(context)
                        .txtShowcaseHamburgerMenu,
                    descTextStyle: Theme
                        .of(context)
                        .textTheme.headline4,
                    animationDuration: Duration(milliseconds: 500),
                    child: InkWell(
                      onTap: !_homePageProvider.isLoading
                          ? widget.onMenuPressed
                          : null,
                      child: Padding(
                        child: Image.asset(
                          'images/ic_hamburger_menu.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                        padding: EdgeInsets.only(
                            right: 15.0, left: 15.0, top: 15.0, bottom: 15.0),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 30,
                        child: Image.asset(

                          'images/ic_home_title.png',
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      )),

                  Showcase(
                    key: _homePageProvider.orderShowcaseKey2,
                    description:
                    AppLocalizations.of(context).txtShowcaseOrder,
                    descTextStyle: Theme.of(context).textTheme.headline1,
                    animationDuration: Duration(milliseconds: 500),
                    child: Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (!_homePageProvider.isLoading) {
                              Provider.of<OrderListProvider>(context,
                                  listen: false)
                                  .reOrderListProvider();
                              Navigator.pushNamed(context, AppRoutes.orders);
                            }
                          },
                          child: Padding(
                            child: Image.asset(
                              'images/ic_orderbag.png',
                              width: 25,
                              height: 25,
                              fit: BoxFit.contain,
                            ),
                            padding: EdgeInsets.only(
                                right: 15.0,
                                left: 15.0,
                                top: 15.0,
                                bottom: 15.0),
                          ),
                        ),
                        Visibility(
                          visible:
                          _homePageProvider.ordercount > 0 ? true : false,
                          child: AnimatedBuilder(
                              animation: animation,
                              builder: (BuildContext context, Widget child) {
                                return new Container(
                                  child: Positioned(
                                    right: 10.0,
                                    top: 10.0,
                                    child: ClipOval(
                                      child: Container(
                                        color: animation.value,
                                        height: 10.0, // height of the button
                                        width: 10.0, // width of the button
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                  Showcase(
                    key: _homePageProvider.notShowcaseKey2,
                    description:
                    AppLocalizations.of(context).txtShowcaseNotifications,
                    descTextStyle: Theme.of(context).textTheme.headline2,
                    animationDuration: Duration(milliseconds: 500),
                    child: Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (!_homePageProvider.isLoading) {
                              Provider.of<NotificationsProvider>(context,
                                  listen: false)
                                  .reNotificationsProvider();
                              Navigator.pushNamed(
                                  context, AppRoutes.notifications);
                            }
                          },
                          child: Padding(
                            child: Image.asset(
                              'images/ic_notifications.png',
                              width: 25,
                              height: 25,
                              fit: BoxFit.contain,
                            ),
                            padding: EdgeInsets.only(
                                right: 15.0,
                                left: 15.0,
                                top: 15.0,
                                bottom: 15.0),
                          ),
                        ),
                        Visibility(
                          visible: _homePageProvider.notificationcount > 0
                              ? true
                              : false,
                          child: AnimatedBuilder(
                              animation: animation,
                              builder: (BuildContext context, Widget child) {
                                return new Container(
                                  child: Positioned(
                                    right: 10.0,
                                    top: 10.0,
                                    child: ClipOval(
                                      child: Container(
                                        color: animation.value,
                                        height: 10.0, // height of the button
                                        width: 10.0, // width of the button
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),



                ],
              ),
            ),
          )
        ],
      ),
      key: GlobalKeys.scaffoldKeyCollection,

      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: Stack(
        children: <Widget>[
          Visibility(
            visible: _homePageProvider.collectionGruop != null &&
                !_homePageProvider.isLoading
                ? true
                : false,
            child: CollectionPageWidgets(
                homePageProvider: _homePageProvider, useCase: _useCases),
          ),
          Visibility(
            visible: _homePageProvider.isLoading,
            child: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[CupertinoActivityIndicator()],
              ),
            ),
          ),
        ],
      ),


    );
  }


  versionCheck(context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    print(info.appName);
    double currentVersion = double.parse(
        info.version.trim().replaceAll(".", ""));
print(currentVersion);
    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
        await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      double newVersion = double.parse(remoteConfig
          .getString('force_update_current_version')
          .trim()
          .replaceAll(".", ""));
      print(newVersion);
      if (newVersion > currentVersion) {
        _homePageProvider.showVersionDialogForce(context);
      }
    } catch (exception) {
      // Fetch throttled.
      print(exception);
    }

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      double newVersion = double.parse(remoteConfig
          .getString('soft_update_current_version')
          .trim()
          .replaceAll(".", ""));
      print(newVersion);
      if (newVersion > currentVersion) {
        _homePageProvider.showVersionDialogSoft(context);
      }
    } catch (exception) {
      // Fetch throttled.
      print(exception);
    }

  }

  Future onSelectNotification(String route) async {
 print('android tıklandı');
 return Future.value(2);

  }

  Future<dynamic>onDidReceiveLocalNotification(int id, String title, String body,
      String payload) {
    print('android tıklandı');

    return Future.value(2);
  }
}

class ShowNotification{


  static Future showMessage([Map<String, dynamic> message]) async{
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(

      '1234', 'kanal1', 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
       icon: "images/ic_atolye.png",
      ticker: 'ticker',
      color: Colors.amberAccent,
    );


    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, message['title']['title'],message['title']['body'], platformChannelSpecifics,
        payload:'sadsa');

  }


}