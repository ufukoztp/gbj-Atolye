import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/provider/forgotpassword2_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Account/forgotpassword2_widget.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gbjatolye/features/presentation/widgets/scroll_widget.dart';


class ForgotPassword2Screen extends StatefulWidget {

  final _useCases;

  ForgotPassword2Screen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return ForgotPassword2ScreenState();
  }

}

class ForgotPassword2ScreenState extends State<ForgotPassword2Screen>
    with AfterLayoutMixin<ForgotPassword2Screen> {

  ForgotPassword2Provider _forgotPassword2Provider;

  @override
  void afterFirstLayout(BuildContext context) {
    _forgotPassword2Provider.useCases=widget._useCases;
    _forgotPassword2Provider.context=context;
    _forgotPassword2Provider.userForgotPasswordRequest = appIntent.data;
  }

  @override
  Widget build(BuildContext context) {

    _forgotPassword2Provider = Provider.of<ForgotPassword2Provider>(context);

    return Scaffold(
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
                        AppLocalizations.of(context).txtTitleNewPassword,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6
                        ,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ScrollWidget(widget: ForgotPassword2Widget(forgotPassword2Provider: _forgotPassword2Provider,useCases: widget._useCases))
    );
  }


}
