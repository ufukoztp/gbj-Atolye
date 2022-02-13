import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<MessageDialogTypes> asyncFilterMessageDialog(
    BuildContext context, DialogType dialogType, String message) async {

  var barrierDisable = false;
  var visibleButtons = false;
  var buttonOkText = "";
  var buttonCancelText = "";

  if (dialogType == DialogType.ExitAccount ||
      dialogType == DialogType.BackWidget) {
    barrierDisable = true;
    visibleButtons = true;
    buttonOkText = AppLocalizations.of(context).txtBtnLogout;
    buttonCancelText = AppLocalizations.of(context).txtBtnReject;
  } else if (dialogType == DialogType.RemoveProduct) {
    barrierDisable = true;
    visibleButtons = true;
    buttonOkText = AppLocalizations.of(context).txtBtnDelete;
    buttonCancelText = AppLocalizations.of(context).txtBtnCancel;
  } else if (dialogType == DialogType.AddMoreProduct || dialogType == DialogType.DetailWaitLike) {
    barrierDisable = true;
    visibleButtons = true;
    if (dialogType == DialogType.DetailWaitLike)
      buttonOkText = AppLocalizations.of(context).txtBtnGotIt;
    else if (dialogType == DialogType.AddMoreProduct) {
      buttonOkText = "EKLE";//AppLocalizations.of(context).txtBtnUploadPhotoContinue;
      buttonCancelText = "ÇIK";//AppLocalizations.of(context).txtBtnBack;
    }
  } else if (dialogType == DialogType.Permissions) {
    barrierDisable = false;
    visibleButtons = true;
    buttonOkText = "AYARLAR";
    buttonCancelText = "ÇIK";
  }

  Widget _buttons(DialogType dialogType) {
    if (DialogType.DetailWaitLike != dialogType) {
      return Visibility(
          visible: visibleButtons,
          child: Container(
            padding: EdgeInsets.all(0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(MessageDialogTypes.CANCEL);
                  },
                  child: Container(
                    height: 50,
                    decoration: new BoxDecoration(
                        color: AppTheme.grey[50],
                        borderRadius: new BorderRadius.only(
                            bottomLeft: const Radius.circular(50.0))),
                    child: Center(
                      child: Text(buttonCancelText.toUpperCase(),
                          style: Theme.of(context).textTheme.button,
                          textAlign: TextAlign.center),
                    ),
                  ),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(MessageDialogTypes.OK);
                  },
                  child: Container(
                    height: 50,
                    decoration: new BoxDecoration(
                        gradient: LinearGradient(colors: <Color>[
                          AppTheme.aqua[50],
                          AppTheme.azureRadiance[50],
                        ]),
                        borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(50.0))),
                    child: Center(
                      child: Text(buttonOkText.toUpperCase(),
                          style: Theme.of(context).textTheme.button,
                          textAlign: TextAlign.center),
                    ),
                  ),
                ))
              ],
            ),
          ));
    } else {
      return Container(
        padding: EdgeInsets.all(0),
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
                  child: Text(buttonOkText.toUpperCase(),
                      style: Theme.of(context).textTheme.button,
                      textAlign: TextAlign.center),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop(MessageDialogTypes.OK);
              },
            )),
          ],
        ),
      );
    }
  }

  return showDialog<MessageDialogTypes>(
    context: context,
    barrierDismissible: barrierDisable,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.lightGrey[50],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
                child: Text(message,
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center),
              ),
              _buttons(dialogType)
            ],
          ));
    },
  );
}
