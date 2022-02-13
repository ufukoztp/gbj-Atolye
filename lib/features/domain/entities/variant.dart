import 'package:gbjatolye/features/domain/entities/variantimage.dart';
import 'package:flutter/cupertino.dart';

class Variant {
  int variantId;
  int atolyeminProductId;
  int gbjVariantId;
  int gBJExVariantId;
  double weight;
  double silverWeight;
  double goldWeight;
  double totalDiamondWeight;
  double gemstoneWeight;
  double roseCutDiamondWeight;
  double cost;
  double extraCost;
  double totalCost;
  double bulkCost;
  double bulkCost2;
  double totalBulkCost;
  double totalBulkCost2;
  bool defaultVariant;
  bool pure;
  int millesimal;
  String image;
  List<VariantImage> images;
  bool enabled;
  bool jewelryBoxEnabled;
  String updateDate;
  String createDate;
  int mixQuantity;
  bool enableForSale;
  bool selected = false;
  int likeCount;
  bool productCompleted;
  bool indicatorVariant;

  Variant({
    @required this.variantId,
    @required this.atolyeminProductId,
    @required this.gbjVariantId,
    @required this.gBJExVariantId,
    @required this.weight,
    @required this.silverWeight,
    @required this.goldWeight,
    @required this.totalDiamondWeight,
    @required this.gemstoneWeight,
    @required this.roseCutDiamondWeight,
    @required this.cost,
    @required this.extraCost,
    @required this.totalCost,
    @required this.bulkCost,
    @required this.bulkCost2,
    @required this.totalBulkCost,
    @required this.totalBulkCost2,
    @required this.defaultVariant,
    @required this.pure,
    @required this.millesimal,
    @required this.image,
    @required this.images,
    @required this.enabled,
    @required this.jewelryBoxEnabled,
    @required this.updateDate,
    @required this.createDate,
    @required this.mixQuantity,
    @required this.enableForSale,
    @required this.likeCount,
    @required this.productCompleted,
    @required this.indicatorVariant
  });
}
