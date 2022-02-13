import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevicee.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/pages/home/collectionspage_screen.dart';
import 'package:gbjatolye/features/presentation/provider/homepage_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcase.dart';
import '../../../app.dart';
import 'dart:io';


class CollectionPageWidgets extends StatefulWidget {
  final HomePageProvider homePageProvider;
  final UseCases useCase;





  const CollectionPageWidgets(
      {@required this.homePageProvider, @required this.useCase});

  @override
  _CollectionPageWidgetsState createState() => _CollectionPageWidgetsState();
}

class _CollectionPageWidgetsState extends State<CollectionPageWidgets> {

  HomePageProvider _homePageProvider;


  registerDevice(devicetoken) async {
    var responseUserToken = await widget.useCase.getLocalUserToken();
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
      var responseRegisterDevice = await widget.useCase.registerDevice(
          AppApi.getRequestUrl(AppApi.REGISTERDEVICE_API), registerDevice);
      responseRegisterDevice.fold((exception) {
        print(exception.toString() + " register device");
        SnackbarErrors(context: context, exp: exception);
      }, (success) {
        print("Success register device: "+devicetoken);
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    _homePageProvider=widget.homePageProvider;

  widget.homePageProvider.getNotificationPermision().then((value) {
    if(_homePageProvider.notificationStatus==true){
      print("çalıştı");
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
        print("Settings registered: $settings");

      });

      ///Notification Register Finished
    }

  });




    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
        itemBuilder: (context, position) {



          return  InkWell(
            child: Padding(

                padding: EdgeInsets.all(10),
                child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                              borderRadius:
                              BorderRadius.all(const Radius.circular(10.0)),
                              child: CachedNetworkImage(
                                imageUrl:
                                  widget.homePageProvider.collectionGruop[position].bannerPortrait,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      width: double.maxFinite,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top:32),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,

                                children: <Widget>[
                                  Text(

                                  widget.homePageProvider.collectionGruop[position].collectionGroupName,
                                    style: TextStyle(
                                        color: AppTheme.collectionPageColor[50],
                                        fontFamily: 'MontserratSemiBold',
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    widget.homePageProvider.collectionGruop[position].description,
                                    style: TextStyle(
                                        color: AppTheme.collectionPageColor[50],
                                        fontSize: 13.0),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20.0),
                                  ),

                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
            onTap: () {

  widget.homePageProvider.collectionGroupId=widget.homePageProvider.collectionGruop[position].collectionGroupId;


    Navigator.pushNamed(context, AppRoutes.jewelerytypes,arguments: widget.homePageProvider.collectionGruop[position].collectionGroupName );


              }

          );


        },
        itemCount: widget.homePageProvider.collectionGruop.length,
      ),
    );
  }

  Widget _joinWidget(Widget widget, int position, BuildContext context) {
    return position == 0
        ? Showcase(
        key: _homePageProvider.colShowcaseKey,
        description: AppLocalizations.of(context).txtShowcaseCollectionItem,
        descTextStyle: Theme.of(context).textTheme.headline4,
        animationDuration: Duration(milliseconds: 500),
        child: widget)
        : widget;
  }

  expansion(var subCategoryList, int position) {
    return;
  }
}
