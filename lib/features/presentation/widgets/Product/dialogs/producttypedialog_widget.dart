import 'dart:collection';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductTypeDialogContent extends StatefulWidget {
  int packageCount;
  int radioValue;

  ProductTypeDialogContent({
    Key key,
    this.packageCount,
    this.radioValue,
  }) : super(key: key);

  @override
  _ProductTypeDialogContentState createState() =>
      new _ProductTypeDialogContentState();
}

class _ProductTypeDialogContentState extends State<ProductTypeDialogContent> {
  TextEditingController _packageController;

  @override
  void initState() {
    super.initState();
    _packageController = new TextEditingController(
        text: widget.packageCount == 0 ? "" : widget.packageCount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }



  _getContent() {
    return Column(
      children: <Widget>[

        ///Single Product
        Row(
          children: <Widget>[
            new Radio(
              value: 0,
              activeColor: AppTheme.azureRadiance[50],
              groupValue: widget.radioValue,
              onChanged: (value) {
                setState(() {
                  widget.radioValue = value;
                });
              },
            ),
            Expanded(
              child: InkWell(
                child: Container(
                  height: 50.0,
                  width: double.minPositive,
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    AppLocalizations.of(context).txtLblSingleProduct,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                onTap: () {
                  setState(() {
                    widget.radioValue = 0;
                  });
                },
              ),
            )
          ],
        ),

        ///Package Product
        Row(
          children: <Widget>[
            new Radio(
              value: 1,
              activeColor: AppTheme.azureRadiance[50],
              groupValue: widget.radioValue,
              onChanged: (value) {
                setState(() {
                  widget.radioValue = value;
                });
              },
            ),
            Expanded(
              child: InkWell(
                child: Container(
                  height: 50.0,
                  width: double.minPositive,
                  alignment: Alignment.centerLeft,
                  child: new Text(
                      AppLocalizations.of(context).txtLblPackageProduct,
                      style: Theme.of(context).textTheme.headline4),
                ),
                onTap: () {
                  setState(() {
                    widget.radioValue = 1;
                  });
                },
              ),
            )
          ],
        ),

        ///Package Product Count
        Visibility(
          visible: widget.radioValue == 0 ? false : true,
          child: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                      child: new Container(
                        child: Center(
                          child: TextFormField(
                            controller: _packageController,
                            style: Theme.of(context).textTheme.headline4,
                            //inputFormatters: [maskFormatter],
                            validator: (String arg) {
                              if (arg.isEmpty || int.parse(arg) < 2)
                                return AppLocalizations.of(context)
                                    .txtErMinPackageProductCount;
                              else
                                return null;
                            },
                            autofocus: true,
                            keyboardType:
                            TextInputType.numberWithOptions(decimal: false),
                            decoration: new InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10.0),
                                labelText: AppLocalizations.of(context)
                                    .txtLblPackageProductCount,
                                errorStyle: Theme.of(context).textTheme.headline2,
                                labelStyle: Theme.of(context).textTheme.headline1,
                                alignLabelWithHint: true,
                                counterText: ""),
                          ),
                        ),
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                      ))
                ],
              )),
        )

      ],
    );
  }

}

GlobalKey<FormState> _packageCountFormKey;

bool autoValidate;

bool _validatePackageCountInput() {
  if (_packageCountFormKey.currentState.validate()) {
    _packageCountFormKey.currentState.save();
    return true;
  } else {
    autoValidate = true;
    return false;
  }
}



Future<HashMap<bool, int>> asyncProductTypeInputDialog(
    BuildContext context, int packageCount) async {
  autoValidate = false;

  ///Form Control
  _packageCountFormKey = GlobalKey<FormState>();

  ///Input Control
  final key = new GlobalKey<_ProductTypeDialogContentState>();

  return showDialog<HashMap<bool, int>>(
    context: context,
    barrierDismissible: true,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Text(AppLocalizations.of(context).txtLblProductType,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _packageCountFormKey,
                // ignore: deprecated_member_use
               // autovalidateMode: autoValidate,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ///Product dialog content


                    ProductTypeDialogContent(
                        key: key,
                        packageCount: packageCount,
                        radioValue: packageCount > 0 ? 1 : 0),


                  ],
                ),
              ),

              ///Button
              Container(
                padding: EdgeInsets.only(top: 20.0),
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
                          child: Text(AppLocalizations.of(context).txtBtnSave,
                              style: Theme.of(context).textTheme.button,
                              textAlign: TextAlign.center),
                        ),
                      ),
                      onTap: () {
                        if (_validatePackageCountInput()) {
                          HashMap<bool, int> result = HashMap<bool, int>();

                          bool ispackage = false;
                          int packagequantity = 0;

                          if (key.currentState.widget.radioValue == 1) {
                            ispackage = true;
                            packagequantity = int.parse(
                                key.currentState._packageController.text);
                          }
                          result[ispackage] = packagequantity;
                          Navigator.of(context).pop(result);
                        }
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
          title: Text(AppLocalizations.of(context).txtLblProductType,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center),
          content: Container(
              width: 300.0,
              //height: 250.0,
              child:
              new Form(
                key: _packageCountFormKey,
                autovalidate: autoValidate,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    ///Product dialog content
                    ProductTypeDialogContent(
                        key: key,
                        packageCount: packageCount,
                        radioValue: packageCount > 0 ? 1 : 0),

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
                                      style:
                                          Theme.of(context).textTheme.button),
                                ),
                              ],
                            )),
                        onTap: () async {

                          if (_validatePackageCountInput()) {

                            HashMap<bool, int> result = HashMap<bool, int>();

                            bool ispackage=false;
                            int packagequantity = 0;

                            if (key.currentState.widget.radioValue == 1) {
                              ispackage = true;
                              packagequantity = int.parse(key.currentState._packageController.text);
                            }

                            result[ispackage] = packagequantity;
                            Navigator.of(context).pop(result);
                          }

                        })
                  ],
                ),
              )
          ));
             */
    },
  );
}
