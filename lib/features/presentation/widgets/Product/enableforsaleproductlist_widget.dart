import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/provider/productlist_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/product/product_item_widget.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnableForSaleProductListWidgets extends StatelessWidget {
  final ProductListProvider productListProvider;

  final UseCases useCase;
  final int jeweleryTpesId;
  final String pageKey;

  EnableForSaleProductListWidgets({
    @required this.pageKey,
    @required this.productListProvider,
    @required this.useCase, this.jeweleryTpesId,
  });

  @override
  Widget build(BuildContext context) {



    return Stack(
      children: <Widget>[
        productListProvider.loadActive==true?Padding(
          padding: const EdgeInsets.only(left:170.0,top:30),
          child: CupertinoActivityIndicator(),
        ):
        NotificationListener(
            child:
                ///yeni kod burası
                GridView.builder(
                    shrinkWrap: false,
                    controller: productListProvider.enableProductListScrollController,
                    key: PageStorageKey(pageKey),
                    ///cross eleman en az 3 item olduğu için +2 dedik 0, 1, 2
                    itemCount: productListProvider.loadActive==false?productListProvider.activeProducts.length:null ,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                        return ProductItemWidget(
                          subjewelrytypesId: jeweleryTpesId,
                         productListProvider: productListProvider,
                          product: productListProvider.activeProducts[index],
                        );
                      /*
                if (index == productListProvider.activeProducts.length + 1 &&
                    productListProvider.activeProducts.length % 3 == 0 &&
                    productListProvider.activeProducts.length >0 &&
                    productListProvider.activeCurrentPage > productListProvider.activepagecount)
                  return Center(
                    child: Text(
                      "Başka ürün yok.",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'GothamBook',
                          color: AppTheme.grey[50]),
                    ),
                  );
                else if (index == productListProvider.activeProducts.length + 1 &&  productListProvider.activeCurrentPage <=
                    productListProvider.activepagecount)
                  return CupertinoActivityIndicator();
                else if (index == productListProvider.activeProducts.length || index == productListProvider.activeProducts.length + 1)
                  return Visibility(
                    visible: false,
                    child: Text(""),
                  );

                return ProductItemWidget(
                  productListProvider: productListProvider,
                  product: productListProvider.activeProducts[index],
                );
              }),*/
                    })),
        Visibility(
          visible:productListProvider.loadActive==false? productListProvider.notProductActive==true?true:false:false,
          child: Center(
            child: Text(
             //   appIntent.data["titleName"]+" "+AppLocalizations.of(productListProvider.context).txtLblNoProduct,
                appIntent.data["titleName"]+" "+" kategorisine hemen ürün ekleyin",

                style:
                    Theme.of(productListProvider.context).textTheme.headline4),
          ),
        ),
      ],
    );
  }
}
