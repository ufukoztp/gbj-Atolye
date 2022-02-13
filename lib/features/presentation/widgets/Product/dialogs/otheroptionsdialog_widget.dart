import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> otherOptionsDialog({BuildContext context,double bulkCost2,OtherOptionsType inputtype,String subCategoryName}) async {
  OtherOptionsType type=inputtype;
  String description=type==OtherOptionsType.otherOptions?"Daha fazla ürün özelliği eklemek ister misiniz?":"Bu ürünü farklı seçeneklerle sunmak ister misiniz?";
  String buttonYes=type==OtherOptionsType.otherOptions?"Evet":"Seçenekleri gir";
  String buttonNo=type==OtherOptionsType.otherOptions?"Hayır":"Atla";

  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {

      return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(40),
                child:Text(description,style: Theme.of(context).textTheme.headline3,),
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
                                color: Colors.grey,
                                borderRadius: new BorderRadius.only(
                                  bottomLeft: const Radius.circular(50.0),
                                  bottomRight: const Radius.circular(0),
                                )),
                            child: Center(
                              child: Text(buttonNo,
                                  style: Theme.of(context).textTheme.button,
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(false);

                          },
                        )),
                    SizedBox(
                      width: 2,
                    ),
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
                                    bottomLeft: const Radius.circular(0),
                                    bottomRight: const Radius.circular(50.0),
                                  )),
                              child: Center(
                                child: Text(buttonYes,
                                    style: Theme.of(context).textTheme.button,
                                    textAlign: TextAlign.center),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop(true);

                            }

                        )),
                  ],
                ),
              ),
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