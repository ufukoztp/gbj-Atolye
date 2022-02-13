import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<OptionsDialogButton> asyncOptionsDialog({
    BuildContext context,
    OptionsDialogType optionsDialogType,
    String title,
    int selectedOptionIndex
}) async {
  var barrierDisable = true;

  List<String> options = List<String>();

  if (optionsDialogType == OptionsDialogType.ProductSaleStatusChange) {
    options.add(AppLocalizations.of(context).txtBtnEnableForSale);
    options.add(AppLocalizations.of(context).txtBtnDisableForSale);
    options.add(AppLocalizations.of(context).txtBtnProductRemove);
  } else if (optionsDialogType == OptionsDialogType.ProductSortBy) {
    options.add(AppLocalizations.of(context).txtBtnSortByAddedDate);
    options.add(AppLocalizations.of(context).txtBtnSortByLikeCount);
    options.add(AppLocalizations.of(context).txtBtnSortByEditedDate);
  }else if(optionsDialogType == OptionsDialogType.OrderProductStatusChange) {
    options.add(AppLocalizations.of(context).txtTabsWaitingOrders);
    options.add(AppLocalizations.of(context).txtTabsManufacturingOrders);
    options.add(AppLocalizations.of(context).txtTabsReadyOrders);
    options.add(AppLocalizations.of(context).txtTabsProblematicOrders);
  }

  // ignore: missing_return
  OptionsDialogButton tap(index) {
    if (optionsDialogType == OptionsDialogType.ProductSaleStatusChange) {
      switch (index) {
        case 0:
          Navigator.of(context).pop(OptionsDialogButton.Active);
          break;
        case 1:
          Navigator.of(context).pop(OptionsDialogButton.DeActive);
          break;
        case 2:
          Navigator.of(context).pop(OptionsDialogButton.Remove);
          break;
      }
    } else if (optionsDialogType == OptionsDialogType.ProductSortBy) {

        switch (index) {
          case 0:
            Navigator.of(context).pop(OptionsDialogButton.OrderByAddedDate);
            break;
          case 1:
            Navigator.of(context).pop(OptionsDialogButton.OrderByLikeCount);
            break;
          case 2:
            Navigator.of(context).pop(OptionsDialogButton.OrderByEditStatus);
            break;
        }

    } else if (optionsDialogType == OptionsDialogType.OrderProductStatusChange) {

      switch (index) {
        case 0:
          Navigator.of(context).pop(OptionsDialogButton.OrderProductWaiting);
          break;
        case 1:
          Navigator.of(context).pop(OptionsDialogButton.OrderProductProduction);
          break;
        case 2:
          Navigator.of(context).pop(OptionsDialogButton.OrderProductReady);
          break;
        case 3:
          Navigator.of(context).pop(OptionsDialogButton.OrderProductNoProduction);
          break;
      }

    }


  }

  return showDialog<OptionsDialogButton>(
    context: context,
    barrierDismissible: barrierDisable,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.lightGrey[50],
          content: Container(
            width: 300,
            child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding:
                      EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
                      child: Text(title,
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var item = options[index];
                          return ListTile(
                              title: Center(
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        color: selectedOptionIndex != index && optionsDialogType == OptionsDialogType.ProductSortBy
                                            ? AppTheme.riverBed[50]
                                            : AppTheme.bigStone[50],
                                        fontSize: 15.0,
                                        fontFamily: selectedOptionIndex != index && optionsDialogType == OptionsDialogType.ProductSortBy
                                            ? 'MontserratSemiBold'
                                            : 'MontserratBold',),
                                  )),
                              onTap: () => tap(index));
                        },
                        itemCount: options.length,
                      ),
                    )
                  ],
                ))),
          );
    },
  );
}
