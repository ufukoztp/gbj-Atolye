
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class CostTypeDialog extends StatefulWidget {

 int costType;
 String radioText1;
 String radioText2;

   CostTypeDialog({Key key, this.costType,this.radioText1,this.radioText2}) : super(key: key);

  @override
  _CostTypeDialogState createState() => new _CostTypeDialogState();
}

class _CostTypeDialogState extends State<CostTypeDialog> {
  int selected;

  changedValue(val) {
    setState(() {
      selected = val;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
selected=widget.costType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SingleChildScrollView(child:
        Column(
          children: [ Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(widget.radioText1),
                  ),
                 Radio(
                      activeColor: AppTheme.bigStone[50],
                      value: 0,
                      groupValue: selected,
                      onChanged: (value) {
                        changedValue(value);
                        print(selected);
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(widget.radioText2),
                  ),
                 Radio(
                      activeColor: AppTheme.bigStone[50],
                      value: 1,
                      groupValue: selected,
                      onChanged: (value) {
                        changedValue(value);
                        print(selected);
                      })
                ],
              ),
              Divider()
            ],
          )]



        ),
        ),

        ///Button
        Container(
          padding: EdgeInsets.only(top:0.0),
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

                        Navigator.of(context).pop(selected);

                      }

                  )),
            ],
          ),
        ),
      ],
    );
  }
}




Future<int> asyncCstTypeInputDialog({BuildContext context,int costTpye,String radioText1,String radioText2}) async {
  return showDialog<int>(
    context: context,
    barrierDismissible: true,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Text('Fiyat Tipi',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center),
      content:    CostTypeDialog(costType: costTpye,radioText1: radioText1,radioText2: radioText2,));

      /*
      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Text(AppLocalizations.of(context).txtLblWeight,
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
                        style: Theme.of(context).textTheme.display1,
                        maxLength: 12,
                        autofocus: true,
                        onChanged: (value) {
                          weight = controller.numberValue;
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
                        Navigator.of(context).pop(weight);
                      })
                ],
              )));*/
    },
  );
}