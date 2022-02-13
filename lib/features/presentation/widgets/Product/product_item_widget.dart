import 'package:gbjatolye/features/domain/entities/product/arguments.dart';
import 'package:gbjatolye/features/domain/entities/product/productswithlist.dart';
import 'package:gbjatolye/features/presentation/provider/productdetail_provider.dart';
import 'package:gbjatolye/features/presentation/provider/productlist_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductItemWidget extends StatelessWidget {
  final ProductsWithList product;
  final ProductListProvider productListProvider;
  final int subjewelrytypesId;


  const ProductItemWidget({Key key,  this.productListProvider, this.product, this.subjewelrytypesId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(product.variantId);
    return GestureDetector(
        onTap: () async {
          if (!productListProvider.productStatusChangeActive) {
            /*w
            appIntent.intent=PageIntents.ToProductDetailFromProductList;

            appIntent.data=product.blobUrl;
             */

            Provider.of<ProductDetailProvider>(context, listen: false).reProductDetailProvider();
            print("prod.id: "+product.productId.toString()+" : "+subjewelrytypesId.toString());
            Navigator.pushNamed(context, AppRoutes.productdetail,arguments:Arguments(variantId:product.variantId,url:product.blobUrl,jewelerytypesId:subjewelrytypesId,productId:product.productId));
          } else
            productListProvider.changeProductSelectedStatus(product);
        },
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
              padding: productListProvider.productStatusChangeActive &&
                      product.selected
                  ? EdgeInsets.all(2.0)
                  : EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppTheme.aqua[50], AppTheme.azureRadiance[50]]),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 5.0,
                      spreadRadius: -3.0,
                      offset: Offset(0.0, 3.0)),
                ],
              ),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      ShaderMask(
                        child: CachedNetworkImage(
                          imageUrl: product.blobUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                        shaderCallback: (Rect bounds) {
                          if (productListProvider.productStatusChangeActive &&
                              product.selected) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(1),
                                AppTheme.aqua[50]
                              ],
                              stops: [
                                0.3,
                                1,
                              ],
                            ).createShader(bounds);
                          } else {
                            return LinearGradient(
                              colors: [Colors.white.withOpacity(1)],
                              stops: [0.0],
                            ).createShader(bounds);
                          }
                        },
                      ),
                      Visibility(
                        child: new Positioned(
                            top: 0.0,
                            right: 0.0,
                            child: ClipRRect(
                              borderRadius: new BorderRadius.only(
                                  topRight: const Radius.circular(10.0)),
                              child: Image.asset(
                                'images/ic_uncompletedproduct.png',
                                width: 40.0,
                                height: 40.0,
                                fit: BoxFit.contain,
                              ),
                            )),
                        visible:
                                !productListProvider
                                    .productStatusChangeActive &&
                                product.likeCount > 0
                            ? true
                            : false,
                      ),
                      Visibility(
                        visible:
                            !productListProvider.productStatusChangeActive &&
                                product.likeCount > 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 25.0,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    color: AppTheme.white[50],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Image.asset(
                                        'images/ic_like.png',
                                        fit: BoxFit.contain,
                                        height: 15.0,
                                      ),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        margin: EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          product.likeCount.toString() +
                                              " " +
                                              AppLocalizations.of(
                                                      productListProvider
                                                          .context)
                                                  .txtLblLike,
                                          style: TextStyle(
                                              fontSize: 10.0,
                                              fontFamily: 'MontserratSemiBold',
                                              color: AppTheme.riverBed[50]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        child: new Positioned(
                          bottom: 3.0,
                          right: 3.0,
                          child: Container(
                            height: 22.0,
                            child: Image.asset(
                              'images/ic_checked.png',
                              width: 22.0,
                              height: 22.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        visible:
                            productListProvider.productStatusChangeActive &&
                                product.selected,
                      ),
                      Visibility(
                        child: new Positioned(
                          bottom: 3.0,
                          right: 3.0,
                          child: Container(
                            height: 22.0,
                            child: Image.asset(
                              'images/ic_check.png',
                              width: 22.0,
                              height: 22.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        visible:
                            productListProvider.productStatusChangeActive &&
                                !product.selected,
                      ),
                    ],
                  ))),
        ));
  }
}


