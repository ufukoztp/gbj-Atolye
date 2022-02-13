import 'dart:io';
import 'dart:typed_data';

import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/features/domain/entities/id.dart';
import 'package:gbjatolye/features/domain/entities/order/order.dart';
import 'package:gbjatolye/features/domain/entities/order/orderstatus.dart';
import 'package:gbjatolye/features/domain/entities/order/orderstatusnew.dart';
import 'package:gbjatolye/features/domain/entities/order2/order_response.dart';
import 'package:gbjatolye/features/domain/entities/product/arguments.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/optionsdialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/order/pdf_viewer.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:flutter/services.dart' show NetworkAssetBundle, rootBundle;

abstract class OrderListProviderUseCases {

  /// provides tabs changing
  handleTabSelection();

  /// provides to fetch orders
  Future getOrderList();

  /// provide to fetch waiting orders
  List<OrderList> getWaitingOrderList();

  /// provide to fetch producting orders
  List<OrderList> getProductionOrderList();

  /// provide to fetch ready orders
  List<OrderList> getReadyOrderList();

  /// removes all selected order products and updates and visible true orderstatuschangebutton
  showOrderProductStatusChangeButton();

  /// removes all selected order products and updates and visible true orderstatuschangebutton
  hideOrderProductStatusChangeButton();

  /// provides deselect all order product status
  unSelectAllOrderProductStatus();

  /// provides to change order product selected status
  changeOrderProductSelectedStatus(Products orderProduct);

  /// provides show order product status list
  showOrderProductStatusListPopup();

  /// provides to get selected order products to change status
  List<OrderList> getSelectedAllOrderProducts();

  /// provides to change order product status on server and local list
  changeOrderProductStatus(OptionsDialogButton optionType);

  /// provides to hide no order text and show related order list
  hideNoOrderText();

  /// update product order status counts (ex. waiting 5, production 1 ... )
  updateProductOrderCounts();

  /// set user price type
  setPriceType();

}


class OrderListProvider with ChangeNotifier implements OrderListProviderUseCases {

  BuildContext _context;
  UseCases _useCases;
  TabController _tabbarController;
  int _tabbarCurrentIndex = 0;
  int _waitingCount;
  int _productionCount;
  int _readyCount;
  List<Order> _ordersOld;
  List<OrderList> _order;
  Map imagesList=Map();
  List<OrderList> get order => _order;

  set order(List<OrderList> value) {
    _order = value;
    notifyListeners();
  }

  bool _readyNoProduct;
  bool _productionNoProduct;
  bool _waitingNoProduct;
  bool _isLoading;
  String _priceType;
  String photoURLHead='https://gbjblobnew2.blob.core.windows.net/';

  String get priceType => _priceType;

  bool get isLoading => _isLoading;

  bool get waitingNoProduct => _waitingNoProduct;

  bool get productionNoProduct => _productionNoProduct;

  bool get readyNoProduct => _readyNoProduct;

  int get productionCount => _productionCount;

  int get readyCount => _readyCount;

  bool _orderProductStatusChangeActive;

  bool get orderProductStatusChangeActive => _orderProductStatusChangeActive;

  int get waitingCount => _waitingCount;

  List<Order> get ordersOld => _ordersOld;

  // ignore: unnecessary_getters_setters
  BuildContext get context => _context;

  UseCases get useCases => _useCases;

  TabController get tabbarController => _tabbarController;

  int get tabbarCurrentIndex => _tabbarCurrentIndex;

  set priceType(String value) {
    _priceType = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set productionCount(int value) {
    _productionCount = value;
    notifyListeners();
  }

  set waitingNoProduct(bool value) {
    _waitingNoProduct = value;
    notifyListeners();
  }

  set productionNoProduct(bool value) {
    _productionNoProduct = value;
    notifyListeners();
  }

  set readyNoProduct(bool value) {
    _readyNoProduct = value;
    notifyListeners();
  }

  set readyCount(int value) {
    _readyCount = value;
    notifyListeners();
  }

  set ordersOld(List<Order> value) {
    _ordersOld = value;
    notifyListeners();
  }

  set orderProductStatusChangeActive(bool value) {
    _orderProductStatusChangeActive = value;
    notifyListeners();
  }

  set waitingCount(int value) {
    _waitingCount = value;
  }

  set tabbarController(TabController value) {
    _tabbarController = value;
    notifyListeners();
  }

  // ignore: unnecessary_getters_setters
  set context(BuildContext value) {
    _context = value;
  }

  set tabbarCurrentIndex(int value) {
    _tabbarCurrentIndex = value;
    notifyListeners();
  }

  set useCases(UseCases value) {
    _useCases = value;
    notifyListeners();
  }

  OrderListProvider() {
    order = List<OrderList>();
    orderProductStatusChangeActive = false;
    waitingCount = 0;
    productionCount = 0;
    readyCount=0;
    isLoading=false;
    priceType="TL";
    hideNoOrderText();
    notifyListeners();
  }

  reOrderListProvider() {
    order = List<OrderList>();
    orderProductStatusChangeActive = false;
    waitingCount = 0;
    productionCount = 0;
    readyCount=0;
    isLoading=false;
    priceType="TL";
    hideNoOrderText();
    notifyListeners();
  }

  @override
  Future getOrderList() async {

    isLoading=true;

    var result = await useCases.getOrderList(
      AppApi.getRequestUrl(AppApi.GETORDERLIST_API),
    );

    result.fold((exception) {
      print('hata');

      isLoading=false;

      SnackbarErrors(context: context, exp: exception);

    }, (model) async {


      print('başarılı');


      List<OrderList> tmporder = List<OrderList>();
      print(model.orderList.length);

      model.orderList.forEach((item) {
       item.products[0].orderStatus= item.products[0].variants[0].variantOrderStatus;
        tmporder.add(item);
      });


      order = tmporder;

      isLoading=false;


      notifyListeners();
    });

  }

  @override
  hideOrderProductStatusChangeButton() {
    orderProductStatusChangeActive = false;
    unSelectAllOrderProductStatus();
  }

  @override
  showOrderProductStatusChangeButton() {
    orderProductStatusChangeActive = true;
    unSelectAllOrderProductStatus();
  }

  @override
  List<OrderList> getWaitingOrderList() {
    List<OrderList> tmpOrders = List<OrderList>();
    int tmpWaitingCount = 0;
    order.forEach((order) {
      var tmpProducts = order.products
          .where((product) => product.orderStatus == 0 || product.orderStatus == 3)
          .toList();
      if (tmpProducts != null && tmpProducts.length > 0) {
        tmpWaitingCount += tmpProducts.length;
        OrderList o =  OrderList();

        o.supplierOrderCode = order.supplierOrderCode;
        o.orderDate = order.orderDate;
        o.products = tmpProducts;
        tmpOrders.add(o);
      }
    });
    waitingCount = tmpWaitingCount;
    tmpWaitingCount > 0 ? _waitingNoProduct = false : _waitingNoProduct = true;
    print('order count :'+tmpWaitingCount.toString());
    return tmpOrders;
   }

  @override
  List<OrderList> getProductionOrderList() {
    print('çalıştı production');
    List<OrderList> tmpOrders = List<OrderList>();
    int tmpProductionCount = 0;
    order.forEach((order) {
      var tmpProducts = order.products
          .where((product) => product.orderStatus == 1)
          .toList();
      if (tmpProducts != null && tmpProducts.length > 0) {
        tmpProductionCount += tmpProducts.length;
        OrderList o = new OrderList();
        o.supplierOrderCode = order.supplierOrderCode;
        o.orderDate = order.orderDate;
        o.products = tmpProducts;
        tmpOrders.add(o);
      }
    });
    _productionCount = tmpProductionCount;
    tmpProductionCount > 0 ? _productionNoProduct = false : _productionNoProduct = true;
    return tmpOrders;
  }

  @override
  List<OrderList> getReadyOrderList() {
    print('çalıştı ready');

    List<OrderList> tmpOrders = List<OrderList>();
    int tmpReadyCount = 0;
    order.forEach((order) {
      var tmpProducts = order.products
          .where((product) => product.orderStatus == 2)
          .toList();
      if (tmpProducts != null && tmpProducts.length > 0) {
        tmpReadyCount += tmpProducts.length;
        OrderList o = new OrderList();
        o.supplierOrderCode = order.supplierOrderCode;
        o.orderDate = order.orderDate;
        o.products = tmpProducts;
        tmpOrders.add(o);
      }
    });
    _readyCount = tmpReadyCount;
    tmpReadyCount > 0 ? _readyNoProduct = false : _readyNoProduct = true;
    return tmpOrders;
  }

  @override
  void handleTabSelection() {

    if (orderProductStatusChangeActive) {
      tabbarController.index = tabbarCurrentIndex;
      return;
    }


    hideNoOrderText();
    tabbarCurrentIndex = tabbarController.index;
  }

  @override
  unSelectAllOrderProductStatus() {
    switch (tabbarController.index) {
      case 0:
        order.forEach((element) {
          element.products
              .where((product) => product.orderStatus == 0 || product.orderStatus == 3)
              .toList()
              .map((e) => e.selected = false)
              .toSet();
        });
        break;
      case 1:
        order.forEach((element) {
          element.products
              .where((product) => product.orderStatus == 1)
              .toList()
              .map((e) => e.selected = false)
              .toSet();
        });
        break;
      case 2:
   order.forEach((element) {
          element.products
              .where((product) => product.orderStatus == 2)
              .toList()
              .map((e) => e.selected = false)
              .toSet();
        });
        break;
    }
    notifyListeners();
  }

  @override
  changeOrderProductSelectedStatus(Products orderProduct) {
   orderProduct.selected= !orderProduct.selected;
    notifyListeners();
  }

  @override
  showOrderProductStatusListPopup() async {

    OptionsDialogButton dialogOption = await asyncOptionsDialog(
      context: context,
      optionsDialogType: OptionsDialogType.OrderProductStatusChange,
      title: AppLocalizations.of(context).txtPopupChangeOrderProductStatus,
    );

    if (dialogOption == null) return;

    await changeOrderProductStatus(dialogOption);

  }

  @override
  List<OrderList> getSelectedAllOrderProducts() {

    List<OrderList> selectedOrders = List<OrderList>();

    order.forEach((order) {
      var selectedProducts;

      if(tabbarController.index==0)
          {
            order.products.forEach((item) {
              if(item.selected==true && (item.orderStatus == 0 || item.orderStatus == 3)){
                selectedOrders.add(order);
              }
            });
          } else{
        order.products.forEach((item) {
          if(item.selected==true &&  item.orderStatus == tabbarController.index){
            selectedOrders.add(order);
          }
        });

      }



      /*

      tabbarController.index==0
          ? selectedProducts = order.products.where((item) =>
              item.selected == true && (item.orderStatus == 0 || item.orderStatus == 3))
          .toList():
         selectedProducts = order.products.where((item) => item.selected == true && item.orderStatus == tabbarController.index).toList();

      if (selectedProducts != null && selectedProducts.length > 0)
        selectedOrders.addAll(selectedProducts);



       */
    });

    return selectedOrders;

  }

  @override
  changeOrderProductStatus(OptionsDialogButton optionType) async {

    showPreloader(context, "");

    int supplierorderstatus = 0;

    switch (optionType) {
      case OptionsDialogButton.OrderProductWaiting:
        supplierorderstatus = 0;
        break;
      case OptionsDialogButton.OrderProductProduction:
        supplierorderstatus = 1;
        break;
      case OptionsDialogButton.OrderProductReady:
        supplierorderstatus = 2;
        break;
      case OptionsDialogButton.OrderProductNoProduction:
        supplierorderstatus = 3;
        break;


      case OptionsDialogButton.Active:
        // TODO: Handle this case.
        break;
      case OptionsDialogButton.DeActive:
        // TODO: Handle this case.
        break;
      case OptionsDialogButton.Remove:
        // TODO: Handle this case.
        break;
      case OptionsDialogButton.OrderByAddedDate:
        // TODO: Handle this case.
        break;
      case OptionsDialogButton.OrderByLikeCount:
        // TODO: Handle this case.
        break;
      case OptionsDialogButton.OrderByEditStatus:
        // TODO: Handle this case.
        break;
    }

    List<Model> selectedOrderIds = new List<Model>();

    var selectedOrderProducts = getSelectedAllOrderProducts();

    List<VariantsNew> variant=List<VariantsNew>();

    selectedOrderProducts.forEach((element) {
      print(element.supplierOrderCode);

      variant.add(VariantsNew(variantId: element.products[0].variants[0].variantId,itemId: element.products[0].variants[0].itemId));

      selectedOrderIds.add(Model(status: supplierorderstatus,supplierOrderId: element.supplierOrderCode,variants:variant));
      print("status: "+selectedOrderIds[0].status.toString()+' : '+"supplierorderid: "+selectedOrderIds[0].supplierOrderId.toString());
      print("item id: "+selectedOrderIds[0].variants[0].itemId.toString()+' : '+"variantid: "+selectedOrderIds[0].variants[0].variantId.toString());


    });

    print(supplierorderstatus);

    var result = await useCases.setOrderStatus(
        AppApi.getRequestUrl(AppApi.SETORDERSTATUS_API),
      OrderStatusRequest(model:selectedOrderIds));

/*
    OrderStatusRequest(
        id: selectedOrderIds,
        supplierorderstatus: supplierorderstatus.toString())

 */

    result.fold((exception) {

      hideOrderProductStatusChangeButton();

      hidePreloader(context);

      SnackbarErrors(context: context, exp: exception);
    }, (model) async {


      selectedOrderProducts
          .map((e) {
        e.products.forEach((element) {
         if(element.selected==true)
           element.orderStatus = supplierorderstatus;

        });
      })
          .toSet();



      notifyListeners();

      hideOrderProductStatusChangeButton();

      updateProductOrderCounts();

      hidePreloader(context);

    });
  }

  @override
  hideNoOrderText() {
    readyNoProduct=false;
    productionNoProduct=false;
    waitingNoProduct=false;
  }

  @override
  updateProductOrderCounts() {

      List<Products> orderProducts=List<Products>();

      order.forEach((element) {
        orderProducts.addAll(element.products);
      });

      waitingCount=orderProducts.where((element) => element.orderStatus==0).toList().length;
    var d=  productionCount=orderProducts.where((element) => element.orderStatus==1).toList().length;
    print(d.toString()+': update status');
      readyCount=orderProducts.where((element) => element.orderStatus==2).toList().length;

  }

  @override
  setPriceType() async{
    var result = await useCases.getPriceType();
    result.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (type) async {
      if(type !='null')
        priceType=type;
    });
  }

 void handleClick(String value,position,order)async{
   print("order prod.id: "+order.products[position].productId.toString());
   print("order variant.id: "+ order.products[position].variants[0].variantId);
   switch (value) {
      case 'Detaya git':
        Navigator.pushNamed(context,AppRoutes.productdetail,arguments: Arguments(
          productId: order.products[position].productId,
          variantId: order.products[position].variants[0].variantId,
          url: order.products[position].variants[0].images[0].image,
          jewelerytypesId: order.products[position].jewelryType.jewelryTypeId,
        ));

        break;
      case 'Paylaş':
        await  createPdf(order,position);

        break;
    }
  }

///pdf actions
  Future<pw.MemoryImage> imageLoad(path)async{
    final image=await rootBundle.load(path);
    final image2= image.buffer.asUint8List(image.offsetInBytes,image.lengthInBytes);

    final image3 = pw.MemoryImage(
      image2,
    );
    return image3;
  }

  Future getImage()async{
    switch(tabbarController.index){
      case 0:
        List.generate(getWaitingOrderList().length, (index) {

          List.generate(getWaitingOrderList()[index].products.length, (index2)async {
            imagesList[getWaitingOrderList()[index].products[index2].productCode]= await networkImageLoad(getWaitingOrderList()[index].products[index2].variants[0].image);

          });

        });

        break;
      case 1:
        List.generate(getProductionOrderList().length, (index) {

          List.generate(getProductionOrderList()[index].products.length, (index2)async {
            imagesList[getProductionOrderList()[index].products[index2].productCode]= await networkImageLoad(getProductionOrderList()[index].products[index2].variants[0].image);

          });

        });

        break;
      case 2:
        List.generate(getReadyOrderList().length, (index) {

          List.generate(getReadyOrderList()[index].products.length, (index2)async {
            imagesList[getReadyOrderList()[index].products[index2].productCode]= await networkImageLoad(getReadyOrderList()[index].products[index2].variants[0].image);

          });

        });

        break;
    }
  }

  Future<pw.MemoryImage> networkImageLoad(url)async{
    final image= (await NetworkAssetBundle(Uri.parse(url)).load(url))
        .buffer
        .asUint8List();

    final image2= image.buffer.asUint8List(image.offsetInBytes,image.lengthInBytes);

    final image3 = pw.MemoryImage(
      image2,
    );
    return image3;
  }

  Future createPdf(OrderList order,position)async{
   var pdf ;
   var path1;
   var ttf;
    if(Platform.isAndroid==true){
      showPreloader(_context, "Pdf oluştuluyor...");
      pdf = pw.Document(deflate: zlib.encode);
      path1=(await getExternalStorageDirectory()).path;
      ttf= pw.Font.ttf(await rootBundle.load("fonts/montserrat_bold.ttf"));

    }else{
      showPreloader(_context, "Pdf oluştuluyor...");
      pdf = pw.Document(deflate: zlib.encode);
      path1=(await getApplicationDocumentsDirectory()).path;
      ttf= pw.Font.ttf(await rootBundle.load("fonts/montserrat_bold.ttf"));

    }


    var date = DateTime.parse(order.orderDate);

    var formattedDate = date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();

  final image= await imageLoad("images/ic_home_title.png");
  final networkImage= await networkImageLoad(order.products[position].variants[0].images[0].image);

  pdfSingleItem(pdf, image, ttf, order, formattedDate, position, networkImage);

     saveAndLaunchFile(pdf, order.products[position].variants[0].productOrderCode);

  }


  Future allOrderCreatePdf()async{
    final pdf = pw.Document(deflate: zlib.encode);
    var path1;
    var ttf;
    var image;
    if(Platform.isAndroid==true){
      showPreloader(_context, "Pdf oluşturuluyor...");
       path1=(await getExternalStorageDirectory()).path;
      ttf= pw.Font.ttf(await rootBundle.load("fonts/montserrat_bold.ttf"));
       image= await imageLoad("images/ic_home_title.png");

    }else{
      showPreloader(_context, "Pdf oluşturuluyor...");
      path1=(await getApplicationDocumentsDirectory()).path;
      ttf= pw.Font.ttf(await rootBundle.load("fonts/montserrat_bold.ttf"));
      image= await imageLoad("images/ic_home_title.png");

    }



    switch(tabbarController.index){
      case 0:

     // var networkImage= await networkImageLoad(getWaitingOrderList()[0].products[0].variants[0].image);
      if(getWaitingOrderList().length!=0){
        List.generate(getWaitingOrderList().length, (index) async {

          List.generate(getWaitingOrderList()[index].products.length, (index2)async {
            pdf.addPage(pw.Page(
                pageFormat: PdfPageFormat.a4,
                build: (_context){
                  return pw.Column(
                      children:[
                        pw.Text("s"),
                        pdfAllItem(order:getWaitingOrderList()[index], position: index2,image: image,networkImage:imagesList[getWaitingOrderList()[index].products[index2].productCode],ttf: ttf)
                      ]
                  );

                }
            ));
          });

        });
        await  saveAndLaunchFile(pdf, order[0].orderer);
      }else{
      }
      break;
      case 1:
    if(getProductionOrderList().length!=0){
    final path1=(await getExternalStorageDirectory()).path;
    final ttf= pw.Font.ttf(await rootBundle.load("fonts/montserrat_bold.ttf"));
    var image= await imageLoad("images/ic_home_title.png");
    var networkImage= await networkImageLoad(getProductionOrderList()[0].products[0].variants[0].image);
    List.generate(getProductionOrderList().length, (index) async {

    List.generate(getProductionOrderList()[index].products.length, (index2)async {
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (_context){
            return pw.Column(
                children:[
                  pdfAllItem(order:getProductionOrderList()[index], position: index2,image: image,networkImage: imagesList[getProductionOrderList()[index].products[index2].productCode],ttf: ttf)
                ]

            );

          }
      ));
    });

  });
  await  saveAndLaunchFile(pdf, order[0].orderer);

      }else{
      hidePreloader(context);

    }
   break;
      case 2:
        if(getReadyOrderList().length!=0){
          final path1=(await getExternalStorageDirectory()).path;
          final ttf= pw.Font.ttf(await rootBundle.load("fonts/montserrat_bold.ttf"));
          var image= await imageLoad("images/ic_home_title.png");
          var networkImage= await networkImageLoad(getReadyOrderList()[0].products[0].variants[0].image);

          List.generate(getReadyOrderList().length, (index) async {

            List.generate(getReadyOrderList()[index].products.length, (index2)async {
              pdf.addPage(pw.Page(
                  pageFormat: PdfPageFormat.a4,
                  build: (_context){
                    return pw.Column(
                        children:[
                          pdfAllItem(order:getReadyOrderList()[index], position: index2,image: image,networkImage: imagesList[getReadyOrderList()[index].products[index2].productCode],ttf: ttf)
                        ]

                    );

                  }
              ));
            });

          });
          await  saveAndLaunchFile(pdf, order[0].orderer);



        }else{
          hidePreloader(context);
        }

        break;
    }

  }

  void share(String document)async{
    final RenderBox box = context.findRenderObject();
    List<String> paths=[];
    paths.add(document);


  }

  Future saveAndLaunchFile(pw.Document pdf,String fileName)async{
    var file;
    if(Platform.isAndroid==true){
      print("method çalıştı");
      final path=(await getExternalStorageDirectory()).path;
      print("method çalıştı");
       file=File("$path/$fileName.pdf");
      await file.writeAsBytes(await pdf.save(),flush: true);
    }else{
      print("method çalıştı");
      final path2=(await getApplicationDocumentsDirectory()).path;
      print("method çalıştı");
       file=File("$path2/$fileName.pdf");
      await file.writeAsBytes(await pdf.save(),flush: true);
    }

/*
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfViewer(path: file.path),
      ),
    );

 */

    List<String> pathList=[];
    pathList.add(file.path);
    print("oluştu");
    hidePreloader(context);
    await Share.shareFiles(pathList);
  }

 pw.Widget pdfAllItem({OrderList order, position,ttf,image,networkImage}){

    var date = DateTime.parse(order.orderDate);

    var formattedDate = date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();


    return  pw.Column(
        children: [
          ///orange drawer
          pw.Column(
              crossAxisAlignment:pw.CrossAxisAlignment.start ,
              children: [

                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Image(image,height: 40,width: 100),
                      pw.SizedBox(width: 10),

                      pw.Text(" SİPARİŞLERİ",style: pw.TextStyle(font: ttf,fontSize: 17,color:PdfColors.red600)),

                    ]
                ),
                pw.SizedBox(height: 20),
                ///


                pw.Container(
                    width:100,// MediaQuery.of(_context).size.width+100,
                    height: 25,
                    color: PdfColors.orange800,
                    child: pw.Row(
                        children: [
                          pw.Padding(
                            padding: pw.EdgeInsets.only(left: 10),
                            child:  pw.Text(order.supplierOrderCode.toString(),style: pw.TextStyle(fontSize: 12,color: PdfColors.white,fontWeight: pw.FontWeight.bold)),


                          ),

                          pw.Padding(
                            padding: pw.EdgeInsets.only(left: 390),
                            child:  pw.Text(formattedDate,style: pw.TextStyle(fontSize: 12,color: PdfColors.white,fontWeight: pw.FontWeight.bold)),

                          ),

                        ]
                    )
                ),
                pw.SizedBox(height: 20),

                pw.Text(order.products[position].jewelryType.name+" - "+order.products[position].jewelryType.parentName,style: pw.TextStyle(font: ttf,fontSize: 12)),
                pw.Text(order.products[position].orderQty.toString()+" Adet",style: pw.TextStyle(fontSize: 12,color: PdfColors.red600,fontWeight: pw.FontWeight.bold)),

                pw.Row(
                    children: [
                      pw.Text("GBJ Ürün Kodu: ",style: pw.TextStyle(font:ttf, fontSize: 12,color: PdfColors.grey,fontWeight: pw.FontWeight.bold)),
                      pw.Text(order.products[position].productCode,style: pw.TextStyle(font:ttf,fontSize: 12,color: PdfColors.orange800,fontWeight: pw.FontWeight.bold)),
                    ]
                ),
                pw.SizedBox(height: 10),




                pw.Row(
                    children: [

                      pw.Image(networkImage,height: 110,fit: pw.BoxFit.contain,width: 100),
                      pw.SizedBox(width: 10),


                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                                children: [
                                  pw.Text("Urun Siparis Kodu: ",style: pw.TextStyle(font:ttf,fontSize: 12,color: PdfColors.orange800,fontWeight: pw.FontWeight.bold)),
                                  pw.Text(order.products[position].variants[0].productOrderCode,style: pw.TextStyle(font:ttf,fontSize: 12,color: PdfColors.red600,fontWeight: pw.FontWeight.bold)),
                                ]
                            ),

                            pw.SizedBox(width: 10),

                            pw.Text("Ağırlığı: "+order.products[position].variants[0].weight.toString(),style: pw.TextStyle(font:ttf,fontSize: 12,color: PdfColors.black,fontWeight: pw.FontWeight.bold)),


                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,

                                children: List.generate(order.products[position].variants[0].variantOptions.length, (index) {
                                  return pw.Padding(
                                      padding: pw.EdgeInsets.only(top:10),
                                      child:pw.Row(
                                          children: [
                                            pw.Text(order.products[position].variants[0].variantOptions[index].optionGroupName+" : ",style: pw.TextStyle(font:ttf,fontSize: 12,fontWeight: pw.FontWeight.bold,color: PdfColors.grey)),
                                            pw.Text(order.products[position].variants[0].variantOptions[index].optionName,style: pw.TextStyle(font:ttf,fontSize: 12,fontWeight: pw.FontWeight.bold,color: PdfColors.grey)),
                                          ]
                                      ));



                                })),




                          ]
                      ),
                    ]
                ),


              ]),
          pw.SizedBox(width: 10),

          pw.Wrap(
              children: [pw.Text(order.products[position].variants[0].description.toString(),style: pw.TextStyle(font:ttf,fontSize: 12,color:PdfColors.red600,fontWeight: pw.FontWeight.bold)),]

          ),
        ]
    );

  }

  void pdfSingleItem(pw.Document pdf, pw.MemoryImage image, pw.Font ttf, OrderList order, String formattedDate, position, pw.MemoryImage networkImage) {

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              children: [


                ///orange drawer
                pw.Column(
                    crossAxisAlignment:pw.CrossAxisAlignment.start ,
                    children: [

                      pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Image(image,height: 40,width: 100),
                            pw.SizedBox(width: 10),

                            pw.Text(" SİPARİŞLERİ",style: pw.TextStyle(font: ttf,fontSize: 17,color:PdfColors.red600)),

                          ]
                      ),
                      pw.SizedBox(height: 20),
                      ///


                      pw.Container(
                          width: MediaQuery.of(_context).size.width+100,
                          height: 25,
                          color: PdfColors.orange800,
                          child: pw.Row(
                              children: [
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 10),
                                  child:  pw.Text(order.supplierOrderCode.toString(),style: pw.TextStyle(fontSize: 12,color: PdfColors.white,fontWeight: pw.FontWeight.bold)),


                                ),

                                pw.Padding(
                                  padding: pw.EdgeInsets.only(left: 400),
                                  child:  pw.Text(formattedDate,style: pw.TextStyle(fontSize: 12,color: PdfColors.white,fontWeight: pw.FontWeight.bold)),

                                ),

                              ]
                          )
                      ),
                      pw.SizedBox(height: 20),

                      pw.Text(order.products[position].jewelryType.name+" - "+order.products[position].jewelryType.parentName,style: pw.TextStyle(font: ttf,fontSize: 12)),
                      pw.Text(order.products[position].orderQty.toString()+" Adet",style: pw.TextStyle(fontSize: 12,color: PdfColors.red600,fontWeight: pw.FontWeight.bold)),

                      pw.Row(
                          children: [
                            pw.Text("GBJ Ürün Kodu: ",style: pw.TextStyle(font:ttf, fontSize: 12,color: PdfColors.grey,fontWeight: pw.FontWeight.bold)),
                            pw.Text(order.products[position].productCode,style: pw.TextStyle(font:ttf,fontSize: 12,color: PdfColors.orange800,fontWeight: pw.FontWeight.bold)),
                          ]
                      ),
                      pw.SizedBox(height: 10),




                      pw.Row(
                          children: [

                            pw.Image(networkImage,height: 110,width: 160),
                            pw.SizedBox(width: 10),


                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                      children: [
                                        pw.Text("Urun Siparis Kodu: ",style: pw.TextStyle(font:ttf,fontSize: 12,color: PdfColors.orange800,fontWeight: pw.FontWeight.bold)),
                                        pw.Text(order.products[position].variants[0].productOrderCode,style: pw.TextStyle(font:ttf,fontSize: 12,color: PdfColors.red600,fontWeight: pw.FontWeight.bold)),
                                      ]
                                  ),
                                  pw.SizedBox(width: 10),

                                  pw.Text("Ağırlığı: "+order.products[position].variants[0].weight.toString(),style: pw.TextStyle(font:ttf,fontSize: 12,color: PdfColors.orange800,fontWeight: pw.FontWeight.bold)),

                                  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment.start,

                                      children: List.generate(order.products[position].variants[0].variantOptions.length, (index) {
                                        return pw.Padding(
                                            padding: pw.EdgeInsets.only(top:10),
                                            child:pw.Row(
                                                children: [
                                                  pw.Text(order.products[position].variants[0].variantOptions[index].optionGroupName+" : ",style: pw.TextStyle(font:ttf,fontSize: 12,fontWeight: pw.FontWeight.bold,color: PdfColors.grey)),
                                                  pw.Text(order.products[position].variants[0].variantOptions[index].optionName,style: pw.TextStyle(font:ttf,fontSize: 12,fontWeight: pw.FontWeight.bold,color: PdfColors.grey)),
                                                ]
                                            ));
                                      })),
                                  pw.SizedBox(width: 10),





                                ]
                            ),
                          ]
                      ),


                    ]),
                pw.SizedBox(width: 10),

                pw.Wrap(
                    children: [pw.Text(order.products[position].variants[0].description.toString(),style: pw.TextStyle(font:ttf,fontSize: 12,color:PdfColors.red600,fontWeight: pw.FontWeight.bold)),]

                ),
              ]
          );

        }));
  }

}
