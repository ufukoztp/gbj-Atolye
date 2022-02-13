class OrderStatusRequest {
  List<Model> model;

  OrderStatusRequest({this.model});

  OrderStatusRequest.fromJson(Map<String, dynamic> json) {
    if (json['model'] != null) {
      model = new List<Model>();
      json['model'].forEach((v) {
        model.add(new Model.fromJson(v));
      });
    }
  }

  List<Map<String, dynamic>> toJson() {
   List<Map<String, dynamic>>  data = new List<Map<String, dynamic>> ();
    if (this.model != null) {
      data= this.model.map((v) => v.toJson()).toList()  ;
    }
    return data;
  }
}

class Model {
  int status;
  int supplierOrderId;
  List<VariantsNew> variants;

  Model({this.status, this.supplierOrderId, this.variants});

  Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    supplierOrderId = json['supplierOrderId'];
    if (json['variants'] != null) {
      variants = new List<VariantsNew>();
      json['variants'].forEach((v) {
        variants.add(new VariantsNew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['supplierOrderId'] = this.supplierOrderId;
    if (this.variants != null) {
      data['variants'] = this.variants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariantsNew {
  int variantId;
  int itemId;

  VariantsNew({this.variantId, this.itemId});

  VariantsNew.fromJson(Map<String, dynamic> json) {
    variantId = json['variantId'];
    itemId = json['itemId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantId'] = this.variantId;
    data['itemId'] = this.itemId;
    return data;
  }
}