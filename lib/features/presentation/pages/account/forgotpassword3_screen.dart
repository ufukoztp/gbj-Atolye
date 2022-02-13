import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/provider/forgotpassword3_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Account/forgotpassword3_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/scroll_widget.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword3Screen extends StatefulWidget {

  final _useCases;

  ForgotPassword3Screen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return ForgotPassword3ScreenState();
  }

}

class ForgotPassword3ScreenState extends State<ForgotPassword3Screen>
    with AfterLayoutMixin<ForgotPassword3Screen> {

  ForgotPassword3Provider _forgotPassword3Provider;

  @override
  void afterFirstLayout(BuildContext context) {
    _forgotPassword3Provider.useCases = widget._useCases;
    _forgotPassword3Provider.context=context;
    _forgotPassword3Provider.supplierPhone = appIntent.data;
  }

  @override
  Widget build(BuildContext context) {

    _forgotPassword3Provider = Provider.of<ForgotPassword3Provider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.white[50],
        actions: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context).txtTitleChangedPassword,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body:ScrollWidget(widget: ForgotPassword3Widget(forgotPassword3Provider: _forgotPassword3Provider,useCases: widget._useCases))
    );
  }
}
