import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbjatolye/features/domain/entities/NotificationItem.dart';
import 'package:gbjatolye/features/domain/entities/homecategory.dart';
import 'package:gbjatolye/features/presentation/pages/Test.dart';
import 'package:gbjatolye/features/presentation/pages/home/homepage_screen.dart';
import 'package:gbjatolye/features/presentation/pages/notification/notifications_screen.dart';
import 'package:gbjatolye/features/presentation/pages/order/orderlist_tab_screen.dart';
import 'package:gbjatolye/features/presentation/pages/others/drawer_main_screen.dart';
import 'package:gbjatolye/features/presentation/pages/photo/photopicker_screen.dart';
import 'package:gbjatolye/features/presentation/pages/product/detailpagedetail/availableoptionpage_screen.dart';
import 'package:gbjatolye/features/presentation/pages/product/detailpagedetail/designtypes_screen.dart';
import 'package:gbjatolye/features/presentation/pages/product/detailpagedetail/options_screen.dart';
import 'package:gbjatolye/features/presentation/pages/product/detailpagedetail/otheroption_screen.dart';
import 'package:gbjatolye/features/presentation/pages/product/detailpagedetail/preview_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:gbjatolye/features/presentation/pages/product/productdetail_screen.dart';
import 'package:gbjatolye/features/presentation/pages/product/productlist_tab_screen.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/navigationservice.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:gbjatolye/features/presentation/pages/account/forgotpassword1_screen.dart';
import 'package:gbjatolye/features/presentation/pages/account/forgotpassword2_screen.dart';
import 'package:gbjatolye/features/presentation/pages/account/forgotpassword3_screen.dart';
import 'package:gbjatolye/features/presentation/pages/account/login_screen.dart';
import 'package:gbjatolye/features/presentation/pages/account/register1_screen.dart';
import 'package:gbjatolye/features/presentation/pages/account/register2_screen.dart';
import 'package:gbjatolye/features/presentation/pages/account/register3_screen.dart';
import 'package:gbjatolye/features/presentation/pages/others/preloader_screen.dart';
import 'package:gbjatolye/utils/SlideRoute.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/localization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:inject/inject.dart';
import 'features/domain/usecases/usecases.dart';
import 'features/presentation/pages/onboarding/onboarding.dart';
import 'features/presentation/pages/splash/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


// ignore: must_be_immutable
class App extends StatefulWidget {

  UseCases _useCases;

  @provide
  App(this._useCases) : super();

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }

}

class AppState extends State<App> {

  var _useCases;

  @override
  void initState() {
    super.initState();
    _useCases = widget._useCases;
  }

  GlobalKey<ScaffoldState> currentScaffoldState;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context,constraints){
        return OrientationBuilder(
          builder: (context,orientetions){
            SizerUtil().init(constraints, orientetions);
            //initialize SizerUtil
            return   MaterialApp(
                title: BlocLocalizations().appTitle,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.theme,
                localizationsDelegates: [
                  AppLocalizationDelegate(),


                  //InheritedWidgetLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,





                ],
                supportedLocales: [
                //  const Locale('en'),

                  const Locale('tr'),
                ],
                routes: {
                  "/": (context) {
                    return SplashScreen(_useCases);
                  },

                },
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case "/otheroptions":
                      return SlideLeftRoute(
                        page: ShowCaseWidget(
                            onFinish: () async {
                              await _useCases.revealProductDetailShowcaseView(false);
                            },
                            builder: Builder(
                                builder: (context) => OtherOptionScreen(_useCases))),
                      );
                      break;


                    case "/productdetail":
                      return SlideLeftRoute(
                        page: ShowCaseWidget(
                            onFinish: () async {
                              await _useCases.revealProductDetailShowcaseView(false);
                            },
                            builder: Builder(
                                builder: (context) => ProductDetailScreen(
                                    _useCases,settings.arguments))),
                      );
                    case "/onboarding":
                      return SlideLeftRoute(page: OnboardingScreen(_useCases));
                      break;
                    case "/login":
                      return SlideLeftRoute(page: LoginScreen(_useCases));
                      break;
                    case "/productlist":
                      return SlideLeftRoute(
                        page: ShowCaseWidget(
                            onFinish: () async {
                              await _useCases.revealProductListShowcaseView(false);
                            },
                            builder: Builder(
                                builder: (context) =>
                                    ProductListTabsScreen(_useCases,settings.arguments)
                            )),
                      );
                      break;
                    case "/photopicker":
                      return SlideLeftRoute(page: PhotoPickerScreen(_useCases));
                      break;
                    case "/jewelerytypes":
                      return SlideLeftRoute(
                        page: ShowCaseWidget(
                            onFinish: () async {
                              await _useCases.revealProductListShowcaseView(false);
                            },
                            builder: Builder(
                                builder: (context) =>
                                    HomePageScreen(_useCases,settings.arguments)
                            )),
                      );
                      break;
                    case "/forgotpassword1":
                      return SlideLeftRoute(page: ForgotPassword1Screen(_useCases));
                      break;
                    case "/forgotpassword2":
                      return SlideLeftRoute(page: ForgotPassword2Screen(_useCases));
                      break;
                    case "/forgotpassword3":
                      return SlideLeftRoute(page: ForgotPassword3Screen(_useCases));
                      break;
                    case "/register1":
                      return SlideLeftRoute(page: Register1Screen(_useCases));
                      break;
                    case "/register2":
                      return SlideLeftRoute(page: Register2Screen(_useCases));
                      break;
                    case "/register3":
                      return SlideLeftRoute(page: Register3Screen(_useCases));
                      break;
                    case "/drawermain":
                      return SlideLeftRoute(page: ShowCaseWidget(
                          onFinish: () async {
                            await _useCases.revealHomeShowcaseView(false);
                          },
                          builder:
                          Builder(builder: (context) => DrawerMainScreen(_useCases))));
                      break;
                    case "/notifications":
                      return SlideLeftRoute(page: NotificationsScreen(_useCases));
                      break;
                    case "/orders":
                      return SlideLeftRoute(page: OrderListTabsScreen(_useCases));
                      break;
                    case "/designtypes":
                      return SlideLeftRoute(page: DesignTypesScreen(_useCases,settings.arguments));
                      break;
                    case "/preview":
                      return SlideLeftRoute(
                        page: ShowCaseWidget(
                            onFinish: () async {
                              await _useCases.revealProductDetailShowcaseView(false);
                            },
                            builder: Builder(
                                builder: (context) => ProductPreviewScreen(_useCases,settings.arguments))),
                      );
                      break;
                    case "/options":
                      return SlideLeftRoute(page:OptionsScreen(_useCases,settings.arguments));
                      break;
                    case "/availableoptions":
                      return SlideLeftRoute(page: AvailableOptionsScreen());
                      break;

                    default:
                      return SlideLeftRoute(page:SplashScreen(_useCases) );
                      break;
                  }
                }
            );

          },
        );

      }


    );
  }
}

GlobalKey<ScaffoldState> currentScaffoldState;
void notificationSnack(NotificationItem item) {
  if (currentScaffoldState == null) return;

  Flushbar(
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    messageText: Container(
      child: Row(
        children: <Widget>[
          Visibility(
            visible: item.image == null ? false : true,
            child: Container(
              width: 50.0,
              height: 50.0,
              child:
              CachedNetworkImage(imageUrl: item.image, fit: BoxFit.contain),
            ),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.title,
                        textAlign: TextAlign.left,
                        style: Theme.of(currentScaffoldState.currentContext)
                            .textTheme
                            .headline6),
                    Text(item.body,
                        textAlign: TextAlign.left,
                        style: Theme.of(currentScaffoldState.currentContext)
                            .textTheme
                            .headline4)
                  ],
                )),
          )
        ],
      ),
    ),
    isDismissible: true,
    duration: Duration(seconds: 5),
    backgroundColor: AppTheme.azureRadiance[50],
    onTap: (globalKey) {
      switch (item.route) {
        case '/notifications':
          NavigationService.navigateTo(AppRoutes.notifications);
          break;
        case '/orders':
          NavigationService.navigateTo(AppRoutes.orders);
          break;
        case '/productlist':
          appIntent.intent = PageIntents.ToProductListCodeFromHome;
          appIntent.data = HomeCategory(
              jewelrytypeid: int.parse(item.jewelryTypeId),
              titleName: item.productListTitle.toString(),
              subtype: item.subtype.toLowerCase() == 'true')
              .toJson();
          /*   NavigationService.navigateTo(AppRoutes.productlist)*/
          break;
        case '/productdetail':
          Provider.of<ProductDetailProvider>(
              currentScaffoldState.currentContext,
              listen: false)
              .reProductDetailProvider();
          /*  Navigator.pushNamed(
              currentScaffoldState.currentContext, AppRoutes.productdetail,
              arguments: item.product_id.toString());*/
          break;
      }
      flush.dismiss(true);
    },
  )..show(currentScaffoldState.currentContext);

}

///Snackbar Section
Flushbar flush;

void appSnackbar(cxt, text) {
  if (flush != null) {
    flush.dismiss();
  }
  flush = Flushbar(
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    messageText: Center(
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'MontserratSemiBold',
              color: AppTheme.white[50])),
    ),
    isDismissible: true,
    duration: Duration(seconds: 3),
    backgroundColor: AppTheme.azureRadiance[50],
    onTap: (globalKey) {
      flush.dismiss(true);
    },
  )..show(cxt);
}
Preloader preloader ;

//Preloader preloader =null;

void showPreloader(cxt, message) {
  if (preloader == null) {
    preloader = Preloader(message);
    Navigator.of(cxt).push(preloader);
  } else
    preloader.updateText(message);
}


void hidePreloader(context) {
  preloader = null;
  Navigator.of(context).pop();
}


String getMonth(cxt, int month) {
  var mnth = "";
  switch (month) {
    case 1:
      mnth = AppLocalizations.of(cxt).txtLblMonthJan;
      break;
    case 2:
      mnth = AppLocalizations.of(cxt).txtLblMonthFab;
      break;
    case 3:
      mnth = AppLocalizations.of(cxt).txtLblMonthMarch;
      break;
    case 4:
      mnth = AppLocalizations.of(cxt).txtLblMonthApr;
      break;
    case 5:
      mnth = AppLocalizations.of(cxt).txtLblMonthMay;
      break;
    case 6:
      mnth = AppLocalizations.of(cxt).txtLblMonthJune;
      break;
    case 7:
      mnth = AppLocalizations.of(cxt).txtLblMonthJuly;
      break;
    case 8:
      mnth = AppLocalizations.of(cxt).txtLblMonthAugust;
      break;
    case 9:
      mnth = AppLocalizations.of(cxt).txtLblMonthSept;
      break;
    case 10:
      mnth = AppLocalizations.of(cxt).txtLblMonthOct;
      break;
    case 11:
      mnth = AppLocalizations.of(cxt).txtLblMonthNov;
      break;
    case 12:
      mnth = AppLocalizations.of(cxt).txtLblMonthDecember;
      break;
  }
  return mnth;
}


///ScrollBar
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

