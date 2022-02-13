import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/features/domain/entities/designTpyes/design_types.dart';
import 'package:gbjatolye/features/domain/entities/designTpyes/options.dart';
import 'package:gbjatolye/features/domain/entities/designTpyes/spect_list_dtos.dart';
import 'package:gbjatolye/features/domain/entities/homecategory.dart';
import 'package:gbjatolye/features/domain/entities/product/RequestId.dart';
import 'package:gbjatolye/features/domain/entities/product/design_types_response2.dart';
import 'package:gbjatolye/features/domain/entities/product/detailResponse2.dart';
import 'package:gbjatolye/features/domain/entities/product/option_groups.dart';
import 'package:gbjatolye/features/domain/entities/product/options.dart';
import 'package:gbjatolye/features/domain/entities/product/productOld.dart';
import 'package:gbjatolye/features/domain/entities/product/productdetail.dart';
import 'package:gbjatolye/features/domain/entities/product/productnote.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/bulkcostdialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/bulkquentitydialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/costtypedialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/minorderdialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/pricedialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/producttypedialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/sizeListdialog.dart';
import 'package:gbjatolye/features/presentation/widgets/Product/dialogs/weightdialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/messagedialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';
import 'package:gbjatolye/features/domain/entities/product/personalize_options.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

abstract class ProductDetailProviderUseCases {
  /// Fetch Product From Service.
  Future getProduct(productid);

  /// Show Dialogs.
  showWeightDialog();

  showCostTypeDialog({radioText1, radioText2});

  showMinimumOrderQuentityDialog();

  showBulkQuentityDialog();

  showBulkQuentity2Dialog();

  showGotItDialog({message});

  showPriceDialog();

  getOptions();

  showBulkCostDialog();

  showProductTypeDialog();

  showBulkCost2Dialog();

  /// Updates fields.
  updateWeight(double weight);

  updateminOrder(int minOrderQ);

  updatecostType(int costType);

  updateTotalCost(double totalCost);

  updateProductType(bool ispackage, int packagequantity);

  updateBulkCost2(double bulkCost2);

  updateBulkCost(double bulkCost);

  updateBulkQ2(int bulkQ2);

  updateBulkQ(int bulkQ);

  updateNote(String noteInPage,int variantId);

 //  setSpecs();

  /// This function set first value of fields.
  fillFirstValue();

  /// This function checks if there are any changes.
  checkUpdates();

  /// This functions take and set all selected options or specs for request model.
  List<SelectedDetailOptionRequest> getSelectedOptions();

  List<SelectedDetailOptionRequest> getSelectedSpecs();

  /// This function check if there is full all sections.
  bool fillAllSection();

  sendApproval();

  sendApprovalAvailable();


  /// set user price type
  setPriceType();

  getPriceType();


  ///kritik data girili mi değil mi kontrolü
  checkCriticalDataUpdate();


  ///detaydan gelen seçili opsiyonların eşlenmesi
  List<String>checkOptionsSelected(int index);

  List<String>  checkOtherOptionsSelected(int index);

  List<int> checkdesignSelected();


  /// toplam fiyatın hesaplandığı methodlar
  double gramTotalCost();

  double adetTotalCost();


}

class ProductDetailProvider
    with ChangeNotifier
    implements ProductDetailProviderUseCases {

  List<int> designTypesId;

  int _productId;
  int variantId;
  int jeweleryId;
  String photoUrl;
  MoneyMaskedTextController _moneyController;
  TextEditingController _noteController;
  ProductOld _product;
  BuildContext _context;
  UseCases _useCases;
  String _priceType;
  String _note="";
  String _subJeweleryName;



  String get subJeweleryName => _subJeweleryName;



  Product _products;



  
  bool _isLoading=true;
  bool _satisCoklu = true;
  bool _designAndOptionsloading = true;




  bool _optionLoading = true;
  bool optionCheckIcon=false;
  bool otherOptionState;
  bool designloading = true;
  bool designSelectedButton;
  bool _checkCriticalUpdate=false;
  bool _totalCostVisible=true;
  bool _selectSizeList;

  HomeCategory _homeCategory;

  bool get selectSizeList => _selectSizeList;

  bool get totalCostVisible => _totalCostVisible;


  set selectSizeList(bool value) {
    _selectSizeList = value;
    notifyListeners();
  }

  set subJeweleryName(String value) {
    _subJeweleryName = value;
    notifyListeners();
  }









 
  List<Options> option;
  List<OptionGroups> _otherOptionGroups=[];



  List<PersonalizeOptions> _personalizeOptions;
  List<PersonalizeOptions>_availableSpects;
  List<OptionGroups>_availableOtherOptions;

  List<OptionGroups> get availableOtherOptions => _availableOtherOptions;

  set availableOtherOptions(List<OptionGroups> value) {
    _availableOtherOptions = value;
    notifyListeners();
  }

  List<PersonalizeOptions> get availableSpects => _availableSpects;

  set availableSpects(List<PersonalizeOptions> value) {
    _availableSpects = value;
    notifyListeners();
  }

  List<Options> specifications;
  List<Options> selectedPersonalizeOptions;
  List <int> selectedDesignTypesId;

  List<int> designid = List<int>();
  List<IdToJson> designRequest = List<IdToJson>();
  List<IdToJson> _spectListRequest = List<IdToJson>();



  List<Map> spectListRequestMap = List<Map>();
  List<Map> designRequestMap = List<Map>();
  List<Map> availableRequest = List<Map>();
  List<Map> sizeListRequest = List<Map>();

  List<DesignProduct> designType = List<DesignProduct>();
  List<DesignTypes> designRequestInt = List<DesignTypes>();
  List<OptionProduct> designTypeOption = List<OptionProduct>();
  List<SpectListDtos> spectListDtos = List<SpectListDtos>();


  ///geçici options chechbox value
  List<bool> chechkBoxValue =  List<bool>();
  Map<int,bool> chechkBoxValueMap =  Map<int,bool>();



  GlobalKey _productNoteShowcaseKey = GlobalKey();
  GlobalKey _productDetailsShowcaseKey = GlobalKey();
  GlobalKey _previewShowcaseKey = GlobalKey();

  /// Check changes
  double ftweight = 0.0, fttotalcost = 0.0;
  bool ftispackage = false;
  String ftoptions = "", ftspecs = "";
  bool _updateEvent;
  String _options = "", _specs = "";

  get specs => _specs;

  String get options => _options;

  Product get products => _products;

  bool get optionLoading => _optionLoading;

  String get priceType => _priceType;

  TextEditingController get noteController => _noteController;

  UseCases get useCases => _useCases;

  ProductOld get product => _product;

  BuildContext get context => _context;

  bool get satisCoklu => _satisCoklu;

  bool get checkCriticalUpdate => _checkCriticalUpdate;

  HomeCategory get homeCategory => _homeCategory;

  bool get updateEvent => _updateEvent;

  bool get designAndOptionsloading => _designAndOptionsloading;

  int get productId => _productId;

  bool get isLoading => _isLoading;

  String get note => _note;

  List<IdToJson> get spectListRequest => _spectListRequest;


  List<OptionGroups> get otherOptionGroups => _otherOptionGroups;

  List<PersonalizeOptions> get personalizeOptions => _personalizeOptions;

  GlobalKey get productDetailsShowcaseKey => _productDetailsShowcaseKey;

  GlobalKey get previewShowcaseKey => _previewShowcaseKey;

  GlobalKey get productNoteShowcaseKey => _productNoteShowcaseKey;

  MoneyMaskedTextController get moneyController => _moneyController;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set specs(value) {
    _specs = value;
    notifyListeners();
  }

  set checkCriticalUpdate(bool value) {
    _checkCriticalUpdate = value;
    notifyListeners();
  }

  set priceType(String value) {
    _priceType = value;
    notifyListeners();
  }

  set options(String value) {
    _options = value;
    notifyListeners();
  }

  set totalCostVisible(bool value) {
    _totalCostVisible = value;
    notifyListeners();
  }



  set spectListRequest(List<IdToJson> value) {
    _spectListRequest = value;
    notifyListeners();
  }

  set otherOptionGroups(List<OptionGroups> value) {
    _otherOptionGroups = value;
    notifyListeners();
  }

  set products(Product value) {
    _products = value;
    notifyListeners();
  }

  set optionLoading(bool value) {
    _optionLoading = value;
    notifyListeners();
  }

  set note(String value) {
    _note = value;
    notifyListeners();
  }

  set personalizeOptions(List<PersonalizeOptions> value) {
    _personalizeOptions = value;
    notifyListeners();
  }

  set product(ProductOld value) {
    _product = value;
    notifyListeners();
  }

  set noteController(TextEditingController value) {
    _noteController = value;
    notifyListeners();
  }

  set homeCategory(HomeCategory value) {
    _homeCategory = value;
    notifyListeners();
  }

  set useCases(UseCases value) {
    _useCases = value;
    notifyListeners();
  }

  set context(BuildContext value) {
    _context = value;
    notifyListeners();

  }

  set updateEvent(bool value) {
    _updateEvent = value;
    notifyListeners();
  }

  set productId(int value) {
    _productId = value;
    notifyListeners();
  }

  set moneyController(MoneyMaskedTextController value) {
    _moneyController = value;
    notifyListeners();

  }

  set satisCoklu(bool value) {
    _satisCoklu = value;
    notifyListeners();
  }

  set designAndOptionsloading(bool value) {
    _designAndOptionsloading = value;
    notifyListeners();
  }

  ProductDetailProvider() {
    isLoading=true;
    //setPriceType();
    moneyController = new MoneyMaskedTextController(initialValue: 0);
    _noteController = TextEditingController();
    productId = 0;
    product = null;
    ftweight = 0.0;
    fttotalcost = 0.0;
    ftispackage = false;
    ftoptions = "";
    ftspecs = "";
    _updateEvent = false;
    _options = "";
    designSelectedButton=false;
    _specs = "";
    _priceType = "TL";
    _isLoading = false;
    otherOptionState=false;
    if(personalizeOptions!=null){
      personalizeOptions[0].changed=false;
      personalizeOptions[1].changed=false;
      personalizeOptions[2].changed=false;
    }
   }

  reProductDetailProvider() {
    satisCoklu=true;
    note=null;
    isLoading=true;
    moneyController = new MoneyMaskedTextController(initialValue: 0);
    _noteController = TextEditingController();
    productId = 0;
    product = null;
    ftweight = 0.0;
    fttotalcost = 0.0;
    ftispackage = false;
    ftoptions = "";
    ftspecs = "";
    _updateEvent = false;
    _options = "";
    _priceType = "TL";
    _specs = "";
    _isLoading = false;
  }

  @override
  fillFirstValue() {
    /// Check changes
    //setOptions();
    //setSpecs();
    //setPriceType();
    ftweight = product.weight;
    fttotalcost = product.totalcost;
    ftispackage = product.ispackage;
    ftoptions = options;
    ftspecs = specs;
    updateEvent = false;

  }

  checkCriticalDataUpdate(){
    if(products.weight>0.0&&products.minimumOrderQuantity>0&&products.cost>0.0){
         checkCriticalUpdate=true;
    }else{
      checkCriticalUpdate=false;
    }
    notifyListeners();
  }

  Future checkOptionsSelect(){
    ///options için
    List.generate(personalizeOptions.length, (index1) {
      List.generate(personalizeOptions[index1].options.length, (index2) {
        List.generate(products.spectListDtos.length, (index3) {
          List.generate(products.spectListDtos[index3].options.length, (index4) {
            if(personalizeOptions[index1].options[index2].id==products.spectListDtos[index3].options[index4].id){
              print('seçili olan optionslar'+personalizeOptions[index1].options[index2].name.toString());
              personalizeOptions[index1].options[index2].selected=true;
              personalizeOptions[index1].changed=true;
            }
          });
        });


      });
    });
    ///otherOptions için
    List.generate(otherOptionGroups.length, (index1) {
      List.generate(otherOptionGroups[index1].options.length, (index2) {
        List.generate(products.spectListDtos.length, (index3) {
          List.generate(products.spectListDtos[index3].options.length, (index4) {
            if(otherOptionGroups[index1].options[index2].id==products.spectListDtos[index3].options[index4].id){
              print('seçili olan optionslar'+otherOptionGroups[index1].options[index2].name.toString());
              otherOptionGroups[index1].options[index2].selected=true;
              otherOptionGroups[index1].changed=true;
            }
          });
        });


      });
    });
    notifyListeners();

}

  @override
  checkUpdates() {
    if (products.weight == ftweight &&
        products.cost == fttotalcost &&
        // ignore: unrelated_type_equality_checks
        products.productType == ftispackage &&
        ftoptions == options &&
        ftspecs == specs)
      updateEvent = false;
       else
      updateEvent = true;
  }

  @override
  showWeightDialog() async {
    final double weight =
        await asyncWeightInputDialog(context: context, weight: products.weight);
    if (weight == null) return;
    updateWeight(weight);
  }





  showMinimumOrderQuentityDialog() async {
     int minOrderQ = await asyncMinOrderQuentityInputDialog(
        context: context, minOrderQ: products.minimumOrderQuantity);
    if (minOrderQ == null) return;

    if(satisCoklu==true){

      if(minOrderQ==0){
        appSnackbar(context, "Minimum satış adeti 0'a eşit olamaz. ");
        minOrderQ=1;
      } else if(minOrderQ>products.bulkQuantity) {
        appSnackbar(context, "Minimum satış adeti 1.Toplu satış adetinden yüksek olamaz ");
      }else{
        updateminOrder(minOrderQ);
      }
    }else{
      updateminOrder(minOrderQ);

    }

  }

  showCostTypeDialog({radioText1, radioText2}) async {
    final int costType = await asyncCstTypeInputDialog(
        context: context,costTpye: products.costType,radioText1: radioText1,radioText2: radioText2);
    if (costType == null) return;
    updatecostType(costType);
  }

  showBulkQuentityDialog() async {
    final int bulkQ = await asyncBulkQuentityInputDialog(
        context: context, bulkQ: products.bulkQuantity);


    if (bulkQ>0&&bulkQ<products.minimumOrderQuantity||bulkQ==0) {
      appSnackbar(context,
          "1. Toplu satış adeti minimum satış adetinden küçük olamaz");
    }else if(bulkQ>0&&bulkQ>products.bulkQuantity2) {
      appSnackbar(context,
          "1.toplu satış adeti 2.toplu satış adetinden büyük olamaz.");
    } else {
      if (products.bulkQuantity == null) return;
      updateBulkQ(bulkQ);
    }
  }

  showBulkQuentity2Dialog() async {
    final int bulkQ2 = await asyncBulkQuentityInputDialog2(
        context: context, bulkQ2: products.bulkQuantity2);
    if (products.bulkQuantity != 0.00 && bulkQ2 < products.bulkQuantity) {
      appSnackbar(
          context, "2. Toplu satış adeti 1. Toplu satış adetinden küçük olamaz.");
    } else {
      if (bulkQ2 == null) return;
      updateBulkQ2(bulkQ2);
    }
  }

  @override
  showPriceDialog() async {
    final double totalCost =
        await asyncPriceInputDialog(context: context, price: products.cost);
    if (totalCost == null) return;
    updateTotalCost(totalCost);
  }

  showBulkCostDialog() async {
    final double bulkCost = await asyncBulkCostInputDialog(
        context: context, bulkCost: products.bulkCost);
    if(bulkCost>products.cost){
      appSnackbar(context,
          "1. Toplu satış fiyatı birim fiyattan yüksek olamaz");
    } else {
      if (bulkCost == null) return;
      updateBulkCost(bulkCost);
    }
  }

  showBulkCost2Dialog() async {
    final double bulkCost2 = await asyncBulkCostInputDialog2(
        context: context, bulkCost2: products.bulkCost2);
    if (products.bulkCost != 0.00 && bulkCost2 >products.bulkCost) {
      appSnackbar(context, "2. Toplu satış fiyatı 1. Toplu satış fiyatından büyük olamaz");
    } else {
      if (bulkCost2 == null) return;
      updateBulkCost2(bulkCost2);
    }
  }

  @override
  showProductTypeDialog() async {
    HashMap<bool, int> typeAndCount =
        await asyncProductTypeInputDialog(context, products.mixQuantity);
    if (typeAndCount == null) return;
    typeAndCount.forEach((key, value) {
      updateProductType(key, value);
    });
  }

  @override
  showGotItDialog({message}) async {
    await asyncFilterMessageDialog(context, DialogType.DetailWaitLike,
      message==null ?AppLocalizations.of(context).txtPopupWaitLike:message);
  }



  @override
  updateWeight(double weight) {
    products.weight = weight;
    checkUpdates();
    notifyListeners();
  }



  updateminOrder(int minOrderQ) {
    products.minimumOrderQuantity = minOrderQ;
    notifyListeners();
    checkUpdates();
  }

  updatecostType(int costType) {
    if(costType==0){
      totalCostVisible=true;
    }else{
      totalCostVisible=false;
    }
    products.costType = costType;
    checkUpdates();
    notifyListeners();
  }

  updateBulkQ(int bulkQ) {
    products.bulkQuantity = bulkQ;
    checkUpdates();
    notifyListeners();
  }

  updateBulkQ2(int bulkQ2) {
    products.bulkQuantity2 = bulkQ2;
    checkUpdates();
    notifyListeners();

  }

  @override
  updateTotalCost(double totalCost) {
    products.cost = totalCost;
    notifyListeners();
    checkUpdates();
  }

  updateBulkCost(double bulkCost) {
    products.bulkCost = bulkCost;
    notifyListeners();
    checkUpdates();
  }

  updateBulkCost2(double bulkCost2) {
    products.bulkCost2 = bulkCost2;
    notifyListeners();
    checkUpdates();
  }

  @override
  updateProductType(bool ispackage, int packagequantity) {
    products.mixQuantity = packagequantity;
    products.isPackage=true;
    notifyListeners();
    checkUpdates();
  }

  @override
  updateNote(String  noteInPage,int variantId) async {
    showPreloader(context, "");

    var result = await useCases.setProductNote(
        AppApi.getRequestUrl(AppApi.PRODUCTSETNOTE_API),
        ProductNoteRequest(variantId:variantId.toString(), note: noteInPage));

    result.fold((exception) {
      hidePreloader(context);

      SnackbarErrors(context: context, exp: exception);
    }, (response) async {

      noteInPage == "" ? products.note = null : note = noteInPage;


      hidePreloader(context);
      notifyListeners();
    });
  }

  @override
  Future getProduct(productid) async {

    var result = await useCases.getProductDetail(
        AppApi.getRequestUrl(AppApi.PRODUCTDETAIL_API),
        ProductDetailRequest(id: productId.toString()));

    result.fold((exception) {
      print("hata"+productId.toString());
      SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      designTypeOption.clear();
      print(model.product.variantId.toString()+"variant id product");
      
      photoUrl=model.product.blobUrl;
      jeweleryId=model.product.jewelryTypeId;
      variantId=model.product.variantId;



      model.product.minimumOrderQuantity==0?
      model.product.minimumOrderQuantity=1:null;
      products = model.product;



      ///devam butonunun çıkıp çıkmama kontrolü
      checkCriticalDataUpdate();
      note="";

      note=products.note;

      ///çoklu satış switch kontrolü
      /*
      _satisCoklu=false;
      products.bulkCost>0?_satisCoklu = true:false;

       */
      //    model.product.bulkCost>0.00?satisCoklu=true:satisCoklu=false;


      ///reversed size list
      if(products.sizeList[0].options.isNotEmpty){
        List<Options> d= products.sizeList[0].options.reversed.toList();
        products.sizeList[0].options.clear();
        products.sizeList[0].options=d.reversed.toList();
      }




      ///seçilen dizayn type listesinin doldurulması
      designTypeOption.clear();
      if(products.designTypes.isNotEmpty)
        designTypeOption = products.designTypes[0].options;



      if(satisCoklu==false) {
        products.bulkCost=0;
        products.bulkCost2=0;
        products.bulkQuantity2=0;
        products.bulkQuantity=0;
      }else if(satisCoklu==true&&products.bulkCost==0){
       products.bulkCost=0;
       products.bulkCost2=0;
       products.bulkQuantity2=20;
       products.bulkQuantity=5;

      }



      notifyListeners();
     });
  }

  Future getDesignTypes(String productId) async {
    var result = await useCases
        .getDesignTpyes(AppApi.getRequestUrl(AppApi.DESIGNTYPES_API),IdToJson(id2: productId ));
    result.fold((exception) {
      print("hata");
      SnackbarErrors(context: context, exp: exception);
    }, (model) {
      designloading = false;
      option = model.designTypes.options;
      print(designloading.toString());
notifyListeners();
    });
   }

  Future getOtherOptions(String productId,String variantId) async {
    var result = await useCases.getOtherOptions(
        AppApi.getRequestUrl(AppApi.OTHEROPTIONS_API), jeweleryId.toString(),variantId);
    result.fold((exception) {
      print("hata other option metodu");
      SnackbarErrors(context: context, exp: exception);
    }, (model) {
      print('başarılı');
      otherOptionGroups = model.optionGroups;
     });
    notifyListeners();
   }

  Future getOptions({jewelerytypeid,variantId,designId}) async {
    var result = await useCases.getOptions(
        AppApi.getRequestUrl(AppApi.OPTIONS_API), jewelerytypeid.toString(),variantId,designId);
    result.fold((exception) {
      print("hata  "+exception.toString());
      SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      isLoading=true;
       personalizeOptions = model.personalizeOptions;
      Set <String> tt =Set<String>();


     });
    notifyListeners();
  }

  /*setOptions() {
    String selectedSizeGroups = "";
    if (product.sizes.first != null && product.sizes.first.isdefault) return;
    for (int i = 0; i < product.sizes.length; i++) {
      bool ft = true;
      product.sizes[i].sizes.forEach((element) {
        if (element.selected && ft) {
          selectedSizeGroups =
              product.sizes[i].sizetitlename + "\n\n" + element.name;
          ft = false;
        } else if (element.selected) selectedSizeGroups += ", " + element.name;
      });
    }
    options = selectedSizeGroups;
    checkUpdates();
  }




  */


  @override
  Future sendApproval() async {
    ///spectList
    spectListRequestMap.clear();
    sizeListRequest.clear();
    designRequest.clear();

    List.generate(
      personalizeOptions.length,
      (index1) {
        return List.generate(personalizeOptions[index1].options.length,
            (index) {
          if (personalizeOptions[index1].options[index].selected == true) {
            spectListRequest.add(IdToJson(id: personalizeOptions[index1].options[index].id));
            spectListRequestMap.add(IdToJson(id: personalizeOptions[index1].options[index].id).toJsonRequestid());
            personalizeOptions[index1].options[index].selected = false;
            print(spectListRequest[0].id);
          }
        });
      },
    );
    ///otherOptions
    List.generate(
      otherOptionGroups.length,
      (index1) {
        return List.generate(otherOptionGroups[index1].options.length,
            (index) {
          if (otherOptionGroups[index1].options[index].selected == true) {
            spectListRequest.add(IdToJson(id: otherOptionGroups[index1].options[index].id));
            spectListRequestMap.add(IdToJson(id: otherOptionGroups[index1].options[index].id).toJsonRequestid());
            otherOptionGroups[index1].options[index].selected = false;
          }
        });
      },
    );
    ///sizeList

    List.generate(
      products.sizeList.length,
          (index1) {
        return List.generate( products.sizeList[index1].options.length,
                (index) {
              if (products.sizeList[index1].options[index].selected == true) {
                sizeListRequest.add(IdToJson(id: products.sizeList[index1].options[index].id).toJsonRequestid());
                products.sizeList[index1].options[index].selected= false;
              }
            });
      },
    );


    ///design Types
    designRequest.clear();
    List.generate(option.length, (index) {
      if( option[index].selected == true){
        designRequestMap.add(IdToJson(id: option[index].id).toJsonRequestid());
        designRequest.add(IdToJson(id: option[index].id));

      }
    });

    showPreloader(
        context, AppLocalizations.of(context).txtLblProductApproveSending);

    ProductDetailUpdateRequest requestModel;

    requestModel = ProductDetailUpdateRequest(
      bulkCost2: products.bulkCost2,
      bulkCost: products.bulkCost,
      bulkQentity2: products.bulkQuantity2,
      bulkQentity: products.bulkQuantity,
      weight: products.weight,
      productid: products.productId,
      variantId: products.variantId,
      totalcost: products.cost,
      designTypes: designRequestMap,
      spectListRequest: spectListRequestMap,
      minOrderQ: products.minimumOrderQuantity,
        cosType: products.costType,
      ispackage: products.isPackage,
      mixQuantity: products.mixQuantity,
      sizeList: sizeListRequest
    );

    var result = await useCases.sendProductApproved(
        AppApi.getRequestUrl(AppApi.PRODUCTSENDAPPROVAL_API), requestModel);
    result.fold((exception) {
      hidePreloader(context);
      SnackbarErrors(context: context, exp: exception);
      print(exception);
    }, (model) async {

    /*
      designRequest.clear();
      spectListRequest.clear();
       */
      print(products.productId.toString() +
          ": variantId" +
          products.variantId.toString());
      //   fillFirstValue();
      hidePreloader(context);
      appSnackbar(context, AppLocalizations.of(context).txtLblProductApproveSent);
    });
  }

  Future sendApprovalAvailable() async {
    ///spectList
    spectListRequest.clear();
    List.generate(
      availableSpects.length,
      (index1) {
        List<int> Id=List<int>();
         List.generate(availableSpects[index1].options.length,
            (index) {
          if (availableSpects[index1].options[index].selected == true) {
            Id.add(availableSpects[index1].options[index].id);
        //    spectListRequest.add(IdToJson(id: personalizeOptions[index1].options[index].id));
            availableSpects[index1].options[index].selected = false;
          }
        });

        if(Id.isNotEmpty){
          availableRequest.add(AvailableRequest(optionGroupId:availableSpects[index1].id ,optionIdList:Id ).toJsonRequestId());
      }

      },
    );
    ///otherOptions
    List.generate(
      availableOtherOptions.length,
      (index1) {
        List<int> Id=List<int>();
         List.generate(availableOtherOptions[index1].options.length,
            (index) {
          if (availableOtherOptions[index1].options[index].selected == true) {
            Id.add(availableOtherOptions[index1].options[index].id);
        //    spectListRequest.add(IdToJson(id: otherOptionGroups[index1].options[index].id));
            availableOtherOptions[index1].options[index].selected = false;
          }
        });
        if(Id.isNotEmpty){
          availableRequest.add(AvailableRequest(optionGroupId:availableOtherOptions[index1].id ,optionIdList:Id ).toJsonRequestId());
      }
      },
    );

    showPreloader(context, AppLocalizations.of(context).txtLblProductApproveSending);

    ProductDetailUpdateRequest requestModel;

    requestModel = ProductDetailUpdateRequest(productid2: products.productId, avaliableOptionList: availableRequest,);

    print(productId);

    availableRequest.forEach((element) {
      print(element.toString());
    });

    var result = await useCases.sendProductApproved(
        AppApi.getRequestUrl(AppApi.PRODUCTSENDAPPROVALAVAILABLE_API), requestModel);
    result.fold((exception) {
      hidePreloader(context);
      SnackbarErrors(context: context, exp: exception);

    }, (model) async {
      designRequest.clear();
      spectListRequest.clear();
      //   fillFirstValue();
      hidePreloader(context);
      appSnackbar(context, AppLocalizations.of(context).txtLblProductApproveSent);
    }).then((value) {
      Future.delayed(Duration(seconds: 2)).then((value) {

        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.productlist, (route) => false,arguments: jeweleryId);

      });
    });
  }

  @override
  setPriceType() async {
    var result = await useCases.getPriceType();
    result.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (type) async {
      priceType = type;
    });
  }

  double gramTotalCost(){
    double totalCost=products.weight*products.cost*products.minimumOrderQuantity;
     return totalCost;
  }


  double adetTotalCost(){
    double totalCost=products.cost*products.minimumOrderQuantity;

    return totalCost;

  }

  @override
  List<String> checkOptionsSelected(int index) {
    List<String> tt =[];
    personalizeOptions[index].options.forEach((element) {
     if(element.selected==true){
       tt.add(element.name);
     }
   });
    return tt;

  }

  @override
  List<String> checkOtherOptionsSelected(int index,) {
    List<String> tt =[];
    otherOptionGroups[index].options.forEach((element) {
      if(element.selected==true){
        tt.add(element.name);
      }
    });
    return tt;

  }

  List<int> checkdesignSelected() {
    List<int> tt =List<int>();
    option.forEach((element) {
     if(element.selected==true){
       tt.add(element.id);
     }
   });
    return tt;
  }
///bottom  navigaiton bar visible check
  String checkdSizeListSelectedName(index) {
    String tt=null ;
    if(products.sizeList.length!=0){
      products.sizeList[index].options.forEach((element) {
        if(element.selected==true){
          tt=element.name;
        }
      });
    }
    return tt;
  }




  ///old check selected options
  @override
  List<SelectedDetailOptionRequest> getSelectedOptions() {
    if (product.sizes.first != null && product.sizes.first.isdefault)
      return List<SelectedDetailOptionRequest>();

    List<SelectedDetailOptionRequest> selectedOptions =
    List<SelectedDetailOptionRequest>();

    product.sizes.forEach((element) {
      element.sizes.forEach((item) {
        if (item.selected)
          selectedOptions.add(SelectedDetailOptionRequest(id: item.sizeid));
      });
    });

    return selectedOptions;
  }

  @override
  List<SelectedDetailOptionRequest> getSelectedSpecs() {
    List<SelectedDetailOptionRequest> selectedSpecs =
    List<SelectedDetailOptionRequest>();

    product.specifications.forEach((element) {
      element.specifications.forEach((item) {
        if (item.selected)
          selectedSpecs.add(SelectedDetailOptionRequest(id: item.id));
      });
    });

    return selectedSpecs;
  }


  setSpecs() {
    String selectedGroups = "";
    bool ft = true;
    for (int i = 0; i < product.specifications.length; i++) {
      bool ng = true; //new group
      product.specifications[i].specifications.forEach((element) {
        if (element.selected && ft) {
          selectedGroups =
              product.specifications[i].titlename + "\n\n" + element.name;
          ft = false;
          ng = false;
        } else if (element.selected && ng) {
          selectedGroups += "\n\n" +
              product.specifications[i].titlename +
              "\n\n" +
              element.name;
          ng = false;
        } else if (element.selected) selectedGroups += ", " + element.name;
      });
    }
    specs = selectedGroups;
    checkUpdates();
  }

  @override
  bool fillAllSection() {
    if ((!product.weight.isNaN && product.weight > 0.0) &&
        (!product.totalcost.isNaN && product.totalcost > 0.0) &&
        ((product.ispackage && product.packagequantity > 0) ||
            (!product.ispackage)) &&
        (getSelectedOptions().length > 0))
      return true;
    else
      return false;
  }


  checkData(){
    if(designAndOptionsloading==false&&products!=null){


      coklusatischeck:if(satisCoklu==true){

        criticalDataCheck:if( checkCriticalUpdate == true){
          ///critical data sağlanmışsa true
          return true;

        }else criticalDataCheck2:if(products.weight > 0 &&
            products.minimumOrderQuantity > 0&&products.cost>0&&products
            .bulkCost>0&&products
            .bulkCost2>0){
          ///critical data sağlanmışsa true
          return true;
        }else{
          ///critical data sağlanmamışsa false
          return false;
        }
      }else{
        ///çoklu satış kapalıysa
        criticalDataCheck:if( checkCriticalUpdate == true){
          ///critical data sağlanmışsa true
          return true;

        }else criticalDataCheck2:if(products.weight > 0 &&
        products.minimumOrderQuantity > 0&&products.cost>0){
          ///critical data sağlanmışsa true
          return true;
        }else{
          ///critical data sağlanmamışsa false
          return false;
        }
      }
    }else{
      /// loadingler bitmediyse false
      return false;
    }


notifyListeners();
  }

  @override
 Future getPriceType() async{
  var result=await _useCases.getPriceType();
  result.fold((exception) {
    SnackbarErrors(context: context, exp: exception);

  }, (model) {
    priceType=model;
    print(priceType);
  });

  notifyListeners();
  }

}
