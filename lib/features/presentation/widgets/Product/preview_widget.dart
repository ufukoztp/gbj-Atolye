import 'package:flutter/cupertino.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PreviewlWidget extends StatefulWidget {
  final ProductDetailProvider productDetailProvider;
  final useCases;
  final OtherOptionsType requestType;
  final String photoUrl;

  PreviewlWidget(
      {Key key,
      @required this.productDetailProvider,
      @required this.useCases,
      this.photoUrl,this.requestType})
      : super(key: key);

  @override
  _PreviewWidgetState createState() => _PreviewWidgetState();
}

class _PreviewWidgetState extends State<PreviewlWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: ListView(
      padding: EdgeInsets.only(bottom: 10.0),
      shrinkWrap: false,
      children: <Widget>[
        /// Photo Gallery and dots
        _photoGalleryAndDots(),

        /// Other Contents

        _content(context),
      ],
    ));
  }

  Widget _photoGalleryAndDots() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
            color: AppTheme.black[50],
            child: AspectRatio(
                aspectRatio: 1.0,
                child: ClipRect(
                    child: PhotoViewGallery.builder(
                  loadingChild: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          AppTheme.azureRadiance[50]),
                    ),
                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    String fullUrl = widget.photoUrl;

                    return PhotoViewGalleryPageOptions(
                      imageProvider: CachedNetworkImageProvider(fullUrl),
                      minScale: PhotoViewComputedScale.covered,
                      maxScale: PhotoViewComputedScale.covered,
                    );
                  },
                  itemCount: 1,
                  //onPageChanged: onPageChanged,
                )))),
        Padding(
          padding: EdgeInsets.all(10),
          child: new DotsIndicator(
            dotsCount: 1,
            position: 0,
            decorator: DotsDecorator(
              //color: Colors.black87,
              activeColor: AppTheme.azureRadiance[50],
              size: const Size.square(10.0),
              activeSize: const Size.square(10.0),
            ),
          ),
        )
      ],
    );
  }

  Widget _content(context) {
    return widget.productDetailProvider.designAndOptionsloading == false
        ? Column(
            children: <Widget>[
              ///Select Product Type
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(AppLocalizations.of(context).txtLblProductType,
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.left),
                  )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  widget.productDetailProvider.products
                                      .mixQuantity <
                                      1
                                      ? AppLocalizations.of(context)
                                      .txtLblSingleProduct
                                      : AppLocalizations.of(context)
                                      .txtLblPackageProduct,
                                  style: Theme.of(context).textTheme.headline4,
                                  textAlign: TextAlign.left),
                            ],
                          )))
                ],
              ),
              Visibility(
                visible: widget.productDetailProvider.products.mixQuantity==0?false:true,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Paketteki Ürün Sayısı",
                              style: Theme.of(context).textTheme.headline3,
                              textAlign: TextAlign.left),
                        )),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                    widget.productDetailProvider.products.mixQuantity.toString(),
                                    style: Theme.of(context).textTheme.headline4,
                                    textAlign: TextAlign.left),

                              ],
                            )))
                  ],
                ),
              ),
              ///Weight
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[

                        Text(
                            widget.productDetailProvider.products.productType ==
                                    "SingleProduct"
                                ? AppLocalizations.of(context)
                                    .txtLblPackageWeight
                                : AppLocalizations.of(context).txtLblWeight,
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.left),
                        Visibility(
                          visible: widget.productDetailProvider.products !=
                                      null &&
                                  widget.productDetailProvider.products.weight >
                                      0.0
                              ? false
                              : true,
                          child: Text(" (*)",
                              style: TextStyle(
                                  color: AppTheme.red[50],
                                  fontFamily: 'MontserratBold'),
                              textAlign: TextAlign.start),
                        )


                      ],
                    ),
                  )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  widget.productDetailProvider.products.weight
                                          .toString() +
                                      " " +
                                      AppLocalizations.of(context)
                                          .txtLblWeightUnit,
                                  style: Theme.of(context).textTheme.headline4,
                                  textAlign: TextAlign.left),
                            ],
                          )))
                ],
              ),
              widget.productDetailProvider.products.sizeList.length!=0?
                  Column(
                    children: List.generate(widget.productDetailProvider.products.sizeList.length, (index) {
                      return    widget.productDetailProvider.checkdSizeListSelectedName(index)!=null?
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        "Ölçü Listesi",
                                        style: Theme.of(context).textTheme.headline3,
                                        textAlign: TextAlign.left),
                                    /*
                              Visibility(
                                visible: widget.productDetailProvider.products !=
                                    null &&
                                    widget.productDetailProvider.products.weight >
                                        0.0
                                    ? false
                                    : true,
                                child: Text(" (*)",
                                    style: TextStyle(
                                        color: AppTheme.red[50],
                                        fontFamily: 'MontserratBold'),
                                    textAlign: TextAlign.start),
                              )



                               */
                                  ],
                                ),
                              )),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                          widget.productDetailProvider.checkdSizeListSelectedName(index),
                                          style: Theme.of(context).textTheme.headline4,
                                          textAlign: TextAlign.left),

                                    ],
                                  )))
                        ],
                      ):Container();
                    }) ,
                  ) :Container(),
              /*
              widget.productDetailProvider.checkdSizeListSelectedName(0)!=null?
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "Ölçü Listesi",
                                style: Theme.of(context).textTheme.headline3,
                                textAlign: TextAlign.left),
                            /*
                              Visibility(
                                visible: widget.productDetailProvider.products !=
                                    null &&
                                    widget.productDetailProvider.products.weight >
                                        0.0
                                    ? false
                                    : true,
                                child: Text(" (*)",
                                    style: TextStyle(
                                        color: AppTheme.red[50],
                                        fontFamily: 'MontserratBold'),
                                    textAlign: TextAlign.start),
                              )



                               */
                          ],
                        ),
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  widget.productDetailProvider.checkdSizeListSelectedName(0),
                                  style: Theme.of(context).textTheme.headline4,
                                  textAlign: TextAlign.left),

                            ],
                          )))
                ],
              ):Container():null

               */

              ///Minimum Satış Adedi
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Text("Minimum Satış Adeti",
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.left),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  widget.productDetailProvider.products
                                          .minimumOrderQuantity
                                          .toString() +
                                      " " +
                                      "Adet",
                                  style: Theme.of(context).textTheme.headline4,
                                  textAlign: TextAlign.left),
                            ],
                          )))
                ],
              ),
              ///CostType
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                                "Fiyat tipi",
                                style: Theme.of(context).textTheme.headline3,
                                textAlign: TextAlign.left),
                            Visibility(
                              visible: widget.productDetailProvider.products !=
                                  null &&
                                  widget.productDetailProvider.products.cost >
                                      0.0
                                  ? false
                                  : true,
                              child: Text(" (*)",
                                  style: TextStyle(
                                      color: AppTheme.red[50],
                                      fontFamily: 'MontserratBold'),
                                  textAlign: TextAlign.start),
                            )
                          ],
                        ),
                      )),
               Expanded(child: widget.productDetailProvider.products.costType==0?Padding(
                 padding: const EdgeInsets.only(left:10.0),
                 child: Text("Gram",style:Theme.of(context).textTheme.headline4 ,),
               ):Padding(
                 padding: const EdgeInsets.only(left:10.0),
                 child: Text("Adet",style:Theme.of(context).textTheme.headline4),
               ))
                ],
              ),
              ///Price
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[

                        Text(
                            widget.productDetailProvider.products
                                        .productType ==
                                    "SingleProduct"
                                ? AppLocalizations.of(context)
                                    .txtLblPackagePrice
                                : AppLocalizations.of(context).txtLblPiecePrice,
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.left),
                        Visibility(
                          visible: widget.productDetailProvider.products !=
                                      null &&
                                  widget.productDetailProvider.products.cost >
                                      0.0
                              ? false
                              : true,
                          child: Text(" (*)",
                              style: TextStyle(
                                  color: AppTheme.red[50],
                                  fontFamily: 'MontserratBold'),
                              textAlign: TextAlign.start),
                        )


                      ],
                    ),
                  )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  widget.productDetailProvider.products.cost
                                          .toString() +
                                      " " +
                                      widget.productDetailProvider.priceType,
                                  style: Theme.of(context).textTheme.headline4,
                                  textAlign: TextAlign.left),
                            ],
                          )))
                ],
              ),
              ///Toplam Fiyat
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("Toplam Fiyat",
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.left),
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  widget.productDetailProvider.products.costType==0?
                                  widget.productDetailProvider.gramTotalCost().toStringAsFixed(2)+" "+widget.productDetailProvider.priceType:widget.productDetailProvider.adetTotalCost().toStringAsFixed(2)+" "+widget.productDetailProvider.priceType,
                                  style: Theme.of(context).textTheme.headline4,
                                  textAlign: TextAlign.left),

                            ],
                          )))
                ],
              ),

              Divider(),
              Column(
                children: [
                  ///1. Toplu Satış Adedi
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text("1. Toplu Satış Adeti",
                                style: Theme.of(context).textTheme.headline3,
                                textAlign: TextAlign.left),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      widget.productDetailProvider.products
                                              .bulkQuantity
                                              .toString() +
                                          " " +
                                          "Adet",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4,
                                      textAlign: TextAlign.left),
                                ],
                              )))
                    ],
                  ),

                  ///1.çoklu Satış Fiyatı

                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text("1. Toplu Satış Fiyatı",
                                style: Theme.of(context).textTheme.headline3,
                                textAlign: TextAlign.left),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      widget.productDetailProvider.products
                                              .bulkCost
                                              .toString() +
                                          " " +
                                          widget.productDetailProvider
                                              .priceType,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4,
                                      textAlign: TextAlign.left),
                                ],
                              )))
                    ],
                  ),

                  ///2.çoklu Satış Adedi
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text("2. Toplu Satış Adeti",
                                style: Theme.of(context).textTheme.headline3,
                                textAlign: TextAlign.left),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      widget.productDetailProvider.products
                                              .bulkQuantity2
                                              .toString() +
                                          " " +
                                          "Adet",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4,
                                      textAlign: TextAlign.left),
                                ],
                              )))
                    ],
                  ),

                  ///2.çoklu Satış Fiyatı

                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text("2.Toplu Satış Fiyatı",
                                style: Theme.of(context).textTheme.headline3,
                                textAlign: TextAlign.left),
                          ],
                        ),
                      )),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      widget.productDetailProvider.products
                                              .bulkCost2
                                              .toString() +
                                          " " +
                                          widget.productDetailProvider
                                              .priceType,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4,
                                      textAlign: TextAlign.left),
                                ],
                              )))
                    ],
                  ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 12,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("DİZAYN TİPİ",style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50])),
                        widget.requestType!=OtherOptionsType.availableOptions?

                        InkWell(
                            onTap: (){
                              Navigator.of(context).pop(popPage.DesignTypesPage);

                            },
                            child: Text("DÜZENLE",style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 12,color: AppTheme.collectionPageColor[50]),)):Container()
                      ],
                    ),
                  ),

                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        widget.productDetailProvider.products.designTypes.length, (index) {
                      return Column(children:List.generate(widget.productDetailProvider.products.designTypes[index].options.length, (index2)
                      {
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: index % 2 == 1
                                  ? AppTheme.softGrey[50]
                                  : AppTheme.middleGrey[50],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 10, top: 10),
                                    child: Text(
                                        widget.productDetailProvider.products.designTypes[index].options[index2].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black54, fontSize: 16),
                                        textAlign: TextAlign.center),
                                  ),

                                ],
                              ),
                            ),


                          ],
                        );

                      }));
                    }),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                      widget.productDetailProvider.option.length, (index) {
                    return widget.productDetailProvider.option[index]
                                .selected ==
                            true
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: index % 2 == 1
                                    ? AppTheme.softGrey[50]
                                    : AppTheme.middleGrey[50],
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 10, top: 10),
                                      child: Text(
                                          widget.productDetailProvider.option[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 16),
                                          textAlign: TextAlign.center),
                                    ),

                                  ],
                                ),
                              )
                            ],
                          )
                        : Container();
                  }),
                )
              ]),
              SizedBox(width: 100,height: 20,),
              widget.requestType!=OtherOptionsType.availableOptions?
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ÖZELLİKLER",style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),),


                        InkWell(
                            onTap: (){
                              Navigator.of(context).pop(popPage.OptionPage);

                            },
                            child: Text("DÜZENLE",style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 12,color: AppTheme.collectionPageColor[50]),))
                      ],
                    ),
                  ),

                  Column(
                    children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        widget.productDetailProvider.personalizeOptions.length,
                            (index1) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: index1 % 2 == 1
                                    ? AppTheme.softGrey[50]
                                    : AppTheme.middleGrey[50],
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 10, top: 10),
                                      child: Text(
                                          widget.productDetailProvider.personalizeOptions[index1].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 16),
                                          textAlign: TextAlign.center),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Wrap(
                                            children:List.generate(widget.productDetailProvider
                                  .personalizeOptions[index1].options.length,(index){
                             return widget.productDetailProvider.personalizeOptions[index1].options[index].selected==true?
                             Text("  "+  widget.productDetailProvider.personalizeOptions[index1].options[index].name+", ",style: TextStyle(fontSize: 9,color: AppTheme.aqua[50]),)
                              :Container();
                                            })


                                        ),
                                      ),
                                    ),



                                  ],
                                ),
                              ),

                            ],
                          );
                        },
                      ),
                    ),
                  ],),


                ],
              ):Container(),
              SizedBox(width: 100,height: 20,),
              widget.requestType!=OtherOptionsType.availableOptions?
              ///OTHEROPTİONS
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("EK ÖZELLİKLER",style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),),


                        InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, AppRoutes.otheroptions).then((value) {
                                setState(() {

                                });
                              });

                            },
                            child: Text("DÜZENLE",style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 12,color: AppTheme.collectionPageColor[50]),))
                      ],
                    ),
                  ),
                  widget.productDetailProvider.otherOptionGroups!=null?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.productDetailProvider.otherOptionGroups.length,
                          (index1) {
                        return
                          widget.productDetailProvider.otherOptionGroups[index1].changed==true?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: index1 % 2 == 1
                                    ? AppTheme.softGrey[50]
                                    : AppTheme.middleGrey[50],
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 10, top: 10),
                                      child: Text(
                                          widget.productDetailProvider.otherOptionGroups[index1].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 16),
                                          textAlign: TextAlign.center),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Wrap(
                                            children:List.generate(widget.productDetailProvider
                                                .otherOptionGroups[index1].options.length,(index){
                                              return widget.productDetailProvider.otherOptionGroups[index1].options[index].selected==true?
                                              Text("  "+  widget.productDetailProvider.otherOptionGroups[index1].options[index].name+", ",style: TextStyle(fontSize: 9,color: AppTheme.aqua[50]),)
                                                  :Container();
                                            })


                                        ),
                                      ),
                                    ),



                                  ],
                                ),
                              ),

                            ],
                          ):Container();
                      },
                    ),
                  ):Container()
                ],
              ):Container(),

              widget.requestType==OtherOptionsType.availableOptions?

              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("SEÇENEKLER",style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),),

                        InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(AppRoutes.availableoptions);

                            },
                            child: Text("DÜZENLE",style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 12,color: AppTheme.collectionPageColor[50]),))
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      widget.productDetailProvider.availableSpects!=null?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          widget.productDetailProvider.availableSpects.length,
                              (index1) {
                            return
                              widget.productDetailProvider.availableSpects[index1].changed==true?
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: index1 % 2 == 1
                                      ? AppTheme.softGrey[50]
                                      : AppTheme.middleGrey[50],
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10, top: 10),
                                        child: Text(
                                            widget.productDetailProvider.personalizeOptions[index1].name,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black54, fontSize: 16),
                                            textAlign: TextAlign.center),
                                      ),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: List.generate(widget.productDetailProvider.spectListRequest.length,(i){
                                                  return     Wrap(
                                                      children:List.generate(widget.productDetailProvider
                                                          .availableSpects[index1].options.length,(index){
                                                        return widget.productDetailProvider.spectListRequest[i].id==widget.productDetailProvider.availableSpects[index1].options[index].id?
                                                        Text("  "+  widget.productDetailProvider.availableSpects[index1].options[index].name+", ",style: TextStyle(fontSize: 9,color:Colors.grey),)
                                                            :Container();
                                                      })


                                                  );

                                                }),

                                              ),
                                            ),
                                            Container(
                                              child: Wrap(
                                                  children:List.generate(widget.productDetailProvider
                                                      .availableSpects[index1].options.length,(index){
                                                    return widget.productDetailProvider.availableSpects[index1].options[index].selected==true?
                                                    Text("  "+  widget.productDetailProvider.availableSpects[index1].options[index].name+", ",style: TextStyle(fontSize: 9,color: AppTheme.aqua[50]),)
                                                        :Container();
                                                  })


                                              ),
                                            ),

                                          ],
                                        ),
                                      ),



                                    ],
                                  ),
                                ),

                              ],
                            ):Container();
                          },
                        ),
                      ):Container(),
                      ///OTHEROPTİONS
                      widget.productDetailProvider.availableOtherOptions!=null?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          widget.productDetailProvider.availableOtherOptions.length,
                              (index1) {
                            return
                              widget.productDetailProvider.availableOtherOptions[index1].changed==true?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    color: index1 % 2 == 1
                                        ? AppTheme.softGrey[50]
                                        : AppTheme.middleGrey[50],
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 10, top: 10),
                                          child: Text(
                                              widget.productDetailProvider.availableOtherOptions[index1].name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black54, fontSize: 16),
                                              textAlign: TextAlign.center),
                                        ),
                                        Container(
                                          child: Column(
                                            children: List.generate(widget.productDetailProvider.spectListRequest.length,(i){
                                              return     Wrap(
                                                  children:List.generate(widget.productDetailProvider
                                                      .availableOtherOptions[index1].options.length,(index){
                                                    return widget.productDetailProvider.spectListRequest[i].id==widget.productDetailProvider.availableOtherOptions[index1].options[index].id?
                                                    Text("  "+  widget.productDetailProvider.availableOtherOptions[index1].options[index].name+", ",style: TextStyle(fontSize: 9,color: Colors.grey),)
                                                        :Container();
                                                  })


                                              );

                                            }),

                                          ),
                                        ),

                                        Expanded(
                                          child: Container(
                                            child: Wrap(
                                                children:List.generate(widget.productDetailProvider
                                                    .availableOtherOptions[index1].options.length,(index){
                                                  return widget.productDetailProvider.availableOtherOptions[index1].options[index].selected==true?
                                                  Text("  "+  widget.productDetailProvider.availableOtherOptions[index1].options[index].name+", ",style: TextStyle(fontSize: 9,color: AppTheme.aqua[50]),)
                                                      :Container();
                                                })


                                            ),
                                          ),
                                        ),



                                      ],
                                    ),
                                  ),

                                ],
                              ):Container();
                          },
                        ),
                      ):Container()
                    ],),


                ],
              ):Container()

            ],
          )
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CupertinoActivityIndicator(),
          );
  }
}
