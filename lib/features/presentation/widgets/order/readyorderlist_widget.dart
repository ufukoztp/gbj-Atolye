import 'package:gbjatolye/features/domain/entities/order/order.dart';
import 'package:gbjatolye/features/domain/entities/order2/order_response.dart';
import 'package:gbjatolye/features/domain/entities/product/arguments.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/provider/orderlist_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/detailphoto_preview.dart';
import 'package:gbjatolye/features/presentation/widgets/order/refresh_widget.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:sizer/sizer.dart';
//orderListProvider.getReadyOrderList()
class ReadyOrderListWidgets extends StatefulWidget {
  final OrderListProvider orderListProvider;
  final UseCases useCase;

  const ReadyOrderListWidgets({
    @required this.orderListProvider,
    @required this.useCase,
    Key key,
  }) : super(key: key);

  @override
  _ReadyOrderListWidgetsState createState() => _ReadyOrderListWidgetsState();
}

class _ReadyOrderListWidgetsState extends State<ReadyOrderListWidgets> {
  OrderListProvider _orderListProvider;
  @override
  void initState() {
    // TODO: implement initState
    _orderListProvider=widget.orderListProvider;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Visibility(
              visible: !widget.orderListProvider.readyNoProduct && !widget.orderListProvider.isLoading,
              child: RefreshWidget(
                onRefresh: ()async{
                 await _orderListProvider.getOrderList();
                },

                child: CustomScrollView(
                  slivers: getList(),
                  reverse: false,
                ),
              ),
            ),
            Visibility(
              visible: widget.orderListProvider.readyNoProduct && !widget.orderListProvider.isLoading,
              child:Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Text(
                      AppLocalizations.of(widget.orderListProvider.context).txtLblNoReadyProduct,
                      style: Theme.of(widget.orderListProvider.context).textTheme.headline4
                  ),
                ),
            ),
            Visibility(
              visible: widget.orderListProvider.isLoading,
              child: Padding(
                padding: EdgeInsets.only(top:40.0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoActivityIndicator()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getList() {
    List<Widget> widgets = List<Widget>();
    for (OrderList order in widget.orderListProvider.getReadyOrderList())
      widgets.add(_StickyHeaderList(
        order: order,
        orderListProvider: widget.orderListProvider,
      ));
    return widgets;
  }
}

class _StickyHeaderList extends StatelessWidget {

  final OrderList order;
  final OrderListProvider orderListProvider;

  const _StickyHeaderList({Key key, this.order, this.orderListProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: _header(),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => _cardTemp(i,context),
          childCount: order.products.length,
        ),
      ),
    );
  }

  Widget _header() {
    var date = DateTime.parse(order.orderDate);

    var formattedDate = date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();

    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child: Card(
          margin: EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0),
          color: Colors.grey,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 10.0),
                child: Text(
                  order.supplierOrderCode.toString(),
                  style: TextStyle(
                      color: AppTheme.white[50],
                      fontSize: 14.0,
                      fontFamily: 'MontserratBold'),
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(right: 15.0, top: 10.0, bottom: 10.0),
                  child: Text(
                    formattedDate,
                    style: TextStyle(
                        color: AppTheme.white[50],
                        fontSize: 14.0,
                        fontFamily: 'MontserratBold'),
                  )),
            ],
          )),
    );
  }

  Widget _cardTemp(position,context) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Container(
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            gradient: orderListProvider.orderProductStatusChangeActive && order.products[position].selected?
            LinearGradient(colors: [AppTheme.aqua[50], AppTheme.azureRadiance[50]]):
            LinearGradient(colors: [AppTheme.white[50], AppTheme.white[50]]),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5.0,
                  spreadRadius: -3.0,
                  offset: Offset(0.0, 3.0)),
            ],
          ),
          child: InkWell(
            onTap: () {
              print(position);
              orderListProvider.changeOrderProductSelectedStatus(
                  order.products[position]);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _topInfoSection(position,context),
                    Container(
                      child: (Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Divider(
                                  color: AppTheme.grey[50],
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                    ),
                    _bottomInfoSection(position)
                  ],
                ),
              ),
            )
          ),
        ));
  }

  Widget _topInfoSection(position,context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ///Image
                InkWell(
                  onTap: (){
                    Navigator.of(orderListProvider.context).push( MaterialPageRoute(builder: (context)=>DetailPhotoPreviewScreen(order.products[position].variants[0].image)));

                  },
                  child: Container(
                    width: 85.0,
                    height: 85.0,
                    child: CachedNetworkImage(
                      imageUrl:order.products[position].variants[0].image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.contain),
                        ),
                      ),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ///Jewelry Type
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0, top: 0.0),
                        child: Container(
                          width: 50.0.w,
                          child: Text(
                              order.products[position].jewelryType.name.toString().toUpperCase()+' '+order.products[position].jewelryType.parentName.toString(),
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: AppTheme.collectionPageColor[50],
                                  fontSize: 14.0,
                                  fontFamily: 'MontserratBold')),
                        ),
                      ),

                      ///Product Code
                      Row(
                        children: <Widget>[
                          Container(
                              child: Text(AppLocalizations.of(orderListProvider.context).txtLblOrderProductCode+" : ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppTheme.riverBed[50],
                                      fontSize: 13.0,
                                      fontFamily: 'MontserratSemiBold'))),
                          Container(
                            child: Text(
                                order.products[position].variants[0].productOrderCode
                                    .toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppTheme.riverBed[50],
                                    fontSize: 13.0,
                                    fontFamily: 'MontserratSemiBold')),
                          ),
                        ],
                      ),

                      order.products[position].variants[0].packageCount!=0?
                      ///product package count
                      Row(
                        children: <Widget>[
                          Container(
                              child: Text(AppLocalizations.of(orderListProvider.context).txtLblOrderProductCount+" : ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppTheme.collectionPageColor[50],
                                      fontSize: 13.0,
                                      fontFamily: 'MontserratSemiBold'))),
                          Container(
                            child: Text(
                                order.products[position].variants[0].packageCount.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppTheme.collectionPageColor[50],
                                    fontSize: 13.0,
                                    fontFamily: 'MontserratSemiBold')),
                          ),
                        ],
                      ):Container(),
                      /*
                      ///Order Product Type
                      Row(
                        children: <Widget>[
                          Container(
                              child: Text(AppLocalizations.of(orderListProvider.context).txtLblOrderProductType+" : ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppTheme.collectionPageColor[50],
                                      fontSize: 13.0,
                                      fontFamily: 'MontserratSemiBold'))),
                          Container(
                              child: Text(
                                  order.products[position].variants[0].quantity.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppTheme.collectionPageColor[50],
                                      fontSize: 13.0,
                                      fontFamily: 'MontserratSemiBold'))),
                        ],
                      ),
                       */
                      ///Order Product Weight
                      Row(
                        children: <Widget>[
                          Container(
                              child: Text(AppLocalizations.of(orderListProvider.context).txtLblOrderProductWeight+" : ",
                                  overflow: TextOverflow.ellipsis,
                                  style:TextStyle(
                                      color: AppTheme.collectionPageColor[50],
                                      fontSize: 13.0,
                                      fontFamily: 'MontserratSemiBold'))),
                          Container(
                              child: Text(
                                  order.products[position].variants[0].weight.toString() +
                                      " gr",
                                  overflow: TextOverflow.ellipsis,
                                  style:TextStyle(
                                      color: AppTheme.collectionPageColor[50],
                                      fontSize: 13.0,
                                      fontFamily: 'MontserratSemiBold'))),
                        ],
                      ),

                      ///Order Product Cost
                      Row(
                        children: <Widget>[
                          Container(
                              child: Text(AppLocalizations.of(orderListProvider.context).txtLblOrderProductPrice+" : ",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppTheme.collectionPageColor[50],
                                      fontSize: 13.0,
                                      fontFamily: 'MontserratSemiBold'))),
                          Container(
                              child: Text(
                                  order.products[position].variants[0].cost.toString()+" "+orderListProvider.priceType,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppTheme.collectionPageColor[50],
                                      fontSize: 13.0,
                                      fontFamily: 'MontserratSemiBold'))),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),

            ///Check Button&&Detail routing button
            Stack(
              children: [
                Visibility(
                  visible: !orderListProvider.orderProductStatusChangeActive,
                  child: PopupMenuButton<String>(
                    onSelected: (value){
                      orderListProvider.handleClick(value,position,order);
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Detaya git', 'Paylaş'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ),



                Visibility(
                  visible: orderListProvider.orderProductStatusChangeActive,
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    child: Image.asset(
                      order.products[position].selected != null &&
                              !order.products[position].selected
                          ? 'images/ic_check.png'
                          : 'images/ic_checked.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 2.0.h,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(order.products[position].variants[0].orderoptions.length, (index) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(order.products[position].variants[0].variantOptions.length, (index2) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      order.products[position].variants[0].orderoptions[index].optionGroupId==order.products[position].variants[0].variantOptions[index2].optionGroupId?
                      order.products[position].variants[0].orderoptions[index].optionId!=order.products[position].variants[0].variantOptions[index2].optionId?

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text(order.products[position].variants[0].orderoptions[index].optionGroupName+ " : ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:  Colors.grey,
                                  fontSize: 13.0,
                                  fontFamily: 'MontserratSemiBold')),
                          Row(
                            children: [
                              Text(order.products[position].variants[0].orderoptions[index].optionName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: AppTheme.aqua[50],
                                      fontSize: 13.0,
                                      fontFamily: 'MontserratSemiBold')),
                              SizedBox(width: 2.0.w,),
                              Text("("+order.products[position].variants[0].variantOptions[index2].optionName+")",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppTheme.collectionPageColor[50],
                                    fontSize: 11.0,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'MontserratSemiBold')
                                ,
                              ),
                            ],
                          ),
                        ],
                      ):Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text(order.products[position].variants[0].orderoptions[index].optionGroupName +  " : ",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 13.0,
                                  fontFamily: 'MontserratSemiBold')),
                          Text(order.products[position].variants[0].orderoptions[index].optionName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: AppTheme.collectionPageColor[50],
                                  fontSize: 13.0,
                                  fontFamily: 'MontserratSemiBold')),
                        ],
                      ):Container()






                      /*
                        order.products[position].variants[0].orderoptions[index].costumize==false?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text(order.products[position].variants[0].orderoptions[index].optionGroupName +  " : ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 13.0,
                                    fontFamily: 'MontserratSemiBold')),
                            Text(order.products[position].variants[0].orderoptions[index].optionName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppTheme.collectionPageColor[50],
                                    fontSize: 13.0,
                                    fontFamily: 'MontserratSemiBold')),
                          ],
                        ):
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text(order.products[position].variants[0].orderoptions[index].optionGroupName+ " : ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color:  Colors.grey,
                                    fontSize: 13.0,
                                    fontFamily: 'MontserratSemiBold')),
                            Text(order.products[position].variants[0].orderoptions[index].optionName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppTheme.aqua[50],
                                    fontSize: 13.0,
                                    fontFamily: 'MontserratSemiBold')),
                          ],
                        ),
                        SizedBox(height: 1.0.h,),

                       */

                    ],
                  );
                })
            );

          }),


        ),
      ],
    );
  }
  //AppLocalizations.of(orderListProvider.context).txtLblPackageCount
  Widget _bottomInfoSection(position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 22.5, right: 22.5),
          child: Text(
              order.products[position].variants[0].quantity.toString() + "\n" + "Adet",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color:  AppTheme.collectionPageColor[50],
                  fontSize: 14.0,
                  fontFamily: 'MontserratBold')),
        ),
        Visibility(
          visible: order.products[position].variants[0].description != null ? true : false,
          child: Flexible(
            child: Container(
              padding: EdgeInsets.only(right: 7.0),
              child: Text(
                order.products[position].variants[0].description.toString(),
                style: TextStyle(
                    color:  AppTheme.azureRadiance[50],
                    fontSize: 13.0,
                    fontFamily: 'MontserratBold'),
              ),
            ),
          ),
        ),
        new Container(
          color: Colors.transparent,
          child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(10.0))),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: new Text(
                  AppLocalizations.of(orderListProvider.context).txtTabsReadyOrders,
                  style: TextStyle(
                      color: AppTheme.white[50],
                      fontSize: 13.0,
                      fontFamily: 'MontserratBold'),
                ),
              )),
        ),
      ],
    );
  }
}
