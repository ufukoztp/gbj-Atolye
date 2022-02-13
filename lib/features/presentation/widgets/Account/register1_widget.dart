import 'package:gbjatolye/features/presentation/pages/account/informations_screen.dart';
import 'package:gbjatolye/utils/SlideRoute.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbjatolye/features/presentation/provider/register1_provider.dart';
import '../download_content_widget.dart';

// ignore: must_be_immutable
class Register1Widget extends StatelessWidget {
  Register1Provider register1Provider;
  final useCases;

  Register1Widget(
      {Key key, @required this.register1Provider, @required this.useCases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Form(
        key: register1Provider.register1FormKey,
        // ignore: deprecated_member_use
       // autovalidate: register1Provider.autoValidate,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            ///Atölye Adı
            Stack(alignment: const Alignment(1.0, 1.0), children: <Widget>[
              new Container(
                child: TextFormField(
                  focusNode: register1Provider.companyName,
                    controller: register1Provider.companyNameController,
                    style: Theme.of(context).textTheme.headline4,
                    validator: (String arg) {
                      if (arg.length < 3){
                        register1Provider.companyName.requestFocus();
                        return AppLocalizations.of(context).txtErMissCharacter;

                      }
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10.0),
                        labelText:
                            AppLocalizations.of(context).txtLblCompanyName,
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

            ///Gsm Numarası
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                    child: new Container(
                  child: Center(
                    child: TextFormField(
                      focusNode: register1Provider.userGsm,
                      controller: register1Provider.userGsmController,
                      style: Theme.of(context).textTheme.headline4,
                      inputFormatters: [register1Provider.maskFormatter],
                      validator: (String arg) {
                        if (arg.length < 18){
                          register1Provider.userGsm.requestFocus();
                          return AppLocalizations.of(context)
                              .txtErMisPhoneNumber;
                        }

                        else
                          return null;
                      },
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10.0),
                          labelText:
                              AppLocalizations.of(context).txtLblGsmNumber,
                          errorStyle: Theme.of(context).textTheme.headline2,
                          labelStyle: Theme.of(context).textTheme.headline1,
                          alignLabelWithHint: true,
                          counterText: ""),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 10.0),
                  width: double.maxFinite,
                ))
              ],
            ),

            ///İlgili Kişi Adı
            Stack(alignment: const Alignment(1.0, 1.0), children: <Widget>[
              new Container(
                child: TextFormField(
                  focusNode: register1Provider.personName,
                    controller: register1Provider.personNameController,
                    style: Theme.of(context).textTheme.headline4,
                    validator: (String arg) {
                      if (arg.length < 3){
                        register1Provider.personName.requestFocus();
                        return AppLocalizations.of(context).txtErMissCharacter;

                      }
                      else
                        return null;
                    },
                    cursorColor: AppTheme.darkTangerine[50],
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10.0),
                        labelText:
                            AppLocalizations.of(context).txtLblPersonName,
                        errorStyle: Theme.of(context).textTheme.headline2,
                        labelStyle: Theme.of(context).textTheme.headline1,
                        alignLabelWithHint: true,
                        counterText: ""),
                    maxLines: 1,
                    maxLength: 50,
                    onChanged: (e) {}),
                margin: EdgeInsets.only(top: 10),
                width: double.maxFinite,
              ),
            ]),

            ///İlgili Kişi Soyadı
            Stack(alignment: const Alignment(1.0, 1.0), children: <Widget>[
              new Container(
                child: TextFormField(
                  focusNode: register1Provider.personSurname,
                    controller: register1Provider.personSurnameController,
                    style: Theme.of(context).textTheme.headline4,
                    validator: (String arg) {
                      if (arg.length < 3){
                        register1Provider.personSurname.requestFocus();
                        return AppLocalizations.of(context).txtErMissCharacter;

                      }
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10.0),
                        labelText:
                            AppLocalizations.of(context).txtLblPersonSurname,
                        errorStyle: Theme.of(context).textTheme.headline2,
                        labelStyle: Theme.of(context).textTheme.headline1,
                        alignLabelWithHint: true,
                        counterText: ""),
                    maxLines: 1,
                    maxLength: 50,
                    onChanged: (e) {}),
                margin: EdgeInsets.only(top: 10),
                width: double.maxFinite,
              ),
            ]),

            ///Şifre
            Stack(alignment: const Alignment(1.0, 1.0), children: <Widget>[
              new Container(
                child: TextFormField(
                  focusNode: register1Provider.password,
                  controller: register1Provider.passwordController,
                  style: Theme.of(context).textTheme.headline4,
                  validator: (String arg) {
                    if (arg.length < 6){
                      register1Provider.password.requestFocus();
                      return AppLocalizations.of(context).txtErMisCharacter;
                    }

                    else
                      return null;
                  },
                  obscureText: register1Provider.obscureText,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(top: 10.0),
                      labelText: AppLocalizations.of(context).txtLblPassword,
                      errorStyle: Theme.of(context).textTheme.headline2,
                      labelStyle: Theme.of(context).textTheme.headline1,
                      alignLabelWithHint: true,
                      counterText: ""),
                  maxLength: 20,
                  maxLines: 1,
                  onChanged: (e) {
                    if (register1Provider.passwordController.text.length > 0)
                      register1Provider.eyeClosed = true;
                    else {
                      register1Provider.eyeOpened = false;
                      register1Provider.eyeClosed = false;
                    }
                  },
                ),
                margin: EdgeInsets.only(top: 10.0),
                width: double.maxFinite,
              ),
              Positioned(
                top: 35.0,
                child: InkWell(
                  child: Visibility(
                    visible: register1Provider.eyeClosed,
                    child: Container(
                      child: Center(
                        child: Image.asset(
                          'images/ic_eye_closed.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    register1Provider.eyeClosed = false;
                    register1Provider.eyeOpened = true;
                    register1Provider.obscureText = false;
                  },
                ),
              ),
              Positioned(
                top: 35.0,
                child: InkWell(
                  child: Visibility(
                    visible: register1Provider.eyeOpened,
                    child: Container(
                      child: Image.asset(
                        'images/ic_eye_opened.png',
                        width: 25,
                        height: 25,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  onTap: () {
                    register1Provider.eyeClosed = true;
                    register1Provider.eyeOpened = false;
                    register1Provider.obscureText = true;
                  },
                ),
              )
            ]),

            ///Para Birimi
        Column(
              children: <Widget>[
                new Container(
                    margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppLocalizations.of(context).txtLblCurrency,
                      style: Theme.of(context).textTheme.headline4,
                    )),
                new Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(colors: <Color>[
                          AppTheme.aqua[50],
                          AppTheme.azureRadiance[50],
                        ])),
                    child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppTheme.white[50]),
                          margin: EdgeInsets.all(2.0),
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Visibility(
                                visible:

                                !register1Provider.loadingCurrency,
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: DownloadContentWidget(widget: null,),
                                ),
                              ),
                              Visibility(
                                visible:
                                    register1Provider.loadingCurrency,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      register1Provider.loadingCurrency==false?[Container()]:

                                      register1Provider.getCurrencyWidgetList()
                                ),
                              )
                            ],
                          )),
                    )
              ],
            ),

            ///Kullanım Koşulları
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      register1Provider.checkTermOfUse =
                          !register1Provider.checkTermOfUse;
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 10.0),
                        child: register1Provider.checkTermOfUse
                            ? Image.asset(
                                'images/ic_checked.png',
                                width: 25,
                                height: 25,
                              )
                            : Image.asset(
                                'images/ic_check.png',
                                width: 25,
                                height: 25,
                              ),
                      ),
                    ),
                  ),
                  new Row(
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            //appSnackbar(cxt, "fdas");
                            Navigator.push(
                                context,
                                SlideLeftRoute(
                                    page: InformationsScreen(useCases)));
                          },
                          child: Text(
                              AppLocalizations.of(context).txtCbTermOfCond1,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14.0,
                                  fontFamily: 'GothamBook',
                                  color: AppTheme.red[50]))),
                      Text(
                        AppLocalizations.of(context).txtCbTermOfCond2,
                        style: Theme.of(context).textTheme.headline4,
                      )
                    ],
                  )
                ],
              ),
            ),

            ///Devam Butonu
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child:
              Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(colors: <Color>[
                            AppTheme.aqua[50],
                            AppTheme.azureRadiance[50],
                          ])),
                      padding: EdgeInsets.all(15.0),
                      child: Text(AppLocalizations.of(context).txtBtnContinue,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.button),
                    ),
                    onTap: () {
                      register1Provider.resume();
                    },
                  ),
                ),
              ]),
            )
          ],
        ));
  }
}
