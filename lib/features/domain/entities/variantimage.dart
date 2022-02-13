import 'package:flutter/cupertino.dart';

class VariantImage {
  int imageId;
  String image;
  bool defaults;
  int sequence;

  VariantImage(
      {
      @required this.imageId,
      @required this.image,
      @required this.defaults,
      @required this.sequence
      });
}
