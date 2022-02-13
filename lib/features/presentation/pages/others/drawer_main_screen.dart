import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/pages/Others/support_screen.dart';
import 'package:gbjatolye/features/presentation/pages/home/collectionspage_screen.dart';
import 'package:gbjatolye/features/presentation/pages/order/orderlist_tab_screen.dart';
import 'package:gbjatolye/features/presentation/pages/others/supportPhoto_screen.dart';
import 'package:gbjatolye/features/presentation/pages/settings/settings_screen.dart';
import 'package:gbjatolye/features/presentation/widgets/messagedialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

class DrawerMainScreen extends StatefulWidget implements KFDrawerContent{

  final UseCases _useCases;

  DrawerMainScreen(this._useCases);

  @override
  _MainWidgetState createState() => _MainWidgetState(_useCases);

  @override
  VoidCallback onMenuPressed;


}

class _MainWidgetState extends State<DrawerMainScreen>
    with TickerProviderStateMixin, AfterLayoutMixin<DrawerMainScreen> {
  KFDrawerController _drawerController;

  final UseCases _useCases;

  _MainWidgetState(this._useCases);

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      _drawerController = KFDrawerController(
        initialPage: CollectionPageScreen(_useCases),
        items: [
          /*
          KFDrawerItem.initWithPage(
            text: Text(
                AppLocalizations.of(context).txtLblProfile,
                style: TextStyle(
                    color: AppTheme.eclipse[50],
                    fontFamily: 'GothamBold',
                    fontSize: 14.0)),
            icon: Container(
              width: 22.0,
              height: 22.0,
              child: Image.asset(
                "images/ic_profile.png",
                fit: BoxFit.contain,
              ),
            ),
            page: SupportScreen(_useCases),
          ),
           */

          KFDrawerItem.initWithPage(
            text: Text("",
              style: TextStyle(
                  color: AppTheme.bigStone[50],
                  fontFamily: 'MontserratBold',
                  fontSize: 14.0),
            ),
            icon: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 90.0,
              child: Image.asset(
                "images/ic_atolye.png",
                fit: BoxFit.contain,
              ),
            ),
            //Icon(Icons.home, color: AppTheme.eclipse[50]),
            page: CollectionPageScreen(_useCases),
          ),
          ///hizalama için koyulan boş container
          KFDrawerItem.initWithPage(
            text: Text("",
              style: TextStyle(
                  color: AppTheme.collectionPageColor[50],
                  fontFamily: 'MontserratBold',
                  fontSize: 14.0),
            ),
            icon: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 70.0,
            ), //Icon(Icons.home, color: AppTheme.eclipse[50]),
          ),
          KFDrawerItem.initWithPage(
            text: Text(AppLocalizations.of(context).txtLblHome,
              style: TextStyle(
                  color: AppTheme.collectionPageColor[50],
                  fontFamily: 'MontserratBold',
                  fontSize: 14.0),
            ),
            icon: InkWell(
              onTap: (){
              },
              child: Container(
                width: 20.0,
                height: 20.0,
                child: Image.asset(
                  "images/ic_home.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            //Icon(Icons.home, color: AppTheme.eclipse[50]),
            page: CollectionPageScreen(_useCases),
          ),
          KFDrawerItem.initWithPage(
            text: Text("Sipariş",
              style: TextStyle(
                  color: AppTheme.collectionPageColor[50],
                  fontFamily: 'MontserratBold',
                  fontSize: 14.0),
            ),
            icon: Container(
              width: 20.0,
              height: 20.0,
              child: Image.asset(
                "images/ic_orderbag.png",
                fit: BoxFit.contain,
              ),
            ),
            //Icon(Icons.home, color: AppTheme.eclipse[50]),
            page: OrderListTabsScreenWithDrawer(_useCases),
          ),
          KFDrawerItem.initWithPage(
            text: Text("Fotoğraflama hizmeti",
              style: TextStyle(
                  color: AppTheme.collectionPageColor[50],
                  fontFamily: 'MontserratBold',
                  fontSize: 14.0),
            ),
            icon: InkWell(
              onTap: (){
              },
              child: Container(
                width: 20.0,
                height: 20.0,
                child: Icon(Icons.camera_alt_outlined,color: AppTheme.collectionPageColor[70],),
              ),
            ),
            //Icon(Icons.home, color: AppTheme.eclipse[50]),
            page: SupportScreenPhoto(supportTipe: SupportTipe.PhotoSupport,),
          ),

          KFDrawerItem.initWithPage(
            text: Text(AppLocalizations.of(context).txtLblSupport,
              style: TextStyle(
                  color: AppTheme.collectionPageColor[50],
                  fontFamily: 'MontserratBold',
                  fontSize: 14.0),),
            icon: Container(
              width: 22.0,
              height: 22.0,
              child: Image.asset(
                "images/ic_support.png",
                fit: BoxFit.contain,
              ),
            ),
            page: SupportScreen(supportTipe: SupportTipe.Support,),
          ),
          /*
          KFDrawerItem.initWithPage(
            text: Text(AppLocalizations.of(context).txtLblRequestAndRepair,
              style: TextStyle(
                  color: AppTheme.collectionPageColor[50],
                  fontFamily: 'MontserratBold',
                  fontSize: 14.0),),
            icon: Container(
              width: 22.0,
              height: 22.0,
              child: Image.asset(
                "images/ic_repair_or_request.png",
                fit: BoxFit.contain,
              ),
            ),
            page: TicketScreen(_useCases),
          ),


           */
          KFDrawerItem.initWithPage(
            text: Text(
              AppLocalizations.of(context).txtLblSettings,
              style: TextStyle(
                  color: AppTheme.collectionPageColor[50],
                  fontFamily: 'MontserratBold',
                  fontSize: 14.0),),
            icon: Container(
              width: 22.0,
              height: 22.0,
              child: Image.asset(
                "images/ic_settings.png",
                fit: BoxFit.contain,
              ),
            ),
            page: SettingsScreen(_useCases),
          ),
          ///hizalama için koyulan boş container

        ],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _drawerController =
        KFDrawerController(initialPage: CollectionPageScreen(_useCases), items: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        shadowOffset: 0,
//         borderRadius: 0.0,
//        shadowBorderRadius: 0.0,
//        menuPadding: EdgeInsets.all(0.0),
//        scrollable: true,
        controller: _drawerController,

        footer: KFDrawerItem(
          text: Text(
            AppLocalizations.of(context).txtLblLogOut,
            style: TextStyle(
                color: AppTheme.collectionPageColor[50],
                fontFamily: 'MontserratBold',
                fontSize: 14.0),
          ),
          icon: Container(
            width: 22.0,
            height: 22.0,
            child: Image.asset(
              "images/ic_exit.png",
              fit: BoxFit.contain,
            ),
          ),
          onPressed: () async {

            MessageDialogTypes dialogOption = await asyncFilterMessageDialog(
                context,
                DialogType.ExitAccount,
                AppLocalizations.of(context).txtPopupExitApp);

            if (dialogOption != null && dialogOption == MessageDialogTypes.OK) {
              var resultRememberMeData = await _useCases.saveRememberMe(false);

              resultRememberMeData.fold((exception) {
                SnackbarErrors(context: context, exp: exception);
              }, (success) async {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.login, (Route<dynamic> route) => false);
              });
            }
          },
        ),
        decoration: BoxDecoration(color: const Color(0xffE2E2E2)
//          gradient: LinearGradient(
//            begin: Alignment.topLeft,
//            end: Alignment.bottomRight,
//            colors: [
//              Color.fromRGBO(215,221,232, 0.7),
//              Color.fromRGBO(179,152,97, 1)
//
//            ],
//            tileMode: TileMode.repeated,
//          ),
        ),
      ),
    );
  }
}
