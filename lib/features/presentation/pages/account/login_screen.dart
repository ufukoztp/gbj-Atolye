import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:gbjatolye/features/presentation/provider/login_provider.dart';
import 'package:gbjatolye/features/presentation/provider/register1_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Account/login_widgets.dart';
import 'package:gbjatolye/features/presentation/widgets/scroll_widget.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/globals.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  final _useCases;

  LoginScreen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>
    with AfterLayoutMixin<LoginScreen> {
  Register1Provider register1Provider;

  LoginProvider loginProvider;

  GlobalKey<ScaffoldState> currentScaffoldState;


  @override
   initState()  {



    super.initState();
    currentScaffoldState = GlobalKeys.scaffoldKeyLogin;
  }


  @override
   afterFirstLayout(BuildContext context) {
    loginProvider.prefdoldur();
    loginProvider.useCases = widget._useCases;
    loginProvider.context = context;
    if (appIntent.intent == PageIntents.ToSupplierPhoneFromForgetPassword &&
        appIntent.data != null)
      loginProvider.userGsmController.text = appIntent.data;
  }


  @override
  Widget build(BuildContext context) {
    loginProvider = Provider.of<LoginProvider>(context);
    register1Provider = Provider.of<Register1Provider>(context);

    return Scaffold(
        key: GlobalKeys.scaffoldKeyLogin,
        appBar: AppBar(
          backgroundColor: AppTheme.white[50],
          actions: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context).txtTitleLogin,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body:  ScrollWidget(
              widget:
                LoginInputsWidget(
                    loginProvider: loginProvider, useCase: widget._useCases),

        ));

  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<LoginProvider>('loginProvider', loginProvider));
  }

}
