import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gbjatolye/features/domain/entities/account/__currencies.dart';
import 'package:gbjatolye/features/domain/entities/collection_groups.dart';
import 'package:gbjatolye/features/domain/entities/home/home.dart';
import 'package:gbjatolye/features/domain/entities/jewelerytypes.dart';
import 'package:gbjatolye/features/domain/entities/product/arguments.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gbjatolye/utils/atolyeexpansiontile.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

abstract class HomePageUseCases {
//  Future getHomeInfo();

  Future getCollectionList();
  Future getHome();
  Future getNotificationPermision();
}

class HomePageProvider with ChangeNotifier implements HomePageUseCases {
  // ignore: non_constant_identifier_names
  var APP_STORE_URL =
      'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
  // ignore: non_constant_identifier_names
  var PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=YOUR-APP-ID';

  int supplierId;
  int collectionGroupId;
  List<Currencies> currencies;
  List <GlobalKey<AppExpansionTileState>>deneme;
  List<CollectionGroups> collectionGruop;
  List<Jewelrytypes> _jewelerytpess;


 

  List<Subjewelrytypes> subJewelerTypess;
  bool expanded = false;
  List<CategoryList> _categorylist;
  BuildContext _context;
  int _ordercount = 0;
  int _notificationcount = 0;
  UseCases _useCases;
  String _productUpdateDate;
  bool _isLoading;
  bool _notificationStatus;

  bool get notificationStatus => _notificationStatus;

  set notificationStatus(bool value) {
    _notificationStatus = value;
    notifyListeners();
  }

  GlobalKey _hamburgerShowcaseKey = GlobalKey();
  GlobalKey _hamburgerShowcaseKey2 = GlobalKey();
  GlobalKey _notShowcaseKey = GlobalKey();
  GlobalKey _notShowcaseKey2 = GlobalKey();
  GlobalKey _orderShowcaseKey = GlobalKey();
  GlobalKey _orderShowcaseKey2 = GlobalKey();
  GlobalKey _colShowcaseKey = GlobalKey();
  GlobalKey _colShowcaseKey2 = GlobalKey();



  List<GlobalKey<AppExpansionTileState>> expansionTileList;

  ///Getters
  ///

  bool get isLoading => _isLoading;

  List<CategoryList> get categorylist => _categorylist;

  int get notificationcount => _notificationcount;

  int get ordercount => _ordercount;

  BuildContext get context => _context;

  UseCases get useCases => _useCases;

  String get productUpdateDate => _productUpdateDate;

  // ignore: unnecessary_getters_setters
  GlobalKey get colShowcaseKey => _colShowcaseKey;

  GlobalKey get colShowcaseKey2 => _colShowcaseKey2;

  // ignore: unnecessary_getters_setters
  GlobalKey get orderShowcaseKey => _orderShowcaseKey;

  GlobalKey get orderShowcaseKey2 => _orderShowcaseKey2;

  List<Jewelrytypes> get jewelerytpess => _jewelerytpess;


  // ignore: unnecessary_getters_setters
  GlobalKey get notShowcaseKey => _notShowcaseKey;

  GlobalKey get notShowcaseKey2 => _notShowcaseKey2;

  // ignore: unnecessary_getters_setters
  GlobalKey get hamburgerShowcaseKey => _hamburgerShowcaseKey;

  GlobalKey get hamburgerShowcaseKey2 => _hamburgerShowcaseKey2;

  ///Setters
  ///

  // ignore: unnecessary_getters_setters
  set orderShowcaseKey(GlobalKey value) {
    _orderShowcaseKey = value;
  }

  // ignore: unnecessary_getters_setters
  set colShowcaseKey(GlobalKey value) {
    _colShowcaseKey = value;
  }

  // ignore: unnecessary_getters_setters
  set notShowcaseKey(GlobalKey value) {
    _notShowcaseKey = value;
  }



  // ignore: unnecessary_getters_setters
  set hamburgerShowcaseKey(GlobalKey value) {
    _hamburgerShowcaseKey = value;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set jewelerytpess(List<Jewelrytypes> value) {
    _jewelerytpess = value;
    notifyListeners();
  }

  set categorylist(List<CategoryList> value) {
    _categorylist = value;
    notifyListeners();
  }

  set ordercount(int value) {
    _ordercount = value;
    notifyListeners();
  }

  
  set notificationcount(int value) {
    _notificationcount = value;
    notifyListeners();
  }

  set productUpdateDate(String value) {
    _productUpdateDate = value;
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


  HomePageProvider() {
    categorylist = List<CategoryList>();
    expansionTileList = new List<GlobalKey<AppExpansionTileState>>();
    addExpansionTileGlobalKey();
    isLoading = true;
    productUpdateDate = "null";
  }

  GlobalKey<AppExpansionTileState> getExpansionTileKey(position) {
    return expansionTileList[position];
  }

  addExpansionTileGlobalKey() {
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());
    expansionTileList.add(new GlobalKey<AppExpansionTileState>());

  }

  reLoad() {}

  Future getHomeInfo() async {
    var homeInfoResponse = await useCases.getHomeInfo(
        AppApi.getRequestUrl(AppApi.HOME_API));

    homeInfoResponse.fold((exception) {
      isLoading = false;

      print(exception.toString() + " home info");

      SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      var saveLocalPriceType = await useCases.savePriceType(model.pricetype);

      saveLocalPriceType.fold((exception) {
        isLoading = false;

        SnackbarErrors(context: context, exp: exception);
      }, (bool) async {
        List<CategoryList> temp = List<CategoryList>();
        List<SubCategoryList> stemp = List<SubCategoryList>();


        for (CategoryList i in model.categorylist)
          temp.add(i);

        for (var i in temp) {
          for (var s in i.subcategorylist) {
            stemp.add(s);
          }
        }
        temp[0].subcategorylist = stemp;
        temp[1].subcategorylist = stemp;

        categorylist = temp;

        isLoading = false;
      });
    });
  }

  Future getHome() async {
    var homeresponse = await useCases.getHome(
        AppApi.getRequestUrl(AppApi.HOMEPAGE_API));
    homeresponse.fold((exception) {
      isLoading = false;
      SnackbarErrors(context: context, exp: exception);
    }, (model) async{
      print(model.model.currency);
      var saveLocalPriceType = await useCases.savePriceType(model.model.currency);

      supplierId = model.model.supplierId;
      print(supplierId);
      notifyListeners();
    });
  }

  Future getNotificationPermision()async{
    var result = await useCases.getAllNotificationStatus();
    result.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (status) async {
      print("geldi:  "+status.toString());
      notificationStatus = status;
    });
  }



  Future getCollectionList() async {
    var collectionResponse = await useCases.getCollectionList(
        AppApi.getRequestUrl(AppApi.COLLECTIONLIST_API));
    collectionResponse.fold((exception) {
      isLoading = false;


      SnackbarErrors(context: context, exp: exception);
    }, (model) {
      List<CollectionGroups> temp = List<CollectionGroups>();
      for (var i in model.collectionGroups) {
        temp.add(i);
      }
      collectionGruop = temp;
      print(collectionGruop[2].collectionGroupName);
      isLoading = false;
      notifyListeners();
    });
  }

  Future<List<Jewelrytypes>>getJeweleryTypes(int collectionGroupId) async {
    var jeweleryResponse = await _useCases.getJeweleryTypes(
        AppApi.getRequestUrl(AppApi.JEWELERYTYPES_API),collectionGroupId);

    jeweleryResponse.fold((exception) {
      isLoading = false;
      SnackbarErrors(context: context, exp: exception);
    }, (model) {
      List<Jewelrytypes> temp = List<Jewelrytypes>();
      List<Subjewelrytypes> stemp = List<Subjewelrytypes>();
      for (Jewelrytypes i in model.jewelrytypes) {
        temp.add(i);
      }
      for (var i in temp) {
        for (Subjewelrytypes s in i.subjewelrytypes) {
          stemp.add(s);
        }
        jewelerytpess = temp;
        isLoading = false;
        notifyListeners();
      }
    });
    return jewelerytpess;
  }
  Future getSubJeweleryTypes({int subJeweleryId,int collectionGroupId,int index}) async {
    var jeweleryResponse = await _useCases.getSubJeweleryTypes(
        AppApi.getRequestUrl(AppApi.SUBJEWELERYTYPES_API),subJeweleryId,collectionGroupId);

    jeweleryResponse.fold((exception) {
      isLoading = false;
      SnackbarErrors(context: context, exp: exception);
      print("sub jewelery hata");
    }, (model) {
      jewelerytpess[index].subjewelrytypes=model.jewelrytypes;
          print("subdöndü");
    });
  }

  void getCurrencyList() async {
    var result = await useCases.getCurrencyList(
        AppApi.getRequestUrl(AppApi.CURRENCYLIST_API));

    result.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (success) async {
      List<Currencies> temp = List<Currencies>();

      for (var i in success.currencies) {
        temp.add(i);
      }
      currencies = temp;
      print(currencies[2].name);
    });
    notifyListeners();
  }


  changedElementItem(int position,bool expvalue) {
    _categorylist[position].exp = expvalue;
    notifyListeners();
  }

  ///ForceUpdate methodları
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showVersionDialogForce(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Yeni güncelleme ";
        String message =
            "Uygulamanın  yeni bir sürümü var, lütfen  güncelleyin.";
        String btnLabel = "Güncelle";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel),
              onPressed: () => launchURL(APP_STORE_URL),
            ),

          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel,style: TextStyle(color: AppTheme.bigStone[50]),),
              onPressed: () => launchURL(PLAY_STORE_URL),
            ),

          ],
        );
      },
    );
  }

  showVersionDialogSoft(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Yeni güncelleme ";
        String message =
            "Uygulamanın  yeni bir sürümü var, lütfen  güncelleyin.";
        String btnLabel = "Güncelle";
        String btnLabel2 = "İptal";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel),
              onPressed: () => launchURL(APP_STORE_URL),
            ),

          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel,style: TextStyle(color: AppTheme.bigStone[50]),),
              onPressed: () => launchURL(PLAY_STORE_URL),
            ),
            FlatButton(
              child: Text(btnLabel2,style: TextStyle(color: Colors.grey),),
              onPressed: () => Navigator.pop(context),
            ),

          ],
        );
      },
    );
  }


  void deepRoutingAndroid(Map<String, dynamic> message) {

       if(message["data"]["route"]=="/productdetail"){
        Navigator.of(context).pushNamed(AppRoutes.productdetail,arguments: Arguments(productId:int.parse(message["data"]["product_id"] )  ));
      }if(message["data"]["route"]=="/productlist"){

      }if(message["data"]["route"]=="/orders"){
        Navigator.of(context).pushNamed(AppRoutes.orders);



  }}

  void deepRoutingIos(Map<String, dynamic> message) {
    print("gelen Ios : "+message["route"]);

    String route=message["route"];


         if(route=="/productdetail"){
           print("gelen detail : "+message["route"]);

           Navigator.of(context).pushNamed(AppRoutes.productdetail,arguments: Arguments(productId:int.parse(message["product_id"] )  ));

        }if(route=="/productlist"){

        }if(route=="/orders"){
          Navigator.of(context).pushNamed(AppRoutes.orders);


      }
    }


  @override
  Future<void> changeLocalAllNotificationStatus(bool status) async {
    await useCases.changeAllNotificationStatus(status);
  }


}















