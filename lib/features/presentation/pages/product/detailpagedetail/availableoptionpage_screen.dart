import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/availableoption_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/product/detailphoto_preview.dart';
import 'package:gbjatolye/features/presentation/widgets/product/options_widget.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailableOptionsScreen extends StatefulWidget {
  AvailableOptionsScreen();

  @override
  State<StatefulWidget> createState() {
    return AvailableOptionsScreenState();
  }
}

class AvailableOptionsScreenState extends State<AvailableOptionsScreen>
    with AfterLayoutMixin<AvailableOptionsScreen> {
  ProductDetailProvider _productDetailProvider;

  @override
  void afterFirstLayout(BuildContext context) async {


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
                    ///Title Text
                    Padding(
                      padding: const EdgeInsets.only(left: 135.0),
                      child: Text("Seçenekler",
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
        Visibility(child: CupertinoActivityIndicator(), visible:_productDetailProvider.isLoading==false?true:false ,),
        Visibility(visible: _productDetailProvider.isLoading==false?false:true,
            child: AvailableOptionWidget(_productDetailProvider))]),


      bottomNavigationBar: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color:Theme.of(context).backgroundColor,
            boxShadow: [BoxShadow(color:Theme.of(context).backgroundColor,blurRadius: 20, offset: Offset(0, -20))]),
        child: Padding(
          padding: const EdgeInsets.only(right:20.0),
          child: bottomBarItem(),
        ),
      ),

      backgroundColor: Theme.of(context).backgroundColor,

    );
  }
  Widget bottomBarItem(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right:200.0,bottom: 15),
          child: FloatingActionButton(backgroundColor:Colors.transparent,onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPhotoPreviewScreen(_productDetailProvider.photoUrl)));

          },child: Container(decoration: BoxDecoration(boxShadow:
          [BoxShadow(color: AppTheme.aqua[50],blurRadius: 5)],borderRadius: BorderRadius.circular(50),image: DecorationImage(image: NetworkImage(_productDetailProvider.photoUrl))),),),
        ),
        SizedBox(width: 10,),
        InkWell(onTap:(){
          Navigator.pushNamed(context, "/preview",arguments: OtherOptionsType.availableOptions);
        },child: Container(child: Center(child: Text("BİTTİ",style: TextStyle(color:Colors.white),)),width:70,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: LinearGradient(colors:  [AppTheme.aqua[50],AppTheme.azureRadiance[50]])),))
      ],);
  }


}
