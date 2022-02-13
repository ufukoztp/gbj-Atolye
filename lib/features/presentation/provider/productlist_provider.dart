import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/app.dart';
import 'package:gbjatolye/features/domain/entities/homecategory.dart';
import 'package:gbjatolye/features/domain/entities/product/options.dart';
import 'package:gbjatolye/features/domain/entities/product/productOld.dart';
import 'package:gbjatolye/features/domain/entities/product/productstatus.dart';
import 'package:gbjatolye/features/domain/entities/product/productswithlist.dart';
import 'package:gbjatolye/features/domain/entities/variant.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/widgets/messagedialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/optionsdialog_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/snackbar_errors.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ProductListProviderUseCases {

  /// indicates which tab menu active
  handleTabSelection();

  /// routes add product page
  addPhotoButton(int collectionGroup);

  /// removes all selected products and updates bottom addproductpage button as statuschangebutton
  showProductStatusChangeButton();

  /// removes all selected products and updates bottom statuschangebutton button as addproductpage
  hideProductStatusChangeButton();

  /// indicates user's product active, passive or remove
  showChangeProductStatusPopupButton();

  /// changes product status what I choosed on showChangeProductStatusPopupButton()
  changeProductsStatus(OptionsDialogButton optionsDialogButton);

  showProductOrderByPopupButton();

  orderByProductCreateDate();

  orderByProductLike();

  //orderByProductEditStatus();

  bool visibilityTabIcons();

  //  Future getActiveProductList(int page);

  // Future getDeactiveProductList(int page);

  changeProductSelectedStatus(ProductsWithList product);

 List<ProductsWithList> getActiveProducts();

  List<ProductsWithList> getDeactiveProducts();

  unselectAllProductStatus();

  List<ProductsWithList> getSelectedAllProducts();

  setProductsActive();

  setProductsDeactive();

  setProductsDelete();

  activeHandleScrollBottom();

  deactiveHandleScrollBottom();

  reProductListProvider();

}

class ProductListProvider
    with ChangeNotifier
    implements ProductListProviderUseCases {

  ScrollController _enableProductListScrollController;
  ScrollController _disableProductListScrollController;
  List<ProductsWithList> _activeProducts;
  List<ProductsWithList> _deactiveProducts;
  List<Variant> _variants;
  BuildContext _context;
  UseCases _useCases;
  TabController _tabbarController;
  int _tabbarCurrentIndex = 0;
  bool _productStatusChangeActive;
  int _selectedSortByIndex;
  bool _firstTime;
  int _activeCurrentPage = 1;
  int _activepagecount;
  int _deactiveCurrentPage = 1;
  int _deactivepagecount;
  HomeCategory _homeCategory;
  GlobalKey _addProductShowcaseKey = GlobalKey();
  GlobalKey _productOrderByShowcaseKey = GlobalKey();
  GlobalKey _productEditShowcaseKey = GlobalKey();
  bool loadActive=true;
  bool loadDeactive=true;
  bool _notProduct=true;
  bool notProductActive=true;
  List<Options> options;


  GlobalKey get productEditShowcaseKey => _productEditShowcaseKey;

  GlobalKey get productOrderByShowcaseKey => _productOrderByShowcaseKey;

  GlobalKey get addProductShowcaseKey => _addProductShowcaseKey;


  HomeCategory get homeCategory => _homeCategory;

  int get deactivepagecount => _deactivepagecount;

  int get activepagecount => _activepagecount;

  List get activeProducts => _activeProducts;
  List get deactiveProducts => _deactiveProducts;

  bool get firstTime => _firstTime;

  bool get notProduct=>_notProduct;


  int get selectedSortByIndex => _selectedSortByIndex;

  int get deactiveCurrentPage => _deactiveCurrentPage;

  ScrollController get enableProductListScrollController =>
      _enableProductListScrollController;

  ScrollController get disableProductListScrollController =>
      _disableProductListScrollController;

  int get activeCurrentPage => _activeCurrentPage;


  // ignore: unnecessary_getters_setters
  BuildContext get context => _context;

  List<Variant> get variants => _variants;

  // ignore: unnecessary_getters_setters
  UseCases get useCases => _useCases;

  TabController get tabbarController => _tabbarController;

  int get tabbarCurrentIndex => _tabbarCurrentIndex;

  bool get productStatusChangeActive => _productStatusChangeActive;

  set selectedSortByIndex(int value) {
    _selectedSortByIndex = value;
    notifyListeners();
  }



  set notProduct(bool value){

    _notProduct=value;
    notifyListeners();
  }

  set disableProductListScrollController(ScrollController value) {
    _disableProductListScrollController = value;
    notifyListeners();
  }
  set enableProductListScrollController(ScrollController value) {
    _enableProductListScrollController = value;
    notifyListeners();
  }

  set deactivepagecount(int value) {
    _deactivepagecount = value;
    notifyListeners();
  }
  set activeProducts(List value) {
    _activeProducts = value;
    notifyListeners();
  }
  set deactiveProducts(List value) {
    _deactiveProducts = value;
    notifyListeners();
  }

  set homeCategory(HomeCategory value) {
    _homeCategory = value;
    notifyListeners();
  }

  set firstTime(bool value) {
    _firstTime = value;
    notifyListeners();
  }

  set activepagecount(int value) {
    _activepagecount = value;
    notifyListeners();
  }

  set deactiveCurrentPage(int value) {
    _deactiveCurrentPage = value;
    notifyListeners();
  }

  set activeCurrentPage(int value) {
    _activeCurrentPage = value;
    notifyListeners();
  }



  set variants(List<Variant> value) {
    _variants = value;
    notifyListeners();
  }



  set productStatusChangeActive(bool value) {
    _productStatusChangeActive = value;
    notifyListeners();
  }

  set tabbarController(TabController value) {
    _tabbarController = value;
    notifyListeners();
  }

  // ignore: unnecessary_getters_setters
  set context(BuildContext value) {
    _context = value;
  }

  // ignore: unnecessary_getters_setters
  set useCases(UseCases value) {
    _useCases = value;
  }

  set tabbarCurrentIndex(int value) {
    _tabbarCurrentIndex = value;
    notifyListeners();
  }

  ProductListProvider() {
    productStatusChangeActive = false;
    selectedSortByIndex = 0;
    _activeCurrentPage = 1;
    _deactiveCurrentPage = 1;
    _enableProductListScrollController=ScrollController();
    _disableProductListScrollController=ScrollController();
    _activeProducts = List<ProductsWithList>();
    _deactiveProducts = List<ProductsWithList>();
    _firstTime = true;
    _activepagecount = 1;
    _deactivepagecount=1;
  }

  @override
  reProductListProvider() {
    activeProducts.clear();
    deactiveProducts.clear();
    productStatusChangeActive = false;
    _enableProductListScrollController=ScrollController();
    _disableProductListScrollController=ScrollController();
    selectedSortByIndex = 0;
    activeCurrentPage = 1;
    deactiveCurrentPage = 1;
    activepagecount = 1;
    deactivepagecount=1;
    firstTime = true;
  }


  /// Functions
  ///

  @override
  handleTabSelection() {
    if (productStatusChangeActive) {
      tabbarController.index = tabbarCurrentIndex;
      return;
    }
    tabbarCurrentIndex = tabbarController.index;
  }

  @override
  addPhotoButton(int collectionGroup) async {
    print(collectionGroup);

  await Navigator.pushNamed(context, AppRoutes.photopicker);
    reProductListProvider();
    await getActiveProductList(activeCurrentPage);
    await getDeactiveProductList(deactiveCurrentPage);
    firstTime = false;


  }

  @override
  showProductStatusChangeButton() {
    productStatusChangeActive = true;
    unselectAllProductStatus();
  }

  @override
  hideProductStatusChangeButton() {
    productStatusChangeActive = false;
    unselectAllProductStatus();
  }

  @override
  showChangeProductStatusPopupButton() async {
    if (getSelectedAllProducts().length == 0) {
      appSnackbar(context,
          AppLocalizations.of(context).txtNoSelectProductStatus
      );
      return;
    }

    OptionsDialogButton dialogOption = await asyncOptionsDialog(
        context: context,
        optionsDialogType: OptionsDialogType.ProductSaleStatusChange,
        title:AppLocalizations.of(context).txtPopupChangeProductStatus
    );

    if (dialogOption == null) return;

    changeProductsStatus(dialogOption);

  }

  List<ProductsWithList> getActiveProducts() {
    return activeProducts.where((product) => product.isactive == true).toList();
  }

  List<ProductsWithList> getDeactiveProducts() {
    return deactiveProducts
        .where((variant) => variant.isactive == false)
        .toList();
  }

  @override
  changeProductSelectedStatus(ProductsWithList product) {
    product.selected = !product.selected;
    notifyListeners();
  }

  @override
  unselectAllProductStatus() {
    tabbarCurrentIndex == 0
        ? activeProducts.map((item) => item.selected = false).toSet()
        : deactiveProducts.map((item) => item.selected = false).toSet();

    notifyListeners();
  }

  @override
  List<ProductsWithList> getSelectedAllProducts() {
    return tabbarCurrentIndex == 0
        ? activeProducts.where((item) => item.selected == true).toList()
        : deactiveProducts.where((item) => item.selected == true).toList();
  }

  @override
  changeProductsStatus(OptionsDialogButton optionsDialogButton) async {
    if (optionsDialogButton == OptionsDialogButton.Active) {
      await setProductsActive();
    } else if (optionsDialogButton == OptionsDialogButton.DeActive) {
      await setProductsDeactive();
    } else {
      MessageDialogTypes messageDialogOption = await asyncFilterMessageDialog(
          context,
          DialogType.RemoveProduct,
          AppLocalizations.of(context).txtPopupSureRemoveProduct
      );
      if (messageDialogOption == MessageDialogTypes.OK)
        await setProductsDelete();
    }

    hideProductStatusChangeButton();
  }

  @override
  showProductOrderByPopupButton() async {
    OptionsDialogButton dialogOption = await asyncOptionsDialog(
        context: context,
        optionsDialogType: OptionsDialogType.ProductSortBy,
        title:AppLocalizations.of(context).txtPopupProductSort,
        selectedOptionIndex: selectedSortByIndex);

    if (dialogOption == null) return;

    if (dialogOption == OptionsDialogButton.OrderByAddedDate) {
      orderByProductCreateDate();
      selectedSortByIndex = 0;
    } else if (dialogOption == OptionsDialogButton.OrderByLikeCount) {
      orderByProductLike();
      selectedSortByIndex = 1;
    } /*else if (dialogOption == OptionsDialogButton.OrderByEditStatus) {
      orderByProductEditStatus();
      selectedSortByIndex = 2;
    }*/
  }

  @override
  bool visibilityTabIcons() {
    if ((tabbarCurrentIndex == 0 && activeProducts.length > 0) ||
        (tabbarCurrentIndex == 1 && deactiveProducts.length > 0))
      return true;
    else
      return false;
  }

  @override
  orderByProductCreateDate() {
    activeProducts.sort((a, b) => b.updateDate.compareTo(a.updateDate));
    deactiveProducts.sort((a, b) => b.updateDate.compareTo(a.updateDate));
    notifyListeners();
  }

  @override
  orderByProductLike() {
    activeProducts.sort((a, b) => b.likeCount.compareTo(a.likeCount));
    deactiveProducts.sort((a, b) => b.likeCount.compareTo(a.likeCount));
    notifyListeners();
  }
/*
  @override
  orderByProductEditStatus() {
    activeProducts.sort(
        (a, b) => b.iscompleted.toString().compareTo(a.iscompleted.toString()));
    deactiveProducts.sort(
        (a, b) => b.iscompleted.toString().compareTo(a.iscompleted.toString()));
    notifyListeners();
  }
*/
  bool _showLoadingInd = false;

  bool get showLoadingInd => _showLoadingInd;

  set showLoadingInd(bool value) {
    _showLoadingInd = value;
    notifyListeners();
  }

  void _showLoadingIndicator() {
    _showLoadingInd = true;
    notifyListeners();
  }

  void _removeLoadingIndicator() {
    _showLoadingInd = false;
    notifyListeners();
  }

  @override
  Future activeHandleScrollBottom() async {
    if (activeCurrentPage <= activepagecount) {
      _showLoadingIndicator();

      await getActiveProductList(activeCurrentPage);

      _removeLoadingIndicator();
    } else {
    }
  }

  @override
  Future deactiveHandleScrollBottom() async {
    if (deactiveCurrentPage <= deactivepagecount) {
      _showLoadingIndicator();
      await getDeactiveProductList(deactiveCurrentPage);
      _removeLoadingIndicator();
    } else {
    }
  }

  // ignore: missing_return
  Future getActiveProductList(int page) async {
    var result = await useCases.getProductList(
        AppApi.getRequestUrl(AppApi.ACTIVEPRODUCTLIST_API),
        ProductRequest(
          collectionGroupId: homeCategory.collectionGroupId.toString(),
            jewelrytypeid: homeCategory.jewelrytypeid.toString(),
            subtype: homeCategory.subtype.toString(),
            page: (page).toString()));
    result.fold((exception) {
      SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      List<ProductsWithList> temp = List<ProductsWithList>();
      for (ProductsWithList item in model.products) {
        item.selected=false;
        temp.add(item);
        print(item.variantId.toString()+"variant");
      }
      activeProducts=temp;
      loadActive=false;
      activeCurrentPage += 1;
    activeProducts.length==0? notProductActive=true:notProductActive=false;
      notifyListeners();
    });
  }

  Future getDeactiveProductList(int page) async {
    var result = await useCases.getProductList(
        AppApi.getRequestUrl(AppApi.DEACTIVEPRODUCTLIST_API),
        ProductRequest(
          collectionGroupId: homeCategory.collectionGroupId.toString(),
            jewelrytypeid: homeCategory.jewelrytypeid.toString(),
            subtype: homeCategory.subtype.toString(),
            page: (1).toString()));
    result.fold((exception) {
    SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      print("changed status deactive");
      List<ProductsWithList> temp = List<ProductsWithList>();
      for (ProductsWithList item in model.products) {
        item.selected=false;
        temp.add(item);
      }
      deactiveProducts=temp;
      deactiveCurrentPage += 1;
      loadDeactive=false;
      deactiveProducts.length==0?  notProduct=true:notProduct=false;
      notifyListeners();

    });
  }

  @override
  setProductsActive() async {
    if (tabbarCurrentIndex == 0) return;

    showPreloader(context, "");

    List<int> pil = List<int>();

    for (ProductsWithList i in getSelectedAllProducts()) pil.add(i.productId);

    var result = await useCases.setProductStatus(
        AppApi.getRequestUrl(AppApi.SETPRODUCTACTIVE_API),
        ProductStatusRequest(productidlist: pil));

    result.fold((exception) {
      hidePreloader(context);
      SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      print("changed status deactive");
      for (ProductsWithList item in getSelectedAllProducts()) {
        deactiveProducts.remove(item);
        activeProducts.insert(0, item);
        notifyListeners();
      }
      activeProducts.length==0?notProductActive=true:notProductActive=false;

      hidePreloader(context);
    });
  }

  @override
  setProductsDeactive() async {
    if (tabbarCurrentIndex == 1) return;

    showPreloader(context, "");

    List<int> pil = List<int>();

    for (ProductsWithList i in getSelectedAllProducts())
      pil.add(i.productId);


    var result = await useCases.setProductStatus(
        AppApi.getRequestUrl(AppApi.SETPRODUCTDEACTIVE_API),
        ProductStatusRequest(productidlist: pil));


    result.fold((exception) {
      hidePreloader(context);

      SnackbarErrors(context: context, exp: exception);
    }, (model) async {
      _notProduct=false;
      for (ProductsWithList item in getSelectedAllProducts()) {
        activeProducts.remove(item);
        deactiveProducts.insert(0, item);
        notifyListeners();
      }
      deactiveProducts.length==0?notProduct=true:notProduct=false;

      hidePreloader(context);
    });


  }

  @override
  setProductsDelete() async {

    showPreloader(context, "");

    List<int> pil = List<int>();

    for (ProductsWithList i in getSelectedAllProducts()) pil.add(i.productId);

    var result = await useCases.deleteProductList(
        AppApi.getRequestUrl(AppApi.DELETEPRODUCT_API),
        ProductStatusRequest(productidlist: pil));

    result.fold((exception) {
      hidePreloader(context);
      SnackbarErrors(context: context, exp: exception);

    }, (model) async {
      for (ProductsWithList p in getSelectedAllProducts()) {
        tabbarCurrentIndex == 0
            ? activeProducts.remove(p)
            : deactiveProducts.remove(p);
      }
      notifyListeners();
      hidePreloader(context);
    });
  }




}
