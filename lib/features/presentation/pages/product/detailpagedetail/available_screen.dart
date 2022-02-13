import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/otheroptionsdialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/product/preview_widget.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gbjatolye/features/domain/entities/detailPhoto_models.dart';



class ProductPreviewScreen extends StatefulWidget {
  final _useCases;
  OtherOptionsType requestType;
  ProductPreviewScreen(this._useCases,this.requestType);

  @override
  State<StatefulWidget> createState() {
    return ProductPreviewScreenState();
  }

}

class ProductPreviewScreenState extends State<ProductPreviewScreen>
    with AfterLayoutMixin<ProductPreviewScreen> {


  ProductDetailProvider _productDetailProvider;



  Future sendApprovalState(BuildContext context) async {
    if(widget.requestType==OtherOptionsType.availableOptions){
      _productDetailProvider.designloading=false;
      _productDetailProvider.otherOptionState=false;
      await _productDetailProvider.sendApprovalAvailable();
    }else{
      _productDetailProvider.designloading=false;
      _productDetailProvider.otherOptionState=false;
      _productDetailProvider.sendApproval().then((value) async{
        bool value= await otherOptionsDialog(context: context,inputtype: OtherOptionsType.availableOptions);
        if(value==true){
          Navigator.pushReplacementNamed(context, AppRoutes.availableoptions);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.productlist, (route) => false,arguments: _productDetailProvider.jeweleryId);
        }
      });
    }
  }


  showOtherOption(context) async {
    // ignore: missing_return
    _productDetailProvider.otherOptionState=  await otherOptionsDialog(context: context,inputtype:OtherOptionsType.otherOptions,).then((value) {
      if(value==true){
        Navigator.pushNamed(context, AppRoutes.otheroptions).then((value) {
          setState(() {
          });
        });
      }
    });
  }


  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    _productDetailProvider = Provider.of<ProductDetailProvider>(context);
    return Scaffold(
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
                          Navigator.pop(context);
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
                          padding: const EdgeInsets.only(right:60.0),
                          child: Text(
                              "ÖNİZLEME",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ]),
        bottomNavigationBar: Visibility(
          visible:true, //_productDetailProvider.updateEvent,
          child: GestureDetector(
              child: BottomAppBar(
                child: Container(
                    decoration: BoxDecoration(boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 20.0,
                          spreadRadius: 20.0,
                          offset: Offset(0.0, 20.0))
                    ], gradient: LinearGradient( colors: <Color>[
                      AppTheme.aqua[50],
                      AppTheme.azureRadiance[50],
                    ],)),
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient( colors: <Color>[
                                    AppTheme.aqua[50],
                                    AppTheme.azureRadiance[50],
                                  ],)
                              ),
                              height: 50,
                              child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("ONAYA GÖNDER",
                                          style: Theme.of(context).textTheme.button,
                                          textAlign: TextAlign.center),
                                    ],
                                  )),
                            ))
                      ],
                    )),
              ),
              onTap: () async {
                await sendApprovalState(context);

              }),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: <Widget>[
            Visibility(
              visible: true,
              child: PreviewlWidget(
                photoUrl: _productDetailProvider.photoUrl,
                useCases: widget._useCases,
                productDetailProvider: _productDetailProvider,
              ),
            ),
            Visibility(
              visible:false,
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
        ));
  }




  @override
  void afterFirstLayout(BuildContext context) {
    showOtherOption(context);

  }
}
