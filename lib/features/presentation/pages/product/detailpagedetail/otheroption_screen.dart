import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/otheroptions_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/product/detailphoto_preview.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherOptionScreen extends StatefulWidget {
  final _useCases;
  OtherOptionScreen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return OtherOptionScreenState();
  }
}

class OtherOptionScreenState extends State<OtherOptionScreen>
    with AfterLayoutMixin<OtherOptionScreen> {
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
  // ignore: missing_return
  Widget build(BuildContext context) {
    _productDetailProvider=Provider.of<ProductDetailProvider>(context);
    try {
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
                        child: Text("Ek Özellikler",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
        body: OtherOptionWidget(_productDetailProvider),
        bottomNavigationBar: Container(
          height: 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color:Theme.of(context).backgroundColor,
              boxShadow: [BoxShadow(color:Theme.of(context).backgroundColor,blurRadius: 20, offset: Offset(0, -10))]),
          child: Padding(
            padding: const EdgeInsets.only(right:20.0),
            child: bottomBarItems(),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,

      );} on Exception catch (e, s) {
      print(s);
    }

  }
Widget bottomBarItems(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ///Fotoğraf kutucuğu ve bitti butonları
        Padding(
          padding: const EdgeInsets.only(right:190.0,bottom: 15),
          child: FloatingActionButton(backgroundColor:Colors.transparent,onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPhotoPreviewScreen(_productDetailProvider.photoUrl)));

          },child: Container(decoration: BoxDecoration(boxShadow:
          [BoxShadow(color: AppTheme.aqua[50],blurRadius: 5)],borderRadius: BorderRadius.circular(50),image: DecorationImage(image: NetworkImage(_productDetailProvider.photoUrl))),),),
        ),
        SizedBox(width: 10,),
        InkWell(onTap:(){

          setState(() {
            Column
              (
              children: List.generate(
                  _productDetailProvider.personalizeOptions
                      .length, (index1) {

                return Column(
                  children: List.generate(
                      _productDetailProvider
                          .personalizeOptions[index1]
                          .options
                          .length, (index2) {
                    print( _productDetailProvider
                        .personalizeOptions[index1]
                        .options[index2].name+ " : "+ _productDetailProvider
                        .personalizeOptions[index1]
                        .options[index2].selected.toString());
                    return Container();

                    // return      widget
                    //                   .productDetailProvider
                    //                   .personalizeOptions[index1]
                    //                   .options[index2]
                    //                   .selected ==
                    //               true
                    //           ? Text(widget
                    //               .productDetailProvider
                    //               .personalizeOptions[index1]
                    //               .options[index2]
                    //               .name)
                    //           : Container();
                  }),
                );



              }),
            );

          });

          Navigator.pop(context,true);
        },child: Container(child: Center(child: Text("BİTTİ",style: TextStyle(color:Colors.white),)),width:70,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: LinearGradient(colors:  [AppTheme.aqua[50],AppTheme.azureRadiance[50]])),))
      ],);
}

}
