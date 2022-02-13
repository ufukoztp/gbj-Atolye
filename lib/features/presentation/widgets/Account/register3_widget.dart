import 'package:gbjatolye/features/presentation/provider/register3_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Register3Widget extends StatelessWidget {

  Register3Provider register3Provider;
  final useCases;

  Register3Widget(
      {Key key, @required this.register3Provider, @required this.useCases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return new Form(
        key: register3Provider.register3FormKey,
        // ignore: deprecated_member_use
       // autovalidate: register3Provider.autoValidate,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            //Country Name
           new Container(
              margin: EdgeInsets.only(top:20.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).txtLblCountry,
                    style: TextStyle(fontSize: 10.0,
                        fontFamily: 'MontserratSemiBold',
                        color: AppTheme.riverBed[50]),
                    textAlign: TextAlign.left,
                  ),
                  new CountryCodePicker(
                      onChanged: (code) {
                        register3Provider.countryCode=int.parse(code.dialCode);
                        register3Provider.countryName=code.name;
                      },
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'TR',
                      //favorite: ['+39','FR'],
                      // optional. Shows only country name and flag
                      showCountryOnly: true,
                      textStyle: Theme.of(context).textTheme.headline1,
                      // optional. Shows only country name and flag when popup is closed.
                      showOnlyCountryWhenClosed: true,
                      // optional. aligns the flag and the Text left
                      alignLeft: true,
                      onInit : (code){}
                  )
                ],
              ),
            ),


            //City Name
            new Stack(alignment: const Alignment(1.0, 1.0), children: <Widget>[
              new Container(
                child: TextFormField(
                    controller: register3Provider.cityController,
                    style: Theme.of(context).textTheme.headline4,
                    validator: (String arg) {
                      if (arg.length<3)
                        return AppLocalizations.of(context).txtErMissCharacter;
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10.0),
                        labelText: AppLocalizations.of(context).txtLblProvince,
                        errorStyle: Theme.of(context).textTheme.headline2,
                        labelStyle: Theme.of(context).textTheme.headline1,
                        alignLabelWithHint: true,
                        counterText: ""),
                    maxLines: 1,
                    maxLength: 100,
                    onChanged: (e) {}),
                width: double.maxFinite,
              ),
            ]),


            //Adress
            new Stack(alignment: const Alignment(1.0, 1.0), children: <Widget>[
              new Container(
                child: TextFormField(
                    controller: register3Provider.adressController,
                    style: Theme.of(context).textTheme.headline4,
                    validator: (String arg) {
                      if (arg.length<3)
                        return AppLocalizations.of(context).txtErMissCharacter;
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10.0),
                        labelText: AppLocalizations.of(context).txtLblFullAdress,
                        errorStyle: Theme.of(context).textTheme.headline2,
                        labelStyle: Theme.of(context).textTheme.headline1,
                        alignLabelWithHint: true,
                        counterText: ""),
                    maxLength: 250,
                    maxLines: null,
                    onChanged: (e) {}),
                margin: EdgeInsets.only(top: 20.0),
                width: double.maxFinite,
              ),
            ]),

            //Complete Button

            Container(
                margin: EdgeInsets.only(top: 50.0),
                child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(colors: <Color>[
                              AppTheme.aqua[50],
                              AppTheme.azureRadiance[50],
                            ])),
                        padding: EdgeInsets.all(15.0),
                        child: Text(AppLocalizations.of(context).txtBtnCompleted,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.button),
                      ),
                      onTap: () {
                        register3Provider.complete();
                      },
                    ),
                  ),
                ])),

          ],
        ));

  }

}