import 'package:flutter/cupertino.dart';
import 'package:gbjatolye/features/domain/entities/designTpyes/spect_list_dtos.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/info_dialog.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/sizeListdialog.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:showcaseview/showcaseview.dart';

class ProductDetailWidget extends StatefulWidget {
  final ProductDetailProvider productDetailProvider;
  final useCases;
  final int likeCount;
  final OtherOptionsType requestType;

  ProductDetailWidget(
      {Key key,
      @required this.productDetailProvider,
      @required this.useCases,
        this.likeCount,this.requestType})
      : super(key: key);

  @override
  _ProductDetailWidgetState createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    }


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

        Showcase(
          key: widget.productDetailProvider.productDetailsShowcaseKey,
          description: AppLocalizations.of(context).txtShowcaseProductDetails,
          animationDuration: Duration(seconds: 2),
          descTextStyle: Theme.of(context).textTheme.headline4,
          child: _content(context),
        ),
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
                    String fullUrl =widget.productDetailProvider.photoUrl;

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
          padding: EdgeInsets.all(0),
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
              Column(children: [
                ///Select Product Type
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(AppLocalizations.of(context).txtLblProductType,
                              style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                              textAlign: TextAlign.left),
                        )),
                    Expanded(
                        child: InkWell(
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
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: Image.asset(
                                      'images/ic_detail_edit.png',
                                      fit: BoxFit.contain,
                                      height: 20.0,
                                      width: 20.0,
                                    ),
                                  )
                                ],
                              )),
                          onTap: () async {
                              if (widget.likeCount> 0&&widget.productDetailProvider.products.productStatus == "Requested")
                            widget.productDetailProvider.showProductTypeDialog();
                                else {
                                 widget.productDetailProvider.showGotItDialog();
                                   }

                          },
                        ))
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
                                style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
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

                ///size list
                widget.productDetailProvider.products.sizeList.length==0?
                Container():Column(
                  children:List.generate(widget.productDetailProvider.products.sizeList.length, (index) {
                    return Row(
                      children: <Widget>[
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      widget.productDetailProvider.products.sizeList[index].name,
                                      style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
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
                            child: InkWell(
                              child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                          widget.productDetailProvider.checkdSizeListSelectedName(index)!=null?widget.productDetailProvider.checkdSizeListSelectedName(index):"Seçiniz",
                                          style: Theme.of(context).textTheme.headline4,
                                          textAlign: TextAlign.left),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                        child: Image.asset(
                                          'images/ic_detail_edit.png',
                                          fit: BoxFit.contain,
                                          height: 20.0,
                                        ),
                                      )
                                    ],
                                  )),
                              onTap: () async {
                                if (widget.likeCount>0&&widget.productDetailProvider.products.productStatus=="Requested"){

                                  await showDialog<int>(
                                    context: context,
                                    barrierDismissible: true,
                                    // dialog is dismissible with a tap on the barrier
                                    builder: (BuildContext context) {

                                      return AsyncSizeListInputDialog(productDetailProvider:widget.productDetailProvider,index: index,);

                                    },
                                  ).then((value) {

                                    setState(() {

                                    });

                                  });

                                }


                                else {
                                  widget.productDetailProvider.showGotItDialog();
                                }
                              },
                            ))
                      ],
                    );
                  }),
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
                                  widget.productDetailProvider.products.mixQuantity>=1
                                      ? AppLocalizations.of(context)
                                      .txtLblPackageWeight
                                      : AppLocalizations.of(context).txtLblWeight,
                                  style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
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
                        child: InkWell(
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
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: Image.asset(
                                      'images/ic_detail_edit.png',
                                      fit: BoxFit.contain,
                                      height: 20.0,
                                    ),
                                  )
                                ],
                              )),
                          onTap: () async {
                               if (widget.likeCount>0&&widget.productDetailProvider.products.productStatus=="Requested")
                            widget.productDetailProvider.showWeightDialog();
                             else {
                             widget.productDetailProvider.showGotItDialog();
                            }
                          },
                        ))
                  ],
                ),



                ///cost type
                Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                    "Fiyat tipi",
                                    style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                    textAlign: TextAlign.left),

                              ],
                            ),
                          )),
                      SizedBox(height: 2,width: 19,),

                      Expanded(
                          child: InkWell(
                            child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        widget.productDetailProvider.products
                                            .mixQuantity>=1&&widget.productDetailProvider.products.costType==1?
                                        'Paket':
                                        widget.productDetailProvider.products.costType==0?
                                        "Gram":"Adet",
                                        style: Theme.of(context).textTheme.headline4,
                                        textAlign: TextAlign.left),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                      child: Image.asset(
                                        'images/ic_detail_edit.png',
                                        fit: BoxFit.contain,
                                        height: 20.0,
                                      ),
                                    )
                                  ],
                                )),
                            onTap: () async {
                              if (widget.likeCount >  0&&widget.productDetailProvider.products.productStatus=="Requested"){
                                if( widget.productDetailProvider.products
                                    .mixQuantity>=1){
                                  widget.productDetailProvider.showCostTypeDialog(radioText1: 'Gram',radioText2: 'Paket');

                                }else{
                                  widget.productDetailProvider.showCostTypeDialog(radioText1: 'Gram',radioText2: 'Adet');

                                }

                              }
                              else {
                                widget.productDetailProvider.showGotItDialog();
                              }
                            },
                          ))
                    ]
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
                                      .mixQuantity>=1&&widget.productDetailProvider.products.costType==1?
                                      'Paket fiyat':
                                  widget.productDetailProvider.products.costType==0?
                                  "Gram Fiyat":"Adet Fiyat",
                                  style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                  textAlign: TextAlign.left),
                              /*
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

                               */
                            ],
                          ),
                        )),
                    Expanded(
                        child: InkWell(
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
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: Image.asset(
                                      'images/ic_detail_edit.png',
                                      fit: BoxFit.contain,
                                      height: 20.0,
                                    ),
                                  )
                                ],
                              )),
                          onTap: () async {
                            if (widget.likeCount >  0)
                              widget.productDetailProvider.showPriceDialog();
                            else {
                              widget.productDetailProvider.showGotItDialog();
                            }
                          },
                        ))
                  ],
                ),

                ///Minimum Satış Adedi
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text("Minimum Satış Adeti",
                                  style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        )),
                    Expanded(
                        child: InkWell(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      widget.productDetailProvider.products
                                          .minimumOrderQuantity
                                          .toString() +
                                          " "
                                      ,style: Theme.of(context).textTheme.headline4,
                                      textAlign: TextAlign.left),
                                  Text(
                                   widget.productDetailProvider.products.mixQuantity<1?"Adet":"Paket"
                                      ,style: Theme.of(context).textTheme.headline4,
                                      textAlign: TextAlign.left),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: Image.asset(
                                      'images/ic_detail_edit.png',
                                      fit: BoxFit.contain,
                                      height: 20.0,
                                    ),
                                  )
                                ],
                              )),
                          onTap: () async {
                               if (widget.likeCount > 0&&widget.productDetailProvider.products.productStatus=="Requested")
                            widget.productDetailProvider
                                .showMinimumOrderQuentityDialog();
                             else {
                            widget.productDetailProvider.showGotItDialog();
                            }
                          },
                        ))
                  ],
                ),



                Visibility(
                  visible: widget.productDetailProvider.totalCostVisible,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("Toplam Fiyat",
                                style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                textAlign: TextAlign.left),
                          )),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                        widget.productDetailProvider.products.costType==0?
                                        widget.productDetailProvider.gramTotalCost().toStringAsFixed(2)+" ${widget.productDetailProvider.priceType}": widget.productDetailProvider.adetTotalCost().toStringAsFixed(2)+" ${widget.productDetailProvider.priceType}",
                                        style: Theme.of(context).textTheme.headline4,
                                        textAlign: TextAlign.left),
                                  ),

                                ],
                              )))
                    ],
                  ),
                ),

                Divider(),


                ///Çoklu Satış Switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:6.0),
                      child: Row(
                        children: [
                          Text("Toplu Satış",
                              style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                              textAlign: TextAlign.left),
                          Padding(
                            padding: const EdgeInsets.only(left:4.0),
                            child: InkWell(
                                onTap: (){
                                  asyncInfoDialog(context: context);
                                },
                                child: Icon(Icons.info)),
                          ),

                        ],
                      ),
                    ),
                    Switch(

                      activeColor: AppTheme.aqua[50],
                      value: widget.productDetailProvider.satisCoklu,
                      onChanged: (s) {
                          widget.productDetailProvider.satisCoklu = s;
                          print(widget.productDetailProvider.satisCoklu);
                          if(widget.productDetailProvider.satisCoklu==false) {
                            widget.productDetailProvider.products.bulkCost=0;
                            widget.productDetailProvider.products.bulkCost2=0;
                            widget.productDetailProvider.products.bulkQuantity2=0;
                            widget.productDetailProvider.products.bulkQuantity=0;
                          }else if(widget.productDetailProvider.satisCoklu==true&&widget.productDetailProvider.products.bulkCost==0){
                            widget.productDetailProvider.products.bulkCost=0;
                            widget.productDetailProvider.products.bulkCost2=0;
                            widget.productDetailProvider.products.bulkQuantity2=20;
                            widget.productDetailProvider.products.bulkQuantity=5;

                          }
                      },
                    ),
                  ],
                ),

                Visibility(
                  visible: widget.productDetailProvider.satisCoklu,
                  child: Column(
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
                                        style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              )),
                          Expanded(
                              child: InkWell(
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
                                            style: Theme.of(context).textTheme.headline4,
                                            textAlign: TextAlign.left),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: 10.0, right: 10.0),
                                          child: Image.asset(
                                            'images/ic_detail_edit.png',
                                            fit: BoxFit.contain,
                                            height: 20.0,
                                          ),
                                        )
                                      ],
                                    )),
                                onTap: () async {
                                     if (widget.likeCount >  0&&widget.productDetailProvider.products.productStatus=="Requested")
                                  widget.productDetailProvider.showBulkQuentityDialog();
                                   else {
                                   widget.productDetailProvider.showGotItDialog();
                                  }
                                },
                              ))
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
                                        style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              )),
                          Expanded(
                              child: InkWell(
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                            widget.productDetailProvider.products
                                                .bulkCost
                                                .toString() +
                                                " " +
                                                widget.productDetailProvider.priceType,
                                            style: Theme.of(context).textTheme.headline4,
                                            textAlign: TextAlign.left),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: 10.0, right: 10.0),
                                          child: Image.asset(
                                            'images/ic_detail_edit.png',
                                            fit: BoxFit.contain,
                                            height: 20.0,
                                          ),
                                        )
                                      ],
                                    )),
                                onTap: () async {
                                   if (widget.likeCount >  0&&widget.productDetailProvider.products.productStatus=="Requested")
                                  widget.productDetailProvider.showBulkCostDialog();
                                    else {
                                    widget.productDetailProvider.showGotItDialog();
                                     }
                                },
                              ))
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
                                        style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              )),
                          Expanded(
                              child: InkWell(
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
                                            style: Theme.of(context).textTheme.headline4,
                                            textAlign: TextAlign.left),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: 10.0, right: 10.0),
                                          child: Image.asset(
                                            'images/ic_detail_edit.png',
                                            fit: BoxFit.contain,
                                            height: 20.0,
                                          ),
                                        )
                                      ],
                                    )),
                                onTap: () async {
                                    if (widget.likeCount > 0&&widget.productDetailProvider.products.productStatus=="Requested")
                                  widget.productDetailProvider
                                      .showBulkQuentity2Dialog();
                                   else {
                                   widget.productDetailProvider.showGotItDialog();
                                  }
                                },
                              ))
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
                                        style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                        textAlign: TextAlign.left),
                                  ],
                                ),
                              )),
                          Expanded(
                              child: InkWell(
                                child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                            widget.productDetailProvider.products
                                                .bulkCost2
                                                .toString() +
                                                " " +
                                                widget.productDetailProvider.priceType,
                                            style: Theme.of(context).textTheme.headline4,
                                            textAlign: TextAlign.left),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: 10.0, right: 10.0),
                                          child: Image.asset(
                                            'images/ic_detail_edit.png',
                                            fit: BoxFit.contain,
                                            height: 20.0,
                                          ),
                                        )
                                      ],
                                    )),
                                onTap: () async {
                                     if (widget.likeCount>  0&&widget.productDetailProvider.products.productStatus=="Requested")
                                  widget.productDetailProvider.showBulkCost2Dialog();
                                   else {
                                   widget.productDetailProvider.showGotItDialog();
                                    }
                                },
                              ))
                        ],
                      ),
                    ],
                  ),
                ),


                Divider(),

              ],),







              SizedBox(height: 12,),
              Visibility(
                visible:widget.productDetailProvider.designTypeOption.length==0?false:true ,
                child: Column(
                  children: [
                    Row(
                      children:[     Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text("Dizayn Tipi",
                                    style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          )),
                      ]

                    ),
                    Row(
                      children: <Widget>[
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[Column(
                                children: List.generate(widget.productDetailProvider.optionLoading==false?
                                widget.productDetailProvider.designTypeOption!=null?widget.productDetailProvider.designTypeOption.length:0:0
                                    , (index) {

                              return      Container(
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
                                                widget.productDetailProvider.designTypeOption[index].name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black54, fontSize: 16),
                                                textAlign: TextAlign.center),
                                          ),



                                        ],
                                      ),
                                    );

                                    Text(widget.productDetailProvider.designTypeOption[index].name,
                                      style: Theme.of(context).textTheme.headline3,
                                    );
                                  },)
                              )]
                          ),
                      )
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
              SizedBox(height: 12,),
              Visibility(
                visible:widget.productDetailProvider.products.spectListDtos.length==0?false:true ,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text("Özellik",
                                        style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                        textAlign: TextAlign.left),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(widget.productDetailProvider.products.spectListDtos.length, (index)
                                  {
                                    return Column(
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
                                                    widget.productDetailProvider.products.spectListDtos[index].name,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black54, fontSize: 16),
                                                    textAlign: TextAlign.center),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Row(
                                                      children:List.generate(widget.productDetailProvider.products.spectListDtos[index].options.length,(index2){
                                                      return        Text("  "+  widget.productDetailProvider.products.spectListDtos[index].options[index2].name+", ",style: TextStyle(fontSize: 9,color: AppTheme.aqua[50]),);


                                                      })



                                                  ),
                                                ),
                                              ),



                                            ],
                                          ),
                                        ),



                                      ],
                                    );


                                  }),),
                                )


                              ],
                            ),
                            Divider()
                          ],
                        )),
                  ],
                ),
              ),

              SizedBox(height: 12,),
              Visibility(
                visible:widget.productDetailProvider.products.optionList.length==0?false:true ,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text("Seçenekler",
                                        style: Theme.of(context).textTheme.headline3.copyWith(color: AppTheme.collectionPageColor[50]),
                                        textAlign: TextAlign.left),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(widget.productDetailProvider.products.optionList.length, (index)
                                    {
                                      return Column(
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
                                                      widget.productDetailProvider.products.optionList[index].name,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black54, fontSize: 16),
                                                      textAlign: TextAlign.center),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Wrap(
                                                        children:List.generate(widget.productDetailProvider.products.optionList[index].options.length,(index2){
                                                          return        Text("  "+  widget.productDetailProvider.products.optionList[index].options[index2].name+", ",style: TextStyle(fontSize: 9,color: AppTheme.aqua[50]),);


                                                        })



                                                    ),
                                                  ),
                                                ),



                                              ],
                                            ),
                                          ),



                                        ],
                                      );


                                    }),),
                                )


                              ],
                            ),
                            Divider()
                          ],
                        )),
                  ],
                ),
              ),







            ],
          )
        : Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CupertinoActivityIndicator(),
          );
  }


}

/*
class _ProductDetailWidgetState extends State<ProductDetailWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        /// Photo Gallery and dots
        _photoGalleryAndDots(),

        /// Other Contents
        _content(context)
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
                          AppTheme.darkTangerine[50]),
                    ),
                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    String fullUrl =
                        widget.productDetailProvider.product.imagelist.first +
                            "20.jpg";
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
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(bottom: 10.0),
        shrinkWrap: false,
        children: <Widget>[
          ///Select Product Type
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context).txtLblProductType,
                    style: Theme.of(context).textTheme.display2,
                    textAlign: TextAlign.left),
              )),
              Expanded(
                  child: InkWell(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                            !widget.productDetailProvider.product.ispackage
                                ? AppLocalizations.of(context)
                                    .txtLblSingleProduct
                                : AppLocalizations.of(context)
                                    .txtLblPackageProduct,
                            style: Theme.of(context).textTheme.display1,
                            textAlign: TextAlign.left),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Image.asset(
                            'images/ic_detail_edit.png',
                            fit: BoxFit.contain,
                            height: 20.0,
                            width: 20.0,
                          ),
                        )
                      ],
                    )),
                onTap: () async {
                  if (widget.productDetailProvider.product.likecount > 0)
                    widget.productDetailProvider.showProductTypeDialog();
                  else {
                    widget.productDetailProvider.showGotItDialog();
                  }
                },
              ))
            ],
          ),

          ///Package Count
          Visibility(
            visible:
                widget.productDetailProvider.product.ispackage ? true : false,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(AppLocalizations.of(context).txtLblPackageCount,
                      style: Theme.of(context).textTheme.display2,
                      textAlign: TextAlign.left),
                )),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                              widget.productDetailProvider.product
                                      .packagequantity
                                      .toString() +
                                  " " +
                                  AppLocalizations.of(context)
                                      .txtLblPackagePiece +
                                  " " +
                                  widget.productDetailProvider.product.title,
                              style: Theme.of(context).textTheme.display1,
                              textAlign: TextAlign.left),
                        ],
                      )),
                )
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
                        widget.productDetailProvider.product.ispackage
                            ? AppLocalizations.of(context).txtLblPackageWeight
                            : AppLocalizations.of(context).txtLblWeight,
                        style: Theme.of(context).textTheme.display2,
                        textAlign: TextAlign.left),
                    Visibility(
                      visible: widget.productDetailProvider.product != null &&
                              widget.productDetailProvider.product.weight > 0.0
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
                  child: InkWell(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                            widget.productDetailProvider.product.weight
                                    .toString() +
                                " " +
                                AppLocalizations.of(context).txtLblWeightUnit,
                            style: Theme.of(context).textTheme.display1,
                            textAlign: TextAlign.left),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Image.asset(
                            'images/ic_detail_edit.png',
                            fit: BoxFit.contain,
                            height: 20.0,
                          ),
                        )
                      ],
                    )),
                onTap: () async {
                  if (widget.productDetailProvider.product.likecount > 0)
                    widget.productDetailProvider.showWeightDialog();
                  else {
                    widget.productDetailProvider.showGotItDialog();
                  }
                },
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
                        widget.productDetailProvider.product != null &&
                                widget.productDetailProvider.product.ispackage
                            ? AppLocalizations.of(context).txtLblPackagePrice
                            : AppLocalizations.of(context).txtLblPiecePrice,
                        style: Theme.of(context).textTheme.display2,
                        textAlign: TextAlign.left),
                    Visibility(
                      visible: widget.productDetailProvider.product != null &&
                              widget.productDetailProvider.product.totalcost >
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
                  child: InkWell(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                            widget.productDetailProvider.product.totalcost
                                    .toString() +
                                " " +
                                widget.productDetailProvider.priceType,
                            style: Theme.of(context).textTheme.display1,
                            textAlign: TextAlign.left),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Image.asset(
                            'images/ic_detail_edit.png',
                            fit: BoxFit.contain,
                            height: 20.0,
                          ),
                        )
                      ],
                    )),
                onTap: () async {
                  if (widget.productDetailProvider.product.likecount > 0)
                    widget.productDetailProvider.showPriceDialog();
                  else {
                    widget.productDetailProvider.showGotItDialog();
                  }
                },
              ))
            ],
          ),

          ///Select Product Options
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Text(AppLocalizations.of(context).txtLblOptions,
                        style: Theme.of(context).textTheme.display2,
                        textAlign: TextAlign.left),
                    Visibility(
                      visible: widget.productDetailProvider.product != null &&
                              widget.productDetailProvider
                                      .getSelectedOptions()
                                      .length >
                                  0
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
              Flexible(
                  child: InkWell(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      widget.productDetailProvider.options == ""
                          ? AppLocalizations.of(context).txtLblChooseOption
                          : widget.productDetailProvider.options,
                      style: Theme.of(context).textTheme.display1,
                    )),
                onTap: () async {
                  if (widget.productDetailProvider.product.likecount > 0) {
                    bool response = await asyncOptionDialog(
                        context: context,
                        sizelist: widget.productDetailProvider.product.sizes);

                    if (response != null && response) {
                      widget.productDetailProvider.product.sizes.first
                          .isdefault = false;
                      widget.productDetailProvider.setOptions();
                    }
                  } else {
                    widget.productDetailProvider.showGotItDialog();
                  }
                },
              ))
            ],
          ),

          ///Select Product Specs
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context).txtLblSpecs,
                    style: Theme.of(context).textTheme.display2,
                    textAlign: TextAlign.left),
              )),
              Flexible(
                  child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    widget.productDetailProvider.specs == ""
                        ? AppLocalizations.of(context).txtLblChooseSpecs
                        : widget.productDetailProvider.specs,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
                onTap: () async {
                  if (widget.productDetailProvider.product.likecount > 0) {
                    await asyncSpecsDialog(
                        context: context,
                        specslist: widget
                            .productDetailProvider.product.specifications);
                    widget.productDetailProvider.setSpecs();
                  } else {
                    widget.productDetailProvider.showGotItDialog();
                  }
                },
              ))
            ],
          ),
        ],
      ),
    );
  }
}
*/
/*
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                            widget.productDetailProvider.products.productType>1
                                ? AppLocalizations.of(context).txtLblPackageWeight
                                : AppLocalizations.of(context).txtLblWeight,
                            style: Theme.of(context).textTheme.display2,
                            textAlign: TextAlign.left),
                        Visibility(
                          visible: widget.productDetailProvider.products != null &&
                              widget.productDetailProvider.products.weight > 0.0
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
                  child: InkWell(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                                widget.productDetailProvider.products.weight
                                    .toString() +
                                    " " +
                                    AppLocalizations.of(context).txtLblWeightUnit,
                                style: Theme.of(context).textTheme.display1,
                                textAlign: TextAlign.left),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Image.asset(
                                'images/ic_detail_edit.png',
                                fit: BoxFit.contain,
                                height: 20.0,
                              ),
                            )
                          ],
                        )),
                    onTap: () async {
                      //   if (widget.productDetailProvider.product.likecount > 0)
                      widget.productDetailProvider.showWeightDialog();
                      // else {
                      // widget.productDetailProvider.showGotItDialog();
                      //}
                    },
                  ))
            ],
          ),

          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                            widget.productDetailProvider.products.productType>1
                                ? AppLocalizations.of(context).txtLblPackageWeight
                                : AppLocalizations.of(context).txtLblWeight,
                            style: Theme.of(context).textTheme.display2,
                            textAlign: TextAlign.left),
                        Visibility(
                          visible: widget.productDetailProvider.products != null &&
                              widget.productDetailProvider.products.weight > 0.0
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
                  child: InkWell(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                                widget.productDetailProvider.products.weight
                                    .toString() +
                                    " " +
                                    AppLocalizations.of(context).txtLblWeightUnit,
                                style: Theme.of(context).textTheme.display1,
                                textAlign: TextAlign.left),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Image.asset(
                                'images/ic_detail_edit.png',
                                fit: BoxFit.contain,
                                height: 20.0,
                              ),
                            )
                          ],
                        )),
                    onTap: () async {
                      //   if (widget.productDetailProvider.product.likecount > 0)
                      widget.productDetailProvider.showWeightDialog();
                      // else {
                      // widget.productDetailProvider.showGotItDialog();
                      //}
                    },
                  ))
            ],
          ),


*/
/*
          ///Package Count
          Visibility(
            visible:
                widget.productDetailProvider.product.ispackage ? true : false,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(AppLocalizations.of(context).txtLblPackageCount,
                      style: Theme.of(context).textTheme.display2,
                      textAlign: TextAlign.left),
                )),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                              widget.productDetailProvider.product
                                      .packagequantity
                                      .toString() +
                                  " " +
                                  AppLocalizations.of(context)
                                      .txtLblPackagePiece +
                                  " " +
                                  widget.productDetailProvider.product.title,
                              style: Theme.of(context).textTheme.display1,
                              textAlign: TextAlign.left),
                        ],
                      )),
                )
              ],
            ),
          ),



          ///Select Product Options
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Text(AppLocalizations.of(context).txtLblOptions,
                        style: Theme.of(context).textTheme.display2,
                        textAlign: TextAlign.left),
                    Visibility(
                      visible: widget.productDetailProvider.product != null &&
                              widget.productDetailProvider
                                      .getSelectedOptions()
                                      .length >
                                  0
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
              Flexible(
                  child: InkWell(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      widget.productDetailProvider.options == ""
                          ? AppLocalizations.of(context).txtLblChooseOption
                          : widget.productDetailProvider.options,
                      style: Theme.of(context).textTheme.display1,
                    )),
                onTap: () async {
                  if (widget.productDetailProvider.product.likecount > 0) {
                    bool response = await asyncOptionDialog(
                        context: context,
                        sizelist: widget.productDetailProvider.product.sizes);

                    if (response != null && response) {
                      widget.productDetailProvider.product.sizes.first
                          .isdefault = false;
                      widget.productDetailProvider.setOptions();
                    }
                  } else {
                    widget.productDetailProvider.showGotItDialog();
                  }
                },
              ))
            ],
          ),

          ///Select Product Specs
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(AppLocalizations.of(context).txtLblSpecs,
                    style: Theme.of(context).textTheme.display2,
                    textAlign: TextAlign.left),
              )),
              Flexible(
                  child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    widget.productDetailProvider.specs == ""
                        ? AppLocalizations.of(context).txtLblChooseSpecs
                        : widget.productDetailProvider.specs,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
                onTap: () async {
                  if (widget.productDetailProvider.product.likecount > 0) {
                    await asyncSpecsDialog(
                        context: context,
                        specslist: widget
                            .productDetailProvider.product.specifications);
                    widget.productDetailProvider.setSpecs();
                  } else {
                    widget.productDetailProvider.showGotItDialog();
                  }
                },
              ))
            ],
          ),*/




class AsyncSizeListInputDialog extends StatefulWidget {
  final ProductDetailProvider productDetailProvider;
  final int index;
  BuildContext context;
  AsyncSizeListInputDialog({this.productDetailProvider,this.index});

  @override
  _AsyncSizeListInputDialogState createState() => _AsyncSizeListInputDialogState();
}
class _AsyncSizeListInputDialogState extends State<AsyncSizeListInputDialog> {
ProductDetailProvider productDetailProvider;

  int selected=-1;

  changedValue(val) {
    setState(() {
      selected = val;
    });

  }

  @override
  void initState() {
    productDetailProvider=widget.productDetailProvider;


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        backgroundColor: AppTheme.white[50],
        title: Text(productDetailProvider.products.sizeList[widget.index].name,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(

            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child:
                Column(
                  children: List.generate(
                      productDetailProvider.products.sizeList[widget.index].options.length, (index) {



                    if(productDetailProvider.products.sizeList[widget.index].options[index].selected == true) {
                        selected = index;
                        productDetailProvider.products.sizeList[widget.index].options[index].selected =false;

                    }

                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {

                                selected=index;

                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(productDetailProvider.products.sizeList[widget.index].options[index].name),
                                ),
                                Radio(
                                    activeColor: AppTheme.bigStone[50],
                                    value: index,
                                    groupValue: selected,
                                    onChanged: (value) {
                                        changedValue(value);
                                        print(selected);

                                    })

                              ],
                            ),
                          ),
                          Divider()
                        ],
                      ),
                    );
                  },
                  ),
                ),
                ),
              ),

              ///Button
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: InkWell(
                          child: Container(
                            height: 50,
                            decoration: new BoxDecoration(
                                color: Colors.grey,
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(50.0),
                                  bottomRight: const Radius.circular(0),
                                )),
                            child: Center(
                              child: Text("KALDIR",
                                  style: Theme.of(context).textTheme.button,
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          onTap: () {
                              productDetailProvider.products.sizeList[widget.index].options[selected].selected = false;
                              productDetailProvider.selectSizeList=false;
                              Navigator.of(context).pop();



                          },
                        )),
                    SizedBox(width: 2,),
                    Expanded(
                        child: InkWell(
                            child: Container(
                              height: 50,
                              decoration: new BoxDecoration(
                                  gradient: LinearGradient(colors: <Color>[
                                    AppTheme.aqua[50],
                                    AppTheme.azureRadiance[50],
                                  ]),
                                  borderRadius: new BorderRadius.only(
                                    bottomLeft: const Radius.circular(0),
                                    bottomRight: const Radius.circular(50.0),
                                  )),
                              child: Center(
                                child: Text(AppLocalizations.of(context).txtBtnSave,
                                    style: Theme.of(context).textTheme.button,
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            onTap: () {
                                productDetailProvider.products.sizeList[widget.index].options[selected].selected = true;
                                productDetailProvider.selectSizeList=true;

                                Navigator.of(context).pop();

                            }

                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
