import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/core/error/failures.dart';
import 'package:gbjatolye/features/domain/entities/notification/registerdevicee.dart';
import 'package:gbjatolye/features/domain/entities/notification/settingstags.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/messagedialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';


class SettingsProvider with ChangeNotifier  {

  String off="Kapatılıyor...";
  String on="Açılıyor...";
  String changeNotfStatus="Bildirim durumu değiştirildi";

  BuildContext _context;
  UseCases _useCases;
  String _token;

  String get token => _token;

  set token(String value) {
    _token = value;
    notifyListeners();
  }
  bool _allNotificationsStatus;
  bool _expansionState=false;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  




  ///Getter
  ///

  BuildContext get context => _context;

  UseCases get useCases => _useCases;

  bool get expansionState => _expansionState;


  bool get allNotificationsStatus => _allNotificationsStatus;

  ///Setters
  ///


  set allNotificationsStatus(bool value) {
    _allNotificationsStatus = value;
    notifyListeners();
  }

  set expansionState(bool value) {
    _expansionState = value;
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

  SettingsProvider() {

    allNotificationsStatus = false;
  }

  @override
  Future<void> getAllNotificationStatus() async {
    var result = await useCases.getAllNotificationStatus();
    result.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (status) async {
      allNotificationsStatus = status;
      print(status);
    });
  }

  @override
  Future<void> unRegisterDevice(deviceid) async {
    showPreloader(context, off);
    ///unregister
    var result = await useCases.changeRegisterDevice(AppApi.getRequestUrl(AppApi.UNREGISTER_API),deviceid);
    result.fold((exception) {
      hidePreloader(context);
    }, (status) async {

      await useCases.changeAllNotificationStatus(false);
      hidePreloader(context);
      appSnackbar(context, changeNotfStatus);
      print(status.success);


    });
  }

  registerDevice(devicetoken) async {
    showPreloader(context, on);

    var responseUserToken = await _useCases.getLocalUserToken();
    responseUserToken.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (userToken) async {

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
      }, (success) async{

        await useCases.changeAllNotificationStatus(true);
        hidePreloader(context);
        appSnackbar(context, changeNotfStatus);
        print("Success register device2: "+ success.success.toString());
      });
    });
  }

  Future reSettingsProvider() async {
    /*
    await getProductLikeNotificationStatus();
    await getProductAddedNotificationStatus();
    await getOrderNotificationStatus();
    await getCustomNotificationStatus();

     */

  }


}
