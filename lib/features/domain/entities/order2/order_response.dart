/// success : true
/// orderList : [{"supplierOrderCode":102,"orderer":"GBJ","orderDate":"2021-03-08T11:51:15.13","date":null,"supplierName":null,"products":[{"productId":9628,"productCode":"GBJ3BR9628","jewelryType":{"jewelryTypeId":595,"parentName":"Bileklik","name":"Klasik","icon":"jt_br_classic"},"moldNo":null,"totalOrderQty":33,"orderQty":33,"bulkQuantity":40,"bulkQuantity2":50,"orderStatus":0,"variants":[{"variantId":11873,"totalCost":3.00,"weight":10.28,"image":"https://gbjblobnew2.blob.core.windows.net/productphoto/fashion-animal-angel-and-wings-moon-and-stars-evil-eye-classic-bracelets_27039_2.jpg","images":[{"imageId":27039,"image":"https://gbjblobnew2.blob.core.windows.net/productphoto/fashion-animal-angel-and-wings-moon-and-stars-evil-eye-classic-bracelets_27039_5.jpg","default":true,"sequence":0}],"itemId":1,"cost":3.00,"bulkCost":2.85,"bulkCost2":2.72,"variantOptions":[{"optionId":550,"optionGroupName":"Bileklik Ölçüsü","optionGroupId":41,"optionName":"Ayarlanabilir","icon":""},null],"quantity":33,"deliveredQuantity":0,"description":null,"productOrderCode":"16755","variantOrderStatus":0,"variantOrderStatusTR":0}]}]}]

class OrderResponse {
  bool _success;
  String  _message;
  List<OrderList> _orderList;

  String get message => _message;


  bool get success => _success;

  List<OrderList> get orderList => _orderList;

  OrderResponse({
      bool success, 
      List<OrderList> orderList}){
    _success = success;
    _orderList = orderList;
}

  OrderResponse.fromJson(dynamic json) {
    _success = json["success"];
    if (json["orderList"] != null) {
      _orderList = [];
      json["orderList"].forEach((v) {
        _orderList.add(OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    if (_orderList != null) {
      map["orderList"] = _orderList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// supplierOrderCode : 102
/// orderer : "GBJ"
/// orderDate : "2021-03-08T11:51:15.13"
/// date : null
/// supplierName : null
/// products : [{"productId":9628,"productCode":"GBJ3BR9628","jewelryType":{"jewelryTypeId":595,"parentName":"Bileklik","name":"Klasik","icon":"jt_br_classic"},"moldNo":null,"totalOrderQty":33,"orderQty":33,"bulkQuantity":40,"bulkQuantity2":50,"orderStatus":0,"variants":[{"variantId":11873,"totalCost":3.00,"weight":10.28,"image":"https://gbjblobnew2.blob.core.windows.net/productphoto/fashion-animal-angel-and-wings-moon-and-stars-evil-eye-classic-bracelets_27039_2.jpg","images":[{"imageId":27039,"image":"https://gbjblobnew2.blob.core.windows.net/productphoto/fashion-animal-angel-and-wings-moon-and-stars-evil-eye-classic-bracelets_27039_5.jpg","default":true,"sequence":0}],"itemId":1,"cost":3.00,"bulkCost":2.85,"bulkCost2":2.72,"variantOptions":[{"optionId":550,"optionGroupName":"Bileklik Ölçüsü","optionGroupId":41,"optionName":"Ayarlanabilir","icon":""},null],"quantity":33,"deliveredQuantity":0,"description":null,"productOrderCode":"16755","variantOrderStatus":0,"variantOrderStatusTR":0}]}]

class OrderList {
  int _supplierOrderCode;
  String _orderer;
  String _orderDate;
  dynamic _date;
  dynamic _supplierName;
  List<Products> _products;


  int get supplierOrderCode => _supplierOrderCode;

  set supplierOrderCode(int value) {
    _supplierOrderCode = value;
  }

  OrderList({
      int supplierOrderCode, 
      String orderer, 
      String orderDate, 
      dynamic date, 
      dynamic supplierName, 
      List<Products> products}){
    _supplierOrderCode = supplierOrderCode;
    _orderer = orderer;
    _orderDate = orderDate;
    _date = date;
    _supplierName = supplierName;
    _products = products;
}

  OrderList.fromJson(dynamic json) {
    _supplierOrderCode = json["supplierOrderCode"];
    _orderer = json["orderer"];
    _orderDate = json["orderDate"];
    _date = json["date"];
    _supplierName = json["supplierName"];
    if (json["products"] != null) {
      _products = [];
      json["products"].forEach((v) {
        _products.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["supplierOrderCode"] = _supplierOrderCode;
    map["orderer"] = _orderer;
    map["orderDate"] = _orderDate;
    map["date"] = _date;
    map["supplierName"] = _supplierName;
    if (_products != null) {
      map["products"] = _products.map((v) => v.toJson()).toList();
    }
    return map;
  }

  String get orderer => _orderer;

  set orderer(String value) {
    _orderer = value;
  }

  String get orderDate => _orderDate;

  set orderDate(String value) {
    _orderDate = value;
  }

  dynamic get date => _date;

  set date(dynamic value) {
    _date = value;
  }

  dynamic get supplierName => _supplierName;

  set supplierName(dynamic value) {
    _supplierName = value;
  }

  List<Products> get products => _products;

  set products(List<Products> value) {
    _products = value;
  }


}

/// productId : 9628
/// productCode : "GBJ3BR9628"
/// jewelryType : {"jewelryTypeId":595,"parentName":"Bileklik","name":"Klasik","icon":"jt_br_classic"}
/// moldNo : null
/// totalOrderQty : 33
/// orderQty : 33
/// bulkQuantity : 40
/// bulkQuantity2 : 50
/// orderStatus : 0
/// variants : [{"variantId":11873,"totalCost":3.00,"weight":10.28,"image":"https://gbjblobnew2.blob.core.windows.net/productphoto/fashion-animal-angel-and-wings-moon-and-stars-evil-eye-classic-bracelets_27039_2.jpg","images":[{"imageId":27039,"image":"https://gbjblobnew2.blob.core.windows.net/productphoto/fashion-animal-angel-and-wings-moon-and-stars-evil-eye-classic-bracelets_27039_5.jpg","default":true,"sequence":0}],"itemId":1,"cost":3.00,"bulkCost":2.85,"bulkCost2":2.72,"variantOptions":[{"optionId":550,"optionGroupName":"Bileklik Ölçüsü","optionGroupId":41,"optionName":"Ayarlanabilir","icon":""},null],"quantity":33,"deliveredQuantity":0,"description":null,"productOrderCode":"16755","variantOrderStatus":0,"variantOrderStatusTR":0}]

class Products {
  bool selected=false;
  int _productId;
  String _productCode;
  JewelryType _jewelryType;
  dynamic _moldNo;
  int _totalOrderQty;
  int _orderQty;
  int _bulkQuantity;
  int _bulkQuantity2;
  int _orderStatus;
  List<Variants> _variants;

  int get productId => _productId;
  String get productCode => _productCode;
  JewelryType get jewelryType => _jewelryType;
  dynamic get moldNo => _moldNo;
  int get totalOrderQty => _totalOrderQty;
  int get orderQty => _orderQty;
  int get bulkQuantity => _bulkQuantity;
  int get bulkQuantity2 => _bulkQuantity2;
  int get orderStatus => _orderStatus;

  set orderStatus(int value) {
    _orderStatus = value;
  }

  List<Variants> get variants => _variants;

  Products({
      int productId, 
      String productCode, 
      JewelryType jewelryType, 
      dynamic moldNo, 
      int totalOrderQty, 
      int orderQty, 
      int bulkQuantity, 
      int bulkQuantity2, 
      int orderStatus, 
      List<Variants> variants}){
    _productId = productId;
    _productCode = productCode;
    _jewelryType = jewelryType;
    _moldNo = moldNo;
    _totalOrderQty = totalOrderQty;
    _orderQty = orderQty;
    _bulkQuantity = bulkQuantity;
    _bulkQuantity2 = bulkQuantity2;
    _orderStatus = orderStatus;
    _variants = variants;
}

  Products.fromJson(dynamic json) {
    _productId = json["productId"];
    _productCode = json["productCode"];
    _jewelryType = json["jewelryType"] != null ? JewelryType.fromJson(json["jewelryType"]) : null;
    _moldNo = json["moldNo"];
    _totalOrderQty = json["totalOrderQty"];
    _orderQty = json["orderQty"];
    _bulkQuantity = json["bulkQuantity"];
    _bulkQuantity2 = json["bulkQuantity2"];
    _orderStatus = json["orderStatus"];
    if (json["variants"] != null) {
      _variants = [];
      json["variants"].forEach((v) {
        _variants.add(Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["productId"] = _productId;
    map["productCode"] = _productCode;
    if (_jewelryType != null) {
      map["jewelryType"] = _jewelryType.toJson();
    }
    map["moldNo"] = _moldNo;
    map["totalOrderQty"] = _totalOrderQty;
    map["orderQty"] = _orderQty;
    map["bulkQuantity"] = _bulkQuantity;
    map["bulkQuantity2"] = _bulkQuantity2;
    map["orderStatus"] = _orderStatus;
    if (_variants != null) {
      map["variants"] = _variants.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// variantId : 11873
/// totalCost : 3.00
/// weight : 10.28
/// image : "https://gbjblobnew2.blob.core.windows.net/productphoto/fashion-animal-angel-and-wings-moon-and-stars-evil-eye-classic-bracelets_27039_2.jpg"
/// images : [{"imageId":27039,"image":"https://gbjblobnew2.blob.core.windows.net/productphoto/fashion-animal-angel-and-wings-moon-and-stars-evil-eye-classic-bracelets_27039_5.jpg","default":true,"sequence":0}]
/// itemId : 1
/// cost : 3.00
/// bulkCost : 2.85
/// bulkCost2 : 2.72
/// variantOptions : [{"optionId":550,"optionGroupName":"Bileklik Ölçüsü","optionGroupId":41,"optionName":"Ayarlanabilir","icon":""},null]
/// quantity : 33
/// deliveredQuantity : 0
/// description : null
/// productOrderCode : "16755"
/// variantOrderStatus : 0
/// variantOrderStatusTR : 0

class Variants {
  int _variantId;
  double _totalCost;
  double _weight;
  String _image;
  List<Images> _images;
  int _itemId;
  int _packageCount;
  double _cost;
  double _bulkCost;
  double _bulkCost2;
  List<VariantOptions> _variantOptions;
  List<VariantOptions> _orderoptions;

  List<VariantOptions> get orderoptions => _orderoptions;


  int _quantity;
  int _deliveredQuantity;
  dynamic _description;
  String _productOrderCode;
  int _variantOrderStatus;
  int _variantOrderStatusTR;

  int get variantId => _variantId;
  int get packageCount => _packageCount;
  double get totalCost => _totalCost;
  double get weight => _weight;
  String get image => _image;
  List<Images> get images => _images;
  int get itemId => _itemId;
  double get cost => _cost;
  double get bulkCost => _bulkCost;
  double get bulkCost2 => _bulkCost2;
  List<VariantOptions> get variantOptions => _variantOptions;
  int get quantity => _quantity;
  int get deliveredQuantity => _deliveredQuantity;
  dynamic get description => _description;
  String get productOrderCode => _productOrderCode;
  int get variantOrderStatus => _variantOrderStatus;
  int get variantOrderStatusTR => _variantOrderStatusTR;

  Variants({
      int variantId, 
      double totalCost, 
      double weight, 
      String image, 
      List<Images> images, 
      int itemId, 
      double cost, 
      double bulkCost, 
      double bulkCost2, 
      List<VariantOptions> variantOptions, 
      int quantity, 
      int deliveredQuantity, 
      dynamic description, 
      String productOrderCode, 
      int variantOrderStatus, 
      int variantOrderStatusTR}){
    _variantId = variantId;
    _totalCost = totalCost;
    _weight = weight;
    _image = image;
    _images = images;
    _itemId = itemId;
    _cost = cost;
    _bulkCost = bulkCost;
    _bulkCost2 = bulkCost2;
    _variantOptions = variantOptions;
    _quantity = quantity;
    _deliveredQuantity = deliveredQuantity;
    _description = description;
    _productOrderCode = productOrderCode;
    _variantOrderStatus = variantOrderStatus;
    _variantOrderStatusTR = variantOrderStatusTR;
}

  Variants.fromJson(dynamic json) {
    _variantId = json["variantId"];
    _totalCost = json["totalCost"];
    _weight = json["weight"];
    _packageCount = json["packageCount"];
    _image = json["image"];
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images.add(Images.fromJson(v));
      });
    }
    _itemId = json["itemId"];
    _cost = json["cost"];
    _bulkCost = json["bulkCost"];
    _bulkCost2 = json["bulkCost2"];
    if (json["variantOptions"] != null) {
      _variantOptions = [];
      json["variantOptions"].forEach((v) {
        _variantOptions.add(VariantOptions.fromJson(v));
      });
    }
    if (json["orderOptions"] != null) {
      _orderoptions = [];
      json["orderOptions"].forEach((v) {
        _orderoptions.add(VariantOptions.fromJson(v));
      });
    }
    _quantity = json["quantity"];
    _deliveredQuantity = json["deliveredQuantity"];
    _description = json["description"];
    _productOrderCode = json["productOrderCode"];
    _variantOrderStatus = json["variantOrderStatus"];
    _variantOrderStatusTR = json["variantOrderStatusTR"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["variantId"] = _variantId;
    map["totalCost"] = _totalCost;
    map["weight"] = _weight;
    map["image"] = _image;
    if (_images != null) {
      map["images"] = _images.map((v) => v.toJson()).toList();
    }
    map["itemId"] = _itemId;
    map["cost"] = _cost;
    map["bulkCost"] = _bulkCost;
    map["bulkCost2"] = _bulkCost2;
    if (_variantOptions != null) {
      map["variantOptions"] = _variantOptions.map((v) => v.toJson()).toList();
    }
    map["quantity"] = _quantity;
    map["deliveredQuantity"] = _deliveredQuantity;
    map["description"] = _description;
    map["productOrderCode"] = _productOrderCode;
    map["variantOrderStatus"] = _variantOrderStatus;
    map["variantOrderStatusTR"] = _variantOrderStatusTR;
    return map;
  }

}

/// optionId : 550
/// optionGroupName : "Bileklik Ölçüsü"
/// optionGroupId : 41
/// optionName : "Ayarlanabilir"
/// icon : ""

class VariantOptions {
  int _optionId;
  String _optionGroupName;
  int _optionGroupId;
  String _optionName;
  String _icon;
  bool _costumize;

  int get optionId => _optionId;

  String get optionGroupName => _optionGroupName;

  int get optionGroupId => _optionGroupId;

  String get optionName => _optionName;

  String get icon => _icon;

  bool get costumize => _costumize;

  VariantOptions({
      int optionId, 
      String optionGroupName, 
      int optionGroupId, 
      String optionName, 
      String icon})

  {
    _optionId = optionId;
    _costumize = costumize;
    _optionGroupName = optionGroupName;
    _optionGroupId = optionGroupId;
    _optionName = optionName;
    _icon = icon;
}

  VariantOptions.fromJson(dynamic json) {
    _optionId = json["optionId"];
    _optionGroupName = json["optionGroupName"];
    _optionGroupId = json["optionGroupId"];
    _optionName = json["optionName"];
    _costumize = json["customize"];
    _icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["optionId"] = _optionId;
    map["optionGroupName"] = _optionGroupName;
    map["optionGroupId"] = _optionGroupId;
    map["optionName"] = _optionName;
    map["icon"] = _icon;
    return map;
  }

}

/// imageId : 27039
/// image : "https://gbjblobnew2.blob.core.windows.net/productphoto/fashion-animal-angel-and-wings-moon-and-stars-evil-eye-classic-bracelets_27039_5.jpg"
/// default : true
/// sequence : 0

class Images {
  int _imageId;
  String _image;
  bool _defaultt;
  int _sequence;

  int get imageId => _imageId;
  String get image => _image;
  bool get defaultt => _defaultt;
  int get sequence => _sequence;

  Images({
      int imageId, 
      String image, 
      bool defaultt,
      int sequence}){
    _imageId = imageId;
    _image = image;
    _defaultt = defaultt;
    _sequence = sequence;
}

  Images.fromJson(dynamic json) {
    _imageId = json["imageId"];
    _image = json["image"];
    _defaultt = json["default"];
    _sequence = json["sequence"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["imageId"] = _imageId;
    map["image"] = _image;
    map["default"] = _defaultt;
    map["sequence"] = _sequence;
    return map;
  }

}

/// jewelryTypeId : 595
/// parentName : "Bileklik"
/// name : "Klasik"
/// icon : "jt_br_classic"

class JewelryType {
  int _jewelryTypeId;
  String _parentName;
  String _name;
  String _icon;

  int get jewelryTypeId => _jewelryTypeId;
  String get parentName => _parentName;
  String get name => _name;
  String get icon => _icon;

  JewelryType({
      int jewelryTypeId, 
      String parentName, 
      String name, 
      String icon}){
    _jewelryTypeId = jewelryTypeId;
    _parentName = parentName;
    _name = name;
    _icon = icon;
}

  JewelryType.fromJson(dynamic json) {
    _jewelryTypeId = json["jewelryTypeId"];
    _parentName = json["parentName"];
    _name = json["name"];
    _icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["jewelryTypeId"] = _jewelryTypeId;
    map["parentName"] = _parentName;
    map["name"] = _name;
    map["icon"] = _icon;
    return map;
  }

}