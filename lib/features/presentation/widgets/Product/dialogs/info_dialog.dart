import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

Future asyncInfoDialog({BuildContext context}) async {


  return showDialog(
    context: context,
    barrierDismissible: true,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {

      return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Stack(
            children: [
              Center(
                child: Text('BİLGİ',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.clear,color:Theme.of(context).textTheme.headline6.color ,)))
            ],
          ),
          content: Padding(
            padding: EdgeInsets.only(top:15.0,left:15.0,right:15.0,bottom: 25.0),
            child: Text(''
                ''
                'Minimum Satış Adeti; bu üründen verilebilecek en az sipariş adeti.\n \n'
                '- Toplu Satış Fiyatı 1; toplu alımlarda müşteriye sunabileceğiniz en az sipariş adeti ve indirimli fiyatı \n \n'
                ''
                '- Toplu Satış Fiyatı 2; toplu alımlarda müşteriye sunabileceğiniz en iyi indirimli (son) fiyat.'

            )
          ));

     },
  );
}