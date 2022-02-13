import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/provider/orderlist_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Order/productionorderlist_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/Order/readyorderlist_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/Order/waitingorderlist_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/order/refresh_widget.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/globals.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';
import '../../../../app.dart';

class OrderListTabsScreen extends StatefulWidget {
  final _useCases;

  OrderListTabsScreen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return OrderListTabsScreenState();
  }
}

class OrderListTabsScreenState extends State<OrderListTabsScreen>
    with AfterLayoutMixin<OrderListTabsScreen>, SingleTickerProviderStateMixin {
  OrderListProvider _orderListProvider;

  TabController _tabController;

  @override
  void afterFirstLayout(BuildContext context) async {

    _orderListProvider.reOrderListProvider();
    _orderListProvider.useCases = widget._useCases;
    await _orderListProvider.getOrderList();
    await _orderListProvider.setPriceType();
    _orderListProvider.updateProductOrderCounts();
    _orderListProvider.tabbarController = _tabController;
    _orderListProvider.tabbarController
        .addListener((){
      // ignore: unnecessary_statements
      _orderListProvider.handleTabSelection;

      switch (_orderListProvider.tabbarController.index) {
        case 0:
          _orderListProvider.getWaitingOrderList();
          break;
        case 1:
          _orderListProvider.getProductionOrderList();
          break;
        case 2:
          _orderListProvider.getReadyOrderList();
          break;
      }

    }

    );



  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    currentScaffoldState = GlobalKeys.scaffoldKeyNotifications;
  }

  @override
  void dispose() {
    _orderListProvider.tabbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _orderListProvider = Provider.of<OrderListProvider>(context);
    _orderListProvider.context = context;

    return Scaffold(
      key: GlobalKeys.scaffoldKeyOrders,
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
                    Text(AppLocalizations.of(context).txtTabsWaitingOrders,
                        style: TextStyle(
                          fontSize: 10.0,
                        )),
                    Visibility(
                      visible: _orderListProvider.waitingCount > 0,
                      child: Text(
                        _orderListProvider.waitingCount.toString() +
                            " " +
                            AppLocalizations.of(context).txtLblPackagePiece,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: AppTheme.riverBed[50],
                          fontFamily: 'MontserratSemiBold',
                        ),
                      ),
                    )
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
                  Text(AppLocalizations.of(context).txtTabsManufacturingOrders,
                      style: TextStyle(
                        fontSize: 10.0,
                      )),
                  Visibility(
                    visible: _orderListProvider.productionCount > 0,
                    child: Text(
                      _orderListProvider.productionCount.toString() +
                          " " +
                          AppLocalizations.of(context).txtLblPackagePiece,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: AppTheme.riverBed[50],
                        fontFamily: 'MontserratSemiBold',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(AppLocalizations.of(context).txtTabsReadyOrders,
                      style: TextStyle(
                        fontSize: 10.0,
                      )),
                  Visibility(
                    visible: _orderListProvider.readyCount > 0,
                    child: Text(
                      _orderListProvider.readyCount.toString() +
                          " " +
                          AppLocalizations.of(context).txtLblPackagePiece,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: AppTheme.riverBed[50],
                        fontFamily: 'MontserratSemiBold',
                      ),
                    ),
                  )
                ],
              ),
            )
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
                      Navigator.of(context).pop();
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
                      child: Text(AppLocalizations.of(context).txtTitleOrders,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center),
                    ),
                  ),

                  SizedBox(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        /*
                          ///Repair Order Product Button
                          InkWell(
                            child: Visibility(
                                visible: !_orderListProvider
                                    .orderProductStatusChangeActive,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        right: 15.0,
                                        left: 15.0,
                                        top: 15.0,
                                        bottom: 15.0),
                                    child: Image.asset(
                                      'images/ic_repair_order.png',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.contain,
                                    ))),
                            onTap: () {},
                          ),
                           */

                        InkWell(
                          onTap: ()async{
                           await _orderListProvider.getImage().then((value) async{

                         //     await _orderListProvider.allOrderCreatePdf();

                           });
                          },

                            child: Icon(Icons.ios_share,color: AppTheme.collectionPageColor[50],)),

                        SizedBox(
                          width: 15.0,

                        ),

                        ///Edit Status Icon
                        InkWell(
                          child: Visibility(
                              visible: !_orderListProvider
                                  .orderProductStatusChangeActive,
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
                            print(_orderListProvider.tabbarCurrentIndex);

                            var index = _orderListProvider.tabbarCurrentIndex;
                            var activeButton = false;
                            switch (index) {
                              case 0:
                                _orderListProvider.waitingCount > 0
                                    ? activeButton = true
                                    : activeButton = false;
                                break;
                              case 1:
                                _orderListProvider.productionCount > 0
                                    ? activeButton = true
                                    : activeButton = false;
                                break;
                              case 2:
                                _orderListProvider.readyCount > 0
                                    ? activeButton = true
                                    : activeButton = false;
                                break;
                            }
                            if (activeButton)
                              _orderListProvider
                                  .showOrderProductStatusChangeButton();

                          },
                        ),

                        ///Close Status Icon
                        InkWell(
                          child: Visibility(
                              visible: _orderListProvider
                                  .orderProductStatusChangeActive,
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
                            _orderListProvider
                                .hideOrderProductStatusChangeButton();
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
      bottomNavigationBar: Visibility(
        visible: _orderListProvider.orderProductStatusChangeActive,
        child: InkWell(
            child: BottomAppBar(
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
                            Text(
                              AppLocalizations.of(context)
                                  .txtBtnChangeOrderStatus,
                              style: Theme.of(context).textTheme.button,
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                      ))
                    ],
                  )),
            ),
            onTap: () async {
              if (_orderListProvider.getSelectedAllOrderProducts().length > 0)
                await _orderListProvider.showOrderProductStatusListPopup();
              else
                appSnackbar(context,
                    AppLocalizations.of(context).txtNoSelectOrderStatus);
            }),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: TabBarView(
        physics: !_orderListProvider.orderProductStatusChangeActive
            ? ClampingScrollPhysics()
            : NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [

          WaitingOrderListWidgets(
            useCase: widget._useCases,
            orderListProvider: _orderListProvider,
          ),
          ProductionOrderListWidgets(
            useCase: widget._useCases,
            orderListProvider: _orderListProvider,
          ),
          ReadyOrderListWidgets(
            useCase: widget._useCases,
            orderListProvider: _orderListProvider,
          ),
        ],
      ),
    );
  }
}



class OrderListTabsScreenWithDrawer extends KFDrawerContent {
  final _useCases;

  OrderListTabsScreenWithDrawer(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return OrderListTabsScreenWithDrawerState();
  }
}



class OrderListTabsScreenWithDrawerState extends State<OrderListTabsScreenWithDrawer>
    with AfterLayoutMixin<OrderListTabsScreenWithDrawer>, SingleTickerProviderStateMixin {
  OrderListProvider _orderListProvider;

  TabController _tabController;

  @override
  void afterFirstLayout(BuildContext context) async {

    _orderListProvider.reOrderListProvider();
    _orderListProvider.useCases = widget._useCases;
    await _orderListProvider.getOrderList();
    await _orderListProvider.setPriceType();
    _orderListProvider.updateProductOrderCounts();
    _orderListProvider.tabbarController = _tabController;
    _orderListProvider.tabbarController
        .addListener((){
      // ignore: unnecessary_statements
      _orderListProvider.handleTabSelection;

      switch (_orderListProvider.tabbarController.index) {
        case 0:
          _orderListProvider.getWaitingOrderList();
          break;
        case 1:
          _orderListProvider.getProductionOrderList();
          break;
        case 2:
          _orderListProvider.getReadyOrderList();
          break;
      }

    }

    );



  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    currentScaffoldState = GlobalKeys.scaffoldKeyNotifications;
  }

  @override
  void dispose() {
    _orderListProvider.tabbarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _orderListProvider = Provider.of<OrderListProvider>(context);
    _orderListProvider.context = context;

    return Scaffold(
      key: GlobalKeys.scaffoldKeyOrders,
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
                    Text(AppLocalizations.of(context).txtTabsWaitingOrders,
                        style: TextStyle(
                          fontSize: 10.0,
                        )),
                    Visibility(
                      visible: _orderListProvider.waitingCount > 0,
                      child: Text(
                        _orderListProvider.waitingCount.toString() +
                            " " +
                            AppLocalizations.of(context).txtLblPackagePiece,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: AppTheme.riverBed[50],
                          fontFamily: 'MontserratSemiBold',
                        ),
                      ),
                    )
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
                  Text(AppLocalizations.of(context).txtTabsManufacturingOrders,
                      style: TextStyle(
                        fontSize: 10.0,
                      )),
                  Visibility(
                    visible: _orderListProvider.productionCount > 0,
                    child: Text(
                      _orderListProvider.productionCount.toString() +
                          " " +
                          AppLocalizations.of(context).txtLblPackagePiece,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: AppTheme.riverBed[50],
                        fontFamily: 'MontserratSemiBold',
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(AppLocalizations.of(context).txtTabsReadyOrders,
                      style: TextStyle(
                        fontSize: 10.0,
                      )),
                  Visibility(
                    visible: _orderListProvider.readyCount > 0,
                    child: Text(
                      _orderListProvider.readyCount.toString() +
                          " " +
                          AppLocalizations.of(context).txtLblPackagePiece,
                      style: TextStyle(
                        fontSize: 10.0,
                        color: AppTheme.riverBed[50],
                        fontFamily: 'MontserratSemiBold',
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        actions: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                children: <Widget>[
                  ///Back Button
                  InkWell(
                    onTap: widget.onMenuPressed,

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
                      child: Text(AppLocalizations.of(context).txtTitleOrders,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center),
                    ),
                  ),


                  SizedBox(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        /*
                    ///Repair Order Product Button
                    InkWell(
                      child: Visibility(
                          visible: !_orderListProvider
                              .orderProductStatusChangeActive,
                          child: Container(
                              padding: EdgeInsets.only(
                                  right: 15.0,
                                  left: 15.0,
                                  top: 15.0,
                                  bottom: 15.0),
                              child: Image.asset(
                                'images/ic_repair_order.png',
                                width: 25,
                                height: 25,
                                fit: BoxFit.contain,
                              ))),
                      onTap: () {},
                    ),
                     */

                        InkWell(
                            onTap: ()async{
                              //  await  _orderListProvider.createPdf();
                            },
                            child: Icon(Icons.ios_share,color: AppTheme.collectionPageColor[50],)),

                        ///Edit Status Icon
                        InkWell(
                          child: Visibility(
                              visible: !_orderListProvider
                                  .orderProductStatusChangeActive,
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
                            print(_orderListProvider.tabbarCurrentIndex);

                            var index = _orderListProvider.tabbarCurrentIndex;
                            var activeButton = false;
                            switch (index) {
                              case 0:
                                _orderListProvider.waitingCount > 0
                                    ? activeButton = true
                                    : activeButton = false;
                                break;
                              case 1:
                                _orderListProvider.productionCount > 0
                                    ? activeButton = true
                                    : activeButton = false;
                                break;
                              case 2:
                                _orderListProvider.readyCount > 0
                                    ? activeButton = true
                                    : activeButton = false;
                                break;
                            }
                            if (activeButton)
                              _orderListProvider
                                  .showOrderProductStatusChangeButton();

                          },
                        ),
                        ///Close Status Icon
                        InkWell(
                          child: Visibility(
                              visible: _orderListProvider
                                  .orderProductStatusChangeActive,
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
                            _orderListProvider
                                .hideOrderProductStatusChangeButton();
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


      bottomNavigationBar: Visibility(
        visible: _orderListProvider.orderProductStatusChangeActive,
        child: InkWell(
            child: BottomAppBar(
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
                                    Text(
                                      AppLocalizations.of(context)
                                          .txtBtnChangeOrderStatus,
                                      style: Theme.of(context).textTheme.button,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                )),
                          ))
                    ],
                  )),
            ),
            onTap: () async {
              if (_orderListProvider.getSelectedAllOrderProducts().length > 0)
                await _orderListProvider.showOrderProductStatusListPopup();
              else
                appSnackbar(context,
                    AppLocalizations.of(context).txtNoSelectOrderStatus);
            }),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: TabBarView(
        physics: !_orderListProvider.orderProductStatusChangeActive
            ? ClampingScrollPhysics()
            : NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [

          WaitingOrderListWidgets(
            useCase: widget._useCases,
            orderListProvider: _orderListProvider,
          ),
          ProductionOrderListWidgets(
            useCase: widget._useCases,
            orderListProvider: _orderListProvider,
          ),
          ReadyOrderListWidgets(
            useCase: widget._useCases,
            orderListProvider: _orderListProvider,
          ),
        ],
      ),
    );
  }
}
