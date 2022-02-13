import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/material.dart';

Future<String> asyncNoteDialog({BuildContext context, String note}) async {
  var _noteController;

  if (note != null && note != "null" && note != "")
    _noteController = TextEditingController(text: note);
  else
    _noteController = TextEditingController();

  return showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Text(AppLocalizations.of(context).txtLblNote,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(left:15.0,right:15.0),
                child: TextFormField(
                  controller: _noteController,
                  maxLength: 140,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.headline4,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 20.0),
                      counterStyle: Theme.of(context).textTheme.headline3,
                      hintText: AppLocalizations.of(context).txtLblNote,
                      hintStyle: Theme.of(context).textTheme.headline4),
                  maxLines: null,
                  autofocus: true,
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
                          child: Text(AppLocalizations.of(context).txtBtnSave,
                              style: Theme.of(context).textTheme.button,
                              textAlign: TextAlign.center),
                        ),
                      ),
                      onTap: () {
                        note = _noteController.text.toString();
                        Navigator.of(context).pop(note);
                      },
                    )),
                  ],
                ),
              )
            ],
          ));
      /*
      return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Text(AppLocalizations.of(context).txtLblNote,
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center),
          content: Container(
              width: 300,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new TextFormField(
                    controller: _noteController,
                    maxLength: 140,
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.display1,
                    decoration: InputDecoration(
                        counterStyle: Theme.of(context).textTheme.display2,
                        hintText: AppLocalizations.of(context).txtLblNote,
                        hintStyle: Theme.of(context).textTheme.display1),
                    maxLines: null,
                    autofocus: true,
                  ),
                  GestureDetector(
                      child: new Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: <Color>[
                              AppTheme.aqua[50],
                              AppTheme.azureRadiance[50],
                            ]),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
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
                        note = _noteController.text.toString();
                        Navigator.of(context).pop(note);
                      })
                ],
              )));

       */
    },
  );
}
