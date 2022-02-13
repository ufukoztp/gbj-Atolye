import 'package:flutter/cupertino.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DesignTypesWidget extends StatefulWidget {
  final useCases;

    DesignTypesWidget(this.useCases, ) : super();

  @override
  DesignTypesWidgetState createState() => DesignTypesWidgetState();
}

class DesignTypesWidgetState extends State<DesignTypesWidget>
    with SingleTickerProviderStateMixin {

  ProductDetailProvider _productDetailProvider;


  void setSelected(int index) {
    if( _productDetailProvider.option[index].selected==true){
      setState(() {
        _productDetailProvider.option[index].selected=false;
      });

    }else{
      /*
      ///başka design type seçilince diğerlerinin selected durumunu false yapar
      List.generate(_productDetailProvider.option.length, (index) {
        _productDetailProvider.option[index].selected=false;
        print(_productDetailProvider.option[index].selected.toString()+index.toString());
      }
     );
       */
      setState(() {
        _productDetailProvider.option[index].selected=true;
        _productDetailProvider.designSelectedButton=true;

      });
    }
  }


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
_productDetailProvider = Provider.of<ProductDetailProvider>(context);

    return Column(
      children: [
        ///ürün tipi seçiniz açıklaması
    Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Center(child:
      Padding(
          padding: const EdgeInsets.only(bottom:20.0),
          child:
          Text("Ürününüze uygun dizayn tipini seçiniz.",
            style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.black26),),
        ),
      ),
    ),


      Expanded(
      child: 
      GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
          itemCount:_productDetailProvider.option.length,
          itemBuilder: (context,index){
        return Column(children: [
          InkWell(
            onTap:() {
              ///ürün selected true ise false false ise true yapan kontrol
            setSelected(index);
            },
            child: StatefulBuilder(
              builder:(context,i) {
                return Stack(
                children: [
                  Padding(
                  padding: const EdgeInsets.only(top:30.0),
                  child: Column(
                    children: [
                      _productDetailProvider.option[index].icon!=null?
                      CachedNetworkImage(
                        imageUrl:_productDetailProvider.option[index].icon,
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                      ):Container(),

                      SizedBox(height: 6,),
                      Center(child: Text(_productDetailProvider.option[index].name,style:Theme.of(context).textTheme.headline3.copyWith(fontSize: 10,color: AppTheme.bigStone[50]),)),
                    ],
                  ),
                ),
                  Positioned(top:70,left: 80,
                      child: Visibility(visible: _productDetailProvider.option[index].selected==true?true:false,
                          child:Icon(Icons.check,color: AppTheme.bigStone[50],))),
                ],

              );}
            ),
          )
        ],);
      }),
    )
      ],
    );
  }

}




