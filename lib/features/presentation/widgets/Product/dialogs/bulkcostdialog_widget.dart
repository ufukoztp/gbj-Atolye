import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

Future<double> asyncBulkCostInputDialog({BuildContext context,double bulkCost}) async {

  var controller = new MoneyMaskedTextController(initialValue: bulkCost);

  return showDialog<double>(
    context: context,
    barrierDismissible: true,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {

      return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Text("1. Toplu Satış Fiyatı",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left:15.0,right:15.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20.0),
                    counterText: "",
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  style: Theme.of(context).textTheme.headline4,
                  autofocus: true,
                  onChanged: (value) {
                    bulkCost = controller.numberValue;
                  },
                ),
              ),

              ///Button
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: InkWell(
                          child: Container(
                            height: 50,
                            decoration: new BoxDecoration(
                                gradient: LinearGradient(colors: <Color>[
                                  AppTheme.aqua[50],
                                  AppTheme.azureRadiance[50],
                                ]),
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(50.0),
                                  bottomRight: const Radius.circular(50.0),
                                )),
                            child: Center(
                              child: Text(
                                  AppLocalizations.of(context).txtBtnSave,
                                  style: Theme.of(context).textTheme.button,
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(bulkCost);
                          },
                        )),
                  ],
                ),
              )
            ],
          ));

      /*
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Text(AppLocalizations.of(context).txtLblPrice,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center),
          content: Container(
              width: 300,
              height: 100,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Expanded(
                      child: new TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          counterText: "",
                        ),
                        keyboardType: TextInputType.number,
                        cursorColor: AppTheme.shark[50],
                        maxLength: 12,
                        style: Theme.of(context).textTheme.display1,
                        autofocus: true,
                        onChanged: (value) {
                          price = controller.numberValue;
                        },
                      )),
                  GestureDetector(
                      child: new Container(
                          color: AppTheme.darkTangerine[50],
                          margin: new EdgeInsets.only(top: 20.0),
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                    AppLocalizations.of(context).txtBtnSave,
                                    style: Theme.of(context).textTheme.button),
                              ),
                            ],
                          )),
                      onTap: () async {
                        Navigator.of(context).pop(price);
                      })
                ],
              )));

       */
    },
  );
}
Future<double> asyncBulkCostInputDialog2({BuildContext context,double bulkCost2}) async {

  var controller = new MoneyMaskedTextController(initialValue: bulkCost2);;

  return showDialog<double>(
    context: context,
    barrierDismissible: true,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {

      return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Text("2. Toplu Satış Fiyatı",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left:15.0,right:15.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 20.0),
                    counterText: "",
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 12,
                  style: Theme.of(context).textTheme.headline4,
                  autofocus: true,
                  onChanged: (value) {
                    bulkCost2 = controller.numberValue;
                  },
                ),
              ),

              ///Button
              Container(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: InkWell(
                          child: Container(
                            height: 50,
                            decoration: new BoxDecoration(
                                gradient: LinearGradient(colors: <Color>[
                                  AppTheme.aqua[50],
                                  AppTheme.azureRadiance[50],
                                ]),
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(50.0),
                                  bottomRight: const Radius.circular(50.0),
                                )),
                            child: Center(
                              child: Text(
                                  AppLocalizations.of(context).txtBtnSave,
                                  style: Theme.of(context).textTheme.button,
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(bulkCost2);
                          },
                        )),
                  ],
                ),
              )
            ],
          ));

      /*
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Text(AppLocalizations.of(context).txtLblPrice,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center),
          content: Container(
              width: 300,
              height: 100,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Expanded(
                      child: new TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          counterText: "",
                        ),
                        keyboardType: TextInputType.number,
                        cursorColor: AppTheme.shark[50],
                        maxLength: 12,
                        style: Theme.of(context).textTheme.display1,
                        autofocus: true,
                        onChanged: (value) {
                          price = controller.numberValue;
                        },
                      )),
                  GestureDetector(
                      child: new Container(
                          color: AppTheme.darkTangerine[50],
                          margin: new EdgeInsets.only(top: 20.0),
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                    AppLocalizations.of(context).txtBtnSave,
                                    style: Theme.of(context).textTheme.button),
                              ),
                            ],
                          )),
                      onTap: () async {
                        Navigator.of(context).pop(price);
                      })
                ],
              )));

       */
    },
  );
}