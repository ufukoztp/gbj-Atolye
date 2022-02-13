import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/provider/productlist_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/product/product_item_widget.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DisableForSaleProductListWidgets extends StatelessWidget {

  final ProductListProvider productListProvider;

  final UseCases useCase;
  final int jeweleryTpesId;
  final String pageKey;

  DisableForSaleProductListWidgets({
    @required this.pageKey,
    @required this.productListProvider,
    @required this.useCase, this.jeweleryTpesId,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        productListProvider.loadDeactive==true?Padding(
          padding: const EdgeInsets.only(left:170.0,top:30),
          child: CupertinoActivityIndicator(),
        ):
        NotificationListener(
          child: GridView.builder(
              controller: productListProvider.disableProductListScrollController,
              key: PageStorageKey(pageKey),
              shrinkWrap: false,
              itemCount: productListProvider.loadDeactive==false?productListProvider.deactiveProducts.length:null,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index){
                 return ProductItemWidget(
                   subjewelrytypesId:jeweleryTpesId,
                    productListProvider: productListProvider,
                    product: productListProvider.deactiveProducts[index],
                  );
/*
                if (index == productListProvider.deactiveProducts.length + 1 &&
                    productListProvider.deactiveProducts.length % 3 == 0 &&
                    productListProvider.deactiveProducts.length >0 &&
                    productListProvider.deactiveCurrentPage >
                        productListProvider.deactivepagecount)
                  return Center(
                    child: Text(
                      "Başka ürün yok.",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: 'GothamBook',
                          color: AppTheme.grey[50]),
                    ),
                  );
                else if (index == productListProvider.deactiveProducts.length + 1 &&  productListProvider.deactiveCurrentPage <=
                    productListProvider.deactivepagecount)
                  return CupertinoActivityIndicator();
                else if (index == productListProvider.deactiveProducts.length || index == productListProvider.deactiveProducts.length + 1)
                  return Visibility(
                    visible: false,
                    child: Text(""),
                  );

               return ProductItemWidget(
                  productListProvider: productListProvider,
                  product: productListProvider.deactiveProducts[index],
                );
*/
              }),
        ),
        Visibility(
          visible:productListProvider.loadDeactive==false? productListProvider.notProduct==true?true:false:false,
                    child: Center(
            child: Text(
           // appIntent.data["titleName"]+" "+AppLocalizations.of(productListProvider.context).txtLblNoProduct,
                appIntent.data["titleName"]+" "+" kategorisine hemen ürün ekleyin",
                style:
                    Theme.of(productListProvider.context).textTheme.headline4),
          ),
        ),
      ],
    );
  }

}
