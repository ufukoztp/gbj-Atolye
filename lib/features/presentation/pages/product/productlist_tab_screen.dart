import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbjatolye/features/domain/entities/homecategory.dart';
import 'package:gbjatolye/features/presentation/provider/productlist_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/product/disableforsaleproductlist_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/product/enableforsaleproductlist_widget.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:provider/provider.dart';

class ProductListTabsScreen extends StatefulWidget {
  final _useCases;
  final int jeweleryTpesId;

  ProductListTabsScreen(this._useCases, this.jeweleryTpesId);

  @override
  State<StatefulWidget> createState() {
    return ProductListTabsScreenState();
  }
}

class ProductListTabsScreenState extends State<ProductListTabsScreen>
    with
        AfterLayoutMixin<ProductListTabsScreen>,
        SingleTickerProviderStateMixin {

  ProductListProvider _productListProvider;
  TabController _tabController;

  @override
  void afterFirstLayout(BuildContext context) async {
    _productListProvider.reProductListProvider();

    if (appIntent.intent == PageIntents.ToProductListCodeFromHome ||
        appIntent.intent == PageIntents.ToProductListCodeFromNotification) {
      HomeCategory category = HomeCategory.fromJson(appIntent.data);
      _productListProvider.homeCategory = category;
    }

    await _productListProvider
        .getActiveProductList(_productListProvider.activeCurrentPage);
    await _productListProvider
        .getDeactiveProductList(_productListProvider.deactiveCurrentPage);

    _productListProvider.tabbarController = _tabController;
    _productListProvider.tabbarController
        .addListener(_productListProvider.handleTabSelection);
    _productListProvider.firstTime = false;

    _productListProvider.enableProductListScrollController
        .addListener(() async {
      if (_productListProvider
          .enableProductListScrollController.position.pixels ==
          _productListProvider
              .enableProductListScrollController.position.maxScrollExtent &&
          _productListProvider.activeCurrentPage <=
              _productListProvider.activepagecount) {
        await _productListProvider
            .getActiveProductList(_productListProvider.activeCurrentPage);
      }
    });

    _productListProvider.disableProductListScrollController
        .addListener(() async {
      if (_productListProvider
          .disableProductListScrollController.position.pixels ==
          _productListProvider.disableProductListScrollController.position
              .maxScrollExtent &&
          _productListProvider.deactiveCurrentPage <=
              _productListProvider.deactivepagecount) {
        await _productListProvider
            .getDeactiveProductList(_productListProvider.deactiveCurrentPage);
      }
    });
    /*
        var productListShowcase = await widget._useCases.getProductListShowcaseView();
    productListShowcase.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (val) async {
      if (val)
        WidgetsBinding.instance
            .addPostFrameCallback((_) => ShowCaseWidget.of(context).startShowCase([
          _productListProvider.addProductShowcaseKey,
          _productListProvider.productEditShowcaseKey,
          _productListProvider.productOrderByShowcaseKey
        ]));
    });
    */

  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _productListProvider = Provider.of<ProductListProvider>(context);
    _productListProvider.context = context;
    _productListProvider.useCases = widget._useCases;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.white[50],
        bottom: TabBar(
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 13.0, fontFamily: 'MontserratBold'),
          labelColor: AppTheme.bigStone[50],
          indicatorPadding: EdgeInsets.all(0.0),
          indicatorWeight: 3.0,
          labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
          indicator: ShapeDecoration(
              shape: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                      style: BorderStyle.solid)),
              gradient: LinearGradient(
                colors: <Color>[
                  AppTheme.aqua[50],
                  AppTheme.azureRadiance[50],
                ],
              )),
          unselectedLabelColor: AppTheme.eclipse[50],
          unselectedLabelStyle: TextStyle(
            fontSize: 13.0,
            fontFamily: 'MontserratSemiBold',
          ),
          tabs: [
            Container(
                height: 40,
                alignment: Alignment.center,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).txtTabsEnableSale,
                      style: TextStyle(color: AppTheme.bigStone[50]),
                    ),
                    _productListProvider.loadActive==false?
                    Visibility(
                      visible: _productListProvider.activeProducts.length > 0,
                      child: Text(
                        _productListProvider.activeProducts.length.toString() +
                            " " +
                            AppLocalizations.of(context).txtLblPackagePiece,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: AppTheme.riverBed[50],
                          fontFamily: 'MontserratSemiBold',
                        ),
                      ),
                    ):Container()
                  ],
                )),
            Container(
              height: 40,
              alignment: Alignment.center,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).txtTabsDisableSale,
                    style: TextStyle(color: AppTheme.bigStone[50]),
                  ),
                  _productListProvider.loadDeactive==false?
                  Visibility(
                    visible: _productListProvider.deactiveProducts.length > 0,
                    child: Text(
                      _productListProvider.deactiveProducts.length.toString() +
                          " " +
                          AppLocalizations.of(context).txtLblPackagePiece,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: AppTheme.riverBed[50],
                        fontFamily: 'MontserratSemiBold',
                      ),
                    ),
                  ):Container()
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                children: <Widget>[

                  ///Back Button
                  InkWell(
                    onTap: () {
                      _productListProvider.loadActive=true;
                      _productListProvider.loadDeactive=true;
                      _productListProvider.notProduct=true;
                      Navigator.of(context).canPop()==true?Navigator.of(context).pop(_productListProvider.activeProducts.length):Navigator.pushNamedAndRemoveUntil(context, AppRoutes.drawermain, (route) => false);

                    },
                    child: Padding(
                      child: Image.asset(
                        'images/ic_back.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                      padding: EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 15.0, bottom: 15.0),
                    ),
                  ),

                  ///Title Text
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Text(
                          _productListProvider.homeCategory == null
                              ? ""
                              : _productListProvider.homeCategory.titleName
                              .toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                            color: AppTheme.collectionPageColor[50]
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ),

                  SizedBox(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[

            /*            ///Filter Sort Button

                        InkWell(
                          child: Visibility(
                              visible: !_productListProvider
                                  .productStatusChangeActive
                              ,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      right: 15.0,
                                      left: 15.0,
                                      top: 15.0,
                                      bottom: 15.0),
                                  child: Image.asset(
                                    'images/ic_filter_sort.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ))),
                          onTap: () {
                            if(_productListProvider.visibilityTabIcons()) _productListProvider.showProductOrderByPopupButton();
                          },
                        ),

*/
                        ///Edit Status Icon

                        InkWell(
                          child: Visibility(
                              visible: !_productListProvider
                                  .productStatusChangeActive ,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      right: 15.0,
                                      left: 15.0,
                                      top: 15.0,
                                      bottom: 15.0),
                                  child: Image.asset(
                                    'images/ic_edit.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ))),
                          onTap: () {
                            if(_productListProvider.visibilityTabIcons())   _productListProvider
                                .showProductStatusChangeButton();
                          },
                        ),

                        /*
                        ///Filter Sort Button
                        Showcase(
                            key: _productListProvider.productOrderByShowcaseKey,
                            description: AppLocalizations.of(context)
                                .txtShowcaseOrderBy,
                            descTextStyle: Theme.of(context).textTheme.display1,
                            animationDuration: Duration(milliseconds: 500),
                            child: InkWell(
                              child: Visibility(
                                  visible: !_productListProvider
                                          .productStatusChangeActive
                                      ,
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          right: 15.0,
                                          left: 15.0,
                                          top: 15.0,
                                          bottom: 15.0),
                                      child: Image.asset(
                                        'images/ic_filter_sort.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ))),
                              onTap: () {
                               if(_productListProvider.visibilityTabIcons()) _productListProvider.showProductOrderByPopupButton();
                              },
                            )),

                        ///Edit Status Icon
                        Showcase(
                            key: _productListProvider.productEditShowcaseKey,
                            description: AppLocalizations.of(context)
                                .txtShowcaseProductEdit,
                            descTextStyle: Theme.of(context).textTheme.display1,
                            animationDuration: Duration(milliseconds: 500),
                            child: InkWell(
                              child: Visibility(
                                  visible: !_productListProvider
                                          .productStatusChangeActive ,
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          right: 15.0,
                                          left: 15.0,
                                          top: 15.0,
                                          bottom: 15.0),
                                      child: Image.asset(
                                        'images/ic_edit.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ))),
                              onTap: () {
                                if(_productListProvider.visibilityTabIcons())   _productListProvider
                                    .showProductStatusChangeButton();
                              },
                            )),
*/
                        ///Close Status Icon
                        InkWell(
                          child: Visibility(
                              visible: _productListProvider
                                  .productStatusChangeActive,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      right: 15.0,
                                      left: 15.0,
                                      top: 15.0,
                                      bottom: 15.0),
                                  child: Image.asset(
                                    'images/ic_close.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ))),
                          onTap: () {
                            _productListProvider
                                .hideProductStatusChangeButton();
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          Visibility(
            visible: _tabController.index==0?true:false,
            child: GestureDetector(
                child: BottomAppBar(
                  //color: AppTheme.darkTangerine[50],
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            AppTheme.aqua[50],
                            AppTheme.azureRadiance[50],
                          ]),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 20.0,
                                spreadRadius: 20.0,
                                offset: Offset(0.0, 20.0)),
                          ]),
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                height: 50,
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Image.asset(
                                            !_productListProvider
                                                .productStatusChangeActive
                                                ? 'images/ic_addproduct.png'
                                                : 'images/ic_changestatus.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                        ),
                                        Text(
                                            !_productListProvider
                                                .productStatusChangeActive
                                                ? AppLocalizations.of(context)
                                                .txtAddProduct
                                                : AppLocalizations.of(context)
                                                .txtChangeProductStatus,
                                            style: Theme.of(context).textTheme.button,
                                            textAlign: TextAlign.center)
                                      ],
                                    )),
                              ))
                        ],
                      )),
                ),
                onTap: () async {
                  !_productListProvider.productStatusChangeActive
                      ? _productListProvider.addPhotoButton(_productListProvider.homeCategory.collectionGroupId)
                      : _productListProvider.showChangeProductStatusPopupButton();
                }),
          ),
          Visibility(
            visible: _tabController.index==1&&  _productListProvider
                .productStatusChangeActive?true:false,
            child: GestureDetector(
                child: BottomAppBar(
                  //color: AppTheme.darkTangerine[50],
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            AppTheme.aqua[50],
                            AppTheme.azureRadiance[50],
                          ]),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 20.0,
                                spreadRadius: 20.0,
                                offset: Offset(0.0, 20.0)),
                          ]),
                      child: new Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                height: 50,
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Image.asset(
                                           'images/ic_changestatus.png',
                                            width: 15,
                                            height: 15,
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                                .txtChangeProductStatus,
                                            style: Theme.of(context).textTheme.button,
                                            textAlign: TextAlign.center)
                                      ],
                                    )),
                              ))
                        ],
                      )),
                ),
                onTap: () async {
            _productListProvider.showChangeProductStatusPopupButton();
                }),
          ),
        ],
      )
      /*
      Showcase(
          key: _productListProvider.addProductShowcaseKey,
          description: AppLocalizations.of(context).txtShowcaseHamburgerMenu,
          descTextStyle: Theme.of(context).textTheme.display1,
          animationDuration: Duration(milliseconds: 500),
          child: GestureDetector(
              child: BottomAppBar(
                //color: AppTheme.darkTangerine[50],
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: <Color>[
                          AppTheme.aqua[50],
                          AppTheme.azureRadiance[50],
                        ]),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 20.0,
                              spreadRadius: 20.0,
                              offset: Offset(0.0, 20.0)),
                        ]),
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          height: 50,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Image.asset(
                                  !_productListProvider
                                          .productStatusChangeActive
                                      ? 'images/ic_addproduct.png'
                                      : 'images/ic_changestatus.png',
                                  width: 15,
                                  height: 15,
                                ),
                              ),
                              Text(
                                  !_productListProvider
                                          .productStatusChangeActive
                                      ? AppLocalizations.of(context)
                                          .txtAddProduct
                                      : AppLocalizations.of(context)
                                          .txtChangeProductStatus,
                                  style: Theme.of(context).textTheme.button,
                                  textAlign: TextAlign.center)
                            ],
                          )),
                        ))
                      ],
                    )),
              ),
              onTap: () async {
                !_productListProvider.productStatusChangeActive
                    ? _productListProvider.addPhotoButton()
                    : _productListProvider.showChangeProductStatusPopupButton();
              }))*/,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: <Widget>[
          TabBarView(
            physics: ClampingScrollPhysics(),
            /*
            true   // _productListProvider.productStatusChangeActive
                ? ClampingScrollPhysics()
               : NeverScrollableScrollPhysics(),
                         */

            controller: _tabController,
            children: [
              EnableForSaleProductListWidgets(
                jeweleryTpesId: widget.jeweleryTpesId,
                pageKey: "tab0",
                useCase: widget._useCases,
                productListProvider: _productListProvider,
              ),
              DisableForSaleProductListWidgets(
                jeweleryTpesId:widget.jeweleryTpesId,
                pageKey: "tab1",
                useCase: widget._useCases,
                productListProvider: _productListProvider,
              ),
            ],
          )
        ],
      ),
     );
  }
}
