import 'package:gbjatolye/features/presentation/provider/register2_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Register2Widget extends StatelessWidget {

  Register2Provider register2Provider;
  final useCases;

  Register2Widget(
      {Key key, @required this.register2Provider, @required this.useCases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Form(
        key: register2Provider.register2FormKey,
        // ignore: deprecated_member_use
       // autovalidate: register2Provider.autoValidate,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ///Verify code text
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                AppLocalizations.of(context).txtLblVerifyCode,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),

            ///Verify code input
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: new Stack(
                  alignment: const Alignment(1.0, 1.0),
                  children: <Widget>[
                    new Container(
                      child: TextFormField(
                          style: Theme.of(context).textTheme.headline4,
                          validator: (String arg) {
                            if (arg.length < 7)
                              return AppLocalizations.of(context)
                                  .txtSBVerifyCode;
                            else
                              return null;
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          autofocus: true,
                          inputFormatters: [register2Provider.maskFormatter],
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10.0),
                              errorStyle: Theme.of(context).textTheme.headline2,
                              labelStyle: Theme.of(context).textTheme.headline1,
                              alignLabelWithHint: false,
                              counterText: ""),
                          maxLines: 1,
                          maxLength: 7,
                          onChanged: (e) {}),
                      width: double.maxFinite,
                    ),
                  ]),
            ),

            ///Continue Button
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
                        child: Text(AppLocalizations.of(context).txtBtnContinue,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.button),
                      ),
                      onTap: () {
                        register2Provider.resume();
                      },
                    ),
                  ),
                ])),

            ///Dont receive code
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                Center(
                  child: InkWell(
                    child: Container(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          AppLocalizations.of(context).txtLblReVerifyCode,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14.0,
                              fontFamily: 'MontserratSemiBold',
                              color: AppTheme.riverBed[50]),
                        )),
                    onTap: () {
                      register2Provider.reSendCode();
                    },
                  ),
                )
              ]),
            )
          ],
        ));
  }
}
