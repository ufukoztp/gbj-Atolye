import 'package:gbjatolye/features/domain/entities/homecategory.dart';
import 'package:gbjatolye/features/domain/entities/notification/setnotification.dart';
import 'package:gbjatolye/features/domain/entities/product/arguments.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';
import 'package:gbjatolye/features/domain/entities/notification/notification.dart';
import 'package:provider/provider.dart';

abstract class NotificationsProviderUseCases {

  bool getableNotification();

  Future getNotificationList(int page);
  
  Future setNotificationRead(SetNotification notfIdList);

  void route(String route,int position);

}

class NotificationsProvider
    with ChangeNotifier
    implements NotificationsProviderUseCases {

  BuildContext _context;
  UseCases _useCases;
  ScrollController _scrollController;
  int _currentPage = 1;
  List<NotificationItem> _notifications;
  SetNotification _notfIdList=SetNotification();


  static const int MAX_ITEM_COUNT = 40;

  ///Getter
  ///

  // ignore: unnecessary_getters_setters
  BuildContext get context => _context;

  UseCases get useCases => _useCases;

  ScrollController get scrollController => _scrollController;

  int get currentPage => _currentPage;

  SetNotification get notfIdList => _notfIdList;

  List<NotificationItem> get notifications => _notifications;

  ///Setters
  ///

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  set scrollController(ScrollController value) {
    _scrollController = value;
    notifyListeners();
  }

  set notifications(List<NotificationItem> value) {
    _notifications = value;
    notifyListeners();
  }

  // ignore: unnecessary_getters_setters
  set context(BuildContext value) {
    _context = value;
  }

  set useCases(UseCases value) {
    _useCases = value;
    notifyListeners();
  }


  set notfIdList(SetNotification value) {
    _notfIdList = value;
    notifyListeners();
  }


  NotificationsProvider() {
    scrollController = ScrollController();
    notifications = List<NotificationItem>();
    currentPage = 1;
    notifyListeners();
  }

  reNotificationsProvider() {
    scrollController = ScrollController();
    notifications = List<NotificationItem>();
    currentPage = 1;
    notifyListeners();
  }

  @override
  Future getNotificationList(int page) async {
    var result = await useCases.getNotificationList(
        AppApi.getRequestUrl(AppApi.GETNOTIFICATIONLIST_API),
        NotificationRequest(page: page.toString()));

    result.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      currentPage += 1;
      for (NotificationItem item in model.notificationlist) notifications.add(item);
      notifyListeners();
    });
  }

  @override
  bool getableNotification() {
    if(currentPage==1) return true;
    else if (currentPage>1 && notifications.length==0) return false;
    return notifications.length %
                (MAX_ITEM_COUNT * (currentPage - 1)) ==
            0
        ? true
        : false;
  }

  @override
  void route(String route,int position) {
    switch (route) {
      case '/orders':
       // NavigationService.navigateTo(AppRoutes.orders);
        break;
      case '/productdetail':
        Provider.of<ProductDetailProvider>(context, listen: false).reProductDetailProvider();
       Navigator.pushNamed(context, AppRoutes.productdetail,arguments:Arguments(productId:notifications[position].productid));
        break;

      case '/productlist':
        appIntent.intent = PageIntents.ToProductListCodeFromNotification;
        appIntent.data = HomeCategory(
            jewelrytypeid: notifications[position].jewelrytypeid,
            titleName: notifications[position].title.toString(),
            subtype: notifications[position].subtype.toString().toLowerCase() == 'true'
            )
            .toJson();
      //  NavigationService.navigateTo(AppRoutes.productlist);
        break;
    }
  }

  @override
  Future setNotificationRead(SetNotification notfIdList) async{
    // TODO: implement setNotificationRead

    var result = await useCases.setNotificationRead(notfIdList, AppApi.getRequestUrl(AppApi.SETNOTIFICATION_API));

     result.fold((exception) {

       print("notf set exception");
     }, (model) {
       print("notf set success");

       print(model.success);
     });

  }

}
