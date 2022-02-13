import 'package:gbjatolye/features/presentation/provider/forgotpassword1_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ForgotPassword1Widget extends StatelessWidget {

  ForgotPassword1Provider forgotPassword1Provider;
  final useCases;

  ForgotPassword1Widget(
      {Key key,
        @required this.forgotPassword1Provider,
        @required this.useCases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    forgotPassword1Provider = Provider.of<ForgotPassword1Provider>(context);

    return new Form(
        key: forgotPassword1Provider.forgotPassword1FormKey,
        // ignore: deprecated_member_use
       // autovalidateMode: forgotPassword1Provider.autoValidate,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ///Gsm Number Input
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                    child: new Container(
                      child: Center(
                        child: TextFormField(
                          style: Theme.of(context).textTheme.headline4,
                          inputFormatters: [forgotPassword1Provider.maskFormatter],
                          validator: (String arg) {
                            if (arg.length < 18)
                              return AppLocalizations.of(context)
                                  .txtErMisPhoneNumber;
                            else
                              return null;
                          },
                          autofocus: true,
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

            ///Send Verify Code
            Padding(
              padding: EdgeInsets.only(top: 40.0),
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
                      child: Text(AppLocalizations.of(context).txtBtnSendVerifyCode,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.button),
                    ),
                    onTap: () {
                      forgotPassword1Provider.sendVerifyCode();
                    },
                  ),
                ),
              ]),
            ),

            ///Verify Code Text
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                AppLocalizations.of(context).txtLblFPNext,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            )

          ],
        ));
  }
}
