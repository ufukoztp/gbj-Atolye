import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/provider/homepage_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/homepage_widgets.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/globals.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../app.dart';

// ignore: must_be_immutable
class HomePageScreen extends KFDrawerContent {
  final _useCases;
  final arguments;

  HomePageScreen(this._useCases,this.arguments);

  @override
  State<StatefulWidget> createState() {
    return HomePageScreenState(_useCases);
  }
}

class HomePageScreenState extends State<HomePageScreen>
    with AfterLayoutMixin<HomePageScreen>, SingleTickerProviderStateMixin {


  UseCases _useCases;

  HomePageScreenState(this._useCases);

  HomePageProvider _homePageProvider;

  Animation<Color> animation;

  AnimationController controller;

  @override
  void afterFirstLayout(BuildContext context) async {

    _homePageProvider.context = context;
    _homePageProvider.useCases = _useCases;
   await _homePageProvider.getCollectionList();
     _homePageProvider.getCurrencyList();

    await _homePageProvider.getJeweleryTypes(_homePageProvider.collectionGroupId).then((value) {
      /*
      List.generate(_homePageProvider.jewelerytpess.length, (index) async{
        await _homePageProvider.getSubJeweleryTypes(subJeweleryId: _homePageProvider.jewelerytpess[index].id,collectionGroupId:_homePageProvider.collectionGroupId,index: index);

      });
             */
    });

    var homeShowcase = await _useCases.getHomeShowcaseView();

    homeShowcase.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (val) async {
      if (val)
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => ShowCaseWidget.of(context).startShowCase([
                  _homePageProvider.hamburgerShowcaseKey,
                  _homePageProvider.notShowcaseKey,
                  _homePageProvider.orderShowcaseKey,
                  _homePageProvider.colShowcaseKey
                ]));
    });

  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {


    super.initState();

    currentScaffoldState = GlobalKeys.scaffoldKeyHome;

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

    controller.forward();



  }

  @override
  Widget build(BuildContext context) {

    _homePageProvider = Provider.of<HomePageProvider>(context);
    return Scaffold(
        key: GlobalKeys.scaffoldKeyHome,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme.white[50],
          actions: <Widget>[
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        child: Image.asset(
                          'images/ic_back.png',
                          width: 10,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                        padding: EdgeInsets.only(
                            right: 15.0, left: 15.0, top: 15.0, bottom: 15.0),
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
                    Expanded(
                      child: Text(
                        widget.arguments,
                        style: TextStyle(
                            color: AppTheme.collectionPageColor[50],
                            fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(width: 20,)
                  ],
                ),
              ),
            )
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: <Widget>[
            Visibility(
              visible: _homePageProvider.jewelerytpess != null &&
                      !_homePageProvider.isLoading
                  ? true
                  : false,
              child: HomePageWidgets(
                  homePageProvider: _homePageProvider, useCase: _useCases,arguments: widget.arguments,),
            ),
            Visibility(
              visible: _homePageProvider.jewelerytpess != null &&
                  !_homePageProvider.isLoading
                  ? false
                  : true,
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
}
