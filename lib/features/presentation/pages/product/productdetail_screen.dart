import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/domain/entities/homecategory.dart';
import 'package:gbjatolye/features/domain/entities/product/arguments.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/notedialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/product/product_detail_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/messagedialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:gbjatolye/features/domain/entities/detailPhoto_models.dart';

class ProductDetailScreen extends StatefulWidget {
  final _useCases;
  final Arguments productdata;

  ProductDetailScreen(
    this._useCases,
    this.productdata,
  );

  @override
  State<StatefulWidget> createState() {
    return ProductDetailScreenState();
  }
}

class ProductDetailScreenState extends State<ProductDetailScreen>
    with AfterLayoutMixin<ProductDetailScreen>, SingleTickerProviderStateMixin {
  int like=0;
  ProductDetailProvider _productDetailProvider;
  String description='';
  @override
  void afterFirstLayout(BuildContext context) async {
    _productDetailProvider.optionLoading=true;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      //_productDetailProvider.variantId=widget.productdata.productId;
      // _productDetailProvider.photoUrl=widget.productdata.url;
       //_productDetailProvider.jeweleryId=widget.productdata.jewelerytypesId;
       _productDetailProvider.productId=widget.productdata.productId;

      if (like == 0) {
        ShowCaseWidget.of(context).startShowCase([
          _productDetailProvider.productNoteShowcaseKey,
          _productDetailProvider.productDetailsShowcaseKey
        ]);
      }

      _productDetailProvider.useCases = widget._useCases;
      _productDetailProvider.context = context;
      await _productDetailProvider.getProduct(widget.productdata.productId).then((value) {




        _productDetailProvider.optionLoading=false;
        _productDetailProvider.designAndOptionsloading = false;

        if(_productDetailProvider.note==null&&like<=0){
          description=AppLocalizations.of(context)
              .txtShowcaseProductNote;
        }else if(_productDetailProvider.note==null&&like>0){

          description=AppLocalizations.of(context)
              .txtShowcaseProductNote;

        }else if(_productDetailProvider.note!=null&&like==0){
          description=_productDetailProvider.note;
        }else if(_productDetailProvider.note!=null&&like!=0){

          description=_productDetailProvider.note;

        }

      });

      await _productDetailProvider.getDesignTypes(widget.productdata.productId.toString());

      await _productDetailProvider.getOtherOptions(
          widget.productdata.productId.toString(),
          widget.productdata.variantId.toString());




      //   _productDetailProvider.fillFirstValue();
      var productDetailShowcase =
          await widget._useCases.getProductDetailShowcaseView();


      productDetailShowcase.fold((exception) {
        SnackbarErrors(context: context, exp: exception);
      }, (val) async {
        if (val)
          WidgetsBinding.instance.addPostFrameCallback(
                  (_) => ShowCaseWidget.of(context).startShowCase([
                _productDetailProvider.productNoteShowcaseKey,
                _productDetailProvider.productDetailsShowcaseKey
              ]));
      });

    });
/*
    HomeCategory category = HomeCategory.fromJson(appIntent.data);
    _productDetailProvider.homeCategory=category;


 */
    await _productDetailProvider.getPriceType();


  }

  Future<bool> _onWillPop() async {
    if (_productDetailProvider.updateEvent) {
      MessageDialogTypes messageDialogOption = await asyncFilterMessageDialog(
          context,
          DialogType.BackWidget,
          AppLocalizations.of(context).txtPopupCancelDetailChanged);
      if (messageDialogOption == MessageDialogTypes.OK)
        Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }

    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*
    if (appIntent.intent == PageIntents.ToProductDetailFromProductList) {
      // this.product = appIntent.data;
              print(appIntent.data["titleName"]+ " initstate");

    }
    */


  }

  @override
  Widget build(BuildContext context) {
    _productDetailProvider = Provider.of<ProductDetailProvider>(context);
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppTheme.white[50],
                actions: <Widget>[
                  Expanded(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          ///Back Button
                          InkWell(
                            onTap: () async {
                              await _onWillPop();
                              _productDetailProvider.designloading = true;
                              _productDetailProvider.designSelectedButton =
                                  false;
                              _productDetailProvider.otherOptionState = false;
                            },
                            child: Padding(
                              child: Image.asset(
                                'images/ic_back.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                              ),
                              padding: EdgeInsets.only(
                                  right: 15.0,
                                  left: 15.0,
                                  top: 15.0,
                                  bottom: 15.0),
                            ),
                          ),

                          ///Title Text
                          Expanded(
                            child: Text("DETAY",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center),
                          ),

                          Stack(
                            children: <Widget>[
                              Showcase(
                                key: _productDetailProvider
                                    .productNoteShowcaseKey,
                                description: description+"  ",
                                animationDuration: Duration(seconds: 2),
                                descTextStyle:
                                    Theme.of(context).textTheme.headline4,
                                child: InkWell(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          right: 15.0,
                                          left: 15.0,
                                          top: 15.0,
                                          bottom: 15.0),
                                      child: Image.asset(
                                        'images/ic_note.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      )),
                                  onTap: () async {
                                    final String note = await asyncNoteDialog(
                                        context: context,
                                        note: _productDetailProvider.note);
                                    if (note != null)
                                      _productDetailProvider.updateNote(
                                          note,
                                          _productDetailProvider
                                              .products.productId);


                                  },
                                ),
                              ),
                              Visibility(
                                visible:  _productDetailProvider.note!=null?true:false,
                                child:  Container(
                                  child: Positioned(
                                    left: 10.0,
                                    top: 10.0,
                                    child: ClipOval(
                                      child: Container(
                                        color: AppTheme.darkRed[50],
                                        height: 10.0, // height of the button
                                        width: 10.0, // width of the button
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
            bottomNavigationBar: Stack(children: [
             _productDetailProvider.products!=null? Visibility(
                visible: _productDetailProvider.checkData(),

                //_productDetailProvider.updateEvent,
                child: GestureDetector(
                    child: BottomAppBar(
                      child: Container(
                          decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 20.0,
                                    spreadRadius: 20.0,
                                    offset: Offset(0.0, 20.0))
                              ],
                              gradient: LinearGradient(
                                colors: <Color>[
                                  _productDetailProvider.designloading
                                      ? Colors.white30
                                      : AppTheme.aqua[50],
                                  AppTheme.azureRadiance[50],
                                ],
                              )),
                          child: new Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: <Color>[
                                    AppTheme.aqua[50],
                                    AppTheme.azureRadiance[50],
                                  ],
                                )),
                                height: 50,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Stack(
                                      children: [
                                        Visibility(
                                            visible:
                                            _productDetailProvider.designAndOptionsloading==false?
                                            (_productDetailProvider
                                                .designloading ==
                                                false &&
                                                _productDetailProvider
                                                    .products.designTypes.length >
                                                    0 ||
                                                _productDetailProvider.products
                                                    .spectListDtos.length >
                                                    0)?true:false:false,
                                            child: Text("Düzenle",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                                textAlign: TextAlign.center)),

                                        Visibility(
                                            visible:
                                            _productDetailProvider.designAndOptionsloading==false?
                                            (_productDetailProvider
                                                        .designloading ==
                                                    false &&
                                                _productDetailProvider
                                                        .products.designTypes.length ==
                                                    0 &&
                                                _productDetailProvider.products
                                                        .spectListDtos.length ==
                                                    0)?true:false:false,
                                            child: Text("Devam",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                                textAlign: TextAlign.center)),
                                        Visibility(
                                            visible: _productDetailProvider
                                                .designloading,
                                            child: CupertinoActivityIndicator())
                                      ],
                                    ),
                                  ],
                                )),
                              ))
                            ],
                          )),
                    ),
                    onTap: () async {
                      _productDetailProvider.designloading == true
                          // ignore: unnecessary_statements
                          ? () {}
                          : Navigator.pushNamed(context, AppRoutes.designtypes,
                              arguments: ArgumentsWithProvider(
                                productdata: widget.productdata,
                              ));
                    }),
              ):Container()
              /*
              Visibility(
                ///eğer detail bilgileri yüklenmişse ve gerekli şartlar sağlanmışsa true yüklenmemiş veya şartlar sağlanmamışsa false
                visible:
                _productDetailProvider.loading==false?
                (_productDetailProvider.checkCriticalUpdate == false &&
                        _productDetailProvider.products.weight > 0 &&
                        _productDetailProvider.products.minimumOrderQuantity >0&&
                        _productDetailProvider.products.cost > 0)
                    ? true
                    : false:false, //_productDetailProvider.updateEvent,
                child: GestureDetector(
                    child: BottomAppBar(
                      child: Container(
                          decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 20.0,
                                    spreadRadius: 20.0,
                                    offset: Offset(0.0, 20.0))
                              ],
                              gradient: LinearGradient(
                                colors: <Color>[
                                  AppTheme.aqua[50],
                                  AppTheme.azureRadiance[50],
                                ],
                              )),
                          child: new Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: <Color>[
                                    AppTheme.aqua[50],
                                    AppTheme.azureRadiance[50],
                                  ],
                                )),
                                height: 50,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("ONAYA GÖNDER",
                                        style:
                                            Theme.of(context).textTheme.button,
                                        textAlign: TextAlign.center),
                                  ],
                                )),
                              ))
                            ],
                          )),
                    ),
                    onTap: () async {
                      _productDetailProvider.sendApproval();
                    }),
              ),

               */
            ]),
            backgroundColor: Theme.of(context).backgroundColor,
            body: Stack(
              children: <Widget>[
              Visibility(
                  visible:_productDetailProvider.optionLoading==false&&_productDetailProvider.products!=null?true:false,
                  child: ProductDetailWidget(
                    useCases: widget._useCases,
                    productDetailProvider: _productDetailProvider,
                    likeCount: like,
                  ),
                ),
                Visibility(
                  visible: _productDetailProvider.optionLoading==true?true:false,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[CupertinoActivityIndicator()],
                    ),
                  ),
                ),

              ],
            )));
  }


}
