import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/features/domain/entities/product/arguments.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/product/design_types_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/product/detailphoto_preview.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesignTypesScreen extends StatefulWidget {
  final _useCases;
  final ArgumentsWithProvider _data;

  DesignTypesScreen(this._useCases, this._data);

  @override
  State<StatefulWidget> createState() {
    return DesignTypesScreenState();
  }
}

class DesignTypesScreenState extends State<DesignTypesScreen>
    with AfterLayoutMixin<DesignTypesScreen> {

ProductDetailProvider _productDetailProvider;

  @override
  void afterFirstLayout(BuildContext context) async {

  }

  @override
  void initState() {
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    _productDetailProvider = Provider.of<ProductDetailProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 75.0),
                      child: Text("Dizayn Tipleri",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
          ]),

      body:_productDetailProvider.designloading==true?
      Center(child:CircularProgressIndicator()): DesignTypesWidget(widget._useCases),

      bottomNavigationBar: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color:Theme.of(context).backgroundColor,
            boxShadow: [BoxShadow(color:Theme.of(context).backgroundColor,blurRadius: 20, offset: Offset(0, -20))]),
        child: Padding(
          padding: const EdgeInsets.only(right:20.0),
          child: bottomItems(widget: widget, widget2: widget, widget3: widget, productDetailProvider: _productDetailProvider, widget4: widget),
        ),
      ),


      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}


///bottom widget
class bottomItems extends StatelessWidget {
  const bottomItems({
    Key key,
    @required this.widget,
    @required this.widget2,
    @required this.widget3,
    @required this.widget4,
    @required ProductDetailProvider productDetailProvider,
  }) : _productDetailProvider = productDetailProvider, super(key: key);

  final DesignTypesScreen widget;
  final DesignTypesScreen widget2;
  final DesignTypesScreen widget3;
  final DesignTypesScreen widget4;
  final ProductDetailProvider _productDetailProvider;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ///Fotoğraf kutucuğu ve atla,ileri butonları
        Padding(
          padding: const EdgeInsets.only(right:130.0,bottom: 15),
          child: FloatingActionButton(backgroundColor:Colors.transparent,onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPhotoPreviewScreen(widget._data.productdata.url)));

          },child: Container(decoration: BoxDecoration(boxShadow:
          [BoxShadow(color: AppTheme.aqua[50],blurRadius: 5)],borderRadius: BorderRadius.circular(50),image: DecorationImage(image: NetworkImage(widget._data.productdata.url))),),),
        ),
        InkWell(onTap:(){

          Navigator.pushNamed(context, AppRoutes.options,arguments: widget._data).then((value){
            _productDetailProvider.isLoading=false;
            if( value==popPage.DetailPage){
              Navigator.of(context).pop();
            }else{
              // ignore: unnecessary_statements
              null;
            }
          }
          );
        },
            child: Container(child: Center(child: Text("ATLA",style: TextStyle(color:Colors.white,fontSize: 13))),width:70,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: LinearGradient(colors: [AppTheme.aqua[50],AppTheme.azureRadiance[50]])),)),

        SizedBox(width: 10,),

        StatefulBuilder(
          builder: (context,innerState){
            return InkWell(onTap:(){
              _productDetailProvider.designSelectedButton==true?
              Navigator.pushNamed(context, AppRoutes.options,arguments: widget._data).then((value) {
                _productDetailProvider.isLoading=false;
                if( value==popPage.DetailPage){
                  Navigator.of(context).pop();
                }else{
                  // ignore: unnecessary_statements
                  null;
                }}):appSnackbar(context,'İlerlermek için dizayn tipi seçiniz.');

            },child:Container(child:
            Center(child: Text("İLERİ",
              style: TextStyle(color:Colors.white,fontSize: 14),)),
              width:70,height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors:[AppTheme.aqua[50],AppTheme.azureRadiance[50]])),)




            );}
        )


      ],);
  }
}
