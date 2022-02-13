import 'package:gbjatolye/features/presentation/provider/forgotpassword2_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ForgotPassword2Widget extends StatelessWidget {

  ForgotPassword2Provider forgotPassword2Provider;
  final useCases;

  ForgotPassword2Widget(
      {Key key,
        @required this.forgotPassword2Provider,
        @required this.useCases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Form(
        key: forgotPassword2Provider.forgotPassword2FormKey,
        // ignore: deprecated_member_use
      //  autovalidate: forgotPassword2Provider.autoValidate,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            ///Şifre
            Stack(alignment: const Alignment(1.0, 1.0), children: <Widget>[
              new Container(
                child: TextFormField(
                  controller: forgotPassword2Provider.passwordController,
                  style: Theme.of(context).textTheme.headline4,
                  validator: (String arg) {
                    if (arg.length < 6)
                      return AppLocalizations.of(context).txtErMisCharacter;
                    else
                      return null;
                  },
                  obscureText: forgotPassword2Provider.obscureText,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(top: 10.0),
                      labelText: AppLocalizations.of(context).txtLblNewPassword,
                      errorStyle: Theme.of(context).textTheme.headline2,
                      labelStyle: Theme.of(context).textTheme.headline1,
                      alignLabelWithHint: true,
                      counterText: ""),
                  maxLength: 20,
                  maxLines: 1,
                  onChanged: (e) {
                    if (forgotPassword2Provider.passwordController.text.length > 0)
                      forgotPassword2Provider.eyeClosed = true;
                    else {
                      forgotPassword2Provider.eyeOpened = false;
                      forgotPassword2Provider.eyeClosed = false;
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
                    visible: forgotPassword2Provider.eyeClosed,
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
                    forgotPassword2Provider.eyeClosed = false;
                    forgotPassword2Provider.eyeOpened = true;
                    forgotPassword2Provider.obscureText = false;
                  },
                ),
              ),
              Positioned(
                top: 35.0,
                child: InkWell(
                  child: Visibility(
                    visible: forgotPassword2Provider.eyeOpened,
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
                    forgotPassword2Provider.eyeClosed = true;
                    forgotPassword2Provider.eyeOpened = false;
                    forgotPassword2Provider.obscureText = true;
                  },
                ),
              )
            ]),

            ///Güncelle Butonu

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
                      child: Text(AppLocalizations.of(context).txtBtnSave,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.button),
                    ),
                    onTap: () {
                      forgotPassword2Provider.updateSupplierPassword();
                    },
                  ),
                ),
              ]),
            )

          ],
        ));
  }
}
