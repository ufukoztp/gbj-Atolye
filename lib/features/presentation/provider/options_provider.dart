
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class OptionsUseCases {


}

class OptionPageProvider with ChangeNotifier implements OptionsUseCases {
  List<bool> optionsChanged=List.generate(40, (index) => false);
  optionsChangedd(bool value,index){
    optionsChanged[index] =value;
    notifyListeners();
  }


}


