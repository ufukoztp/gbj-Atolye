import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/features/domain/entities/product/arguments.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/product/detailphoto_preview.dart';
import 'package:gbjatolye/features/presentation/widgets/product/options_widget.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsScreen extends StatefulWidget {
  final  _useCases;
  final ArgumentsWithProvider _data;
  OptionsScreen(this._useCases, this._data);

  @override
  State<StatefulWidget> createState() {
    return OptionsScreenState();
  }
}

class OptionsScreenState extends State<OptionsScreen>
    with AfterLayoutMixin<OptionsScreen> {
  ProductDetailProvider _productDetailProvider;

  void checkRoute() {
    Navigator.pushNamed(context, "/preview",arguments: OtherOptionsType.otherOptions).then((value) {
      if(value==popPage.DesignTypesPage){
        Navigator.of(context).pop();
      }
      if(value==popPage.DetailPage){
        Navigator.pop(context,popPage.DetailPage);
      }else{
        // ignore: unnecessary_statements
        null;
      }


    });
  }



  @override
  void afterFirstLayout(BuildContext context) async {

    List<int> selectedDesignId= _productDetailProvider.checkdesignSelected();

    await _productDetailProvider.getOptions(jewelerytypeid: _productDetailProvider.jeweleryId,variantId: _productDetailProvider.variantId,designId:selectedDesignId);

    //await _productDetailProvider.checkOptionsSelect();

  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _productDetailProvider=Provider.of<ProductDetailProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
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
                        _productDetailProvider.isLoading=false;
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
                      padding: const EdgeInsets.only(left: 85.0),
                      child: Text("Özellikler",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
          ]),
      body: Stack(children: [
        _productDetailProvider.isLoading==false? Center(child: CupertinoActivityIndicator()):OptionWidget(_productDetailProvider)

   ]),
      bottomNavigationBar: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color:Theme.of(context).backgroundColor,
            boxShadow: [BoxShadow(color:Theme.of(context).backgroundColor,blurRadius: 20, offset: Offset(0, -20))]),
        child: Padding(
          padding: const EdgeInsets.only(right:20.0),
          child:bottomBarItems() ,
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,

    );
  }

  Widget bottomBarItems(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ///Fotoğraf kutucuğu ve atla,ileri butonları
        Padding(
          padding: const EdgeInsets.only(right:200.0,bottom: 15),
          child: FloatingActionButton(backgroundColor:Colors.transparent,onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPhotoPreviewScreen(widget._data.productdata.url)));

          },child: Container(decoration: BoxDecoration(boxShadow:
          [BoxShadow(color: AppTheme.aqua[50],blurRadius: 5)],borderRadius: BorderRadius.circular(50),image: DecorationImage(image: NetworkImage(widget._data.productdata.url))),),),
        ),
        SizedBox(width: 10,),
        InkWell(onTap:(){

          List<bool> critictDataChanged=[];
          ///required true ise listeye at
          _productDetailProvider.personalizeOptions.forEach((element) {
          if(element.required==true){
            critictDataChanged.add(element.changed);
          }
          });

          List<bool> checkCritictData() {
            List<bool> tt =List<bool>();
            critictDataChanged.forEach((element) {
              if(element==true){
                tt.add(element);
                print(element);
              }
            });
            return tt;
          }
          if(checkCritictData().length==critictDataChanged.length){
            checkRoute();
          }else{
            appSnackbar(context, 'Lütfen seçilmesi zorunlu alanları seçiniz');
          }




        },child: Container(child: Center(child: Text("İLERİ",style: TextStyle(color:Colors.white),)),width:70,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: LinearGradient(colors:  [AppTheme.aqua[50],AppTheme.azureRadiance[50]])),))
      ],);
  }

}


