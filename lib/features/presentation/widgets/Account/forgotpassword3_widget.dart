import 'package:gbjatolye/features/presentation/provider/forgotpassword3_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ForgotPassword3Widget extends StatelessWidget {

  ForgotPassword3Provider forgotPassword3Provider;
  final useCases;

  ForgotPassword3Widget(
      {
        Key key,
        @required this.forgotPassword3Provider,
        @required this.useCases
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Form(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            ///Password Updated Text
            Container(
              child: new Container(
                margin: new EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/ic_updated_password.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top:20.0),
              child: Text(
                AppLocalizations.of(context).txtLblChangedPassword,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),

            ///Button doLogin

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
                      child: Text(AppLocalizations.of(context).txtBtnRouteLogin,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.button),
                    ),
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context,AppRoutes.login,(Route<dynamic> route) => false);
                    },
                  ),
                ),
              ]),
            )

          ],
        ));
  }

}
