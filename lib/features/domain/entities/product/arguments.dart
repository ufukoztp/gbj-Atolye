import 'package:gbjatolye/features/domain/entities/detailPhoto_models.dart';
 import 'package:gbjatolye/features/domain/entities/product/productswithlist.dart';

class ArgumentsWithProvider{
  ArgumentsWithProvider({this.productdata});
  Arguments productdata;
}



class Arguments{
  final int variantId;
  final int jewelerytypesId;
  final String url;
  final int productId;
 // final ProductsWithList product;

  Arguments(
      {this.variantId,
      this.url,
      this.jewelerytypesId,
    //  this.product,
      this.productId});
}


