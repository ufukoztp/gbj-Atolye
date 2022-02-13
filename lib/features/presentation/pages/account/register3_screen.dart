import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/provider/register3_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Account/register3_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/scroll_widget.dart';
import 'package:gbjatolye/singletons/appintent_singletons.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Register3Screen extends StatefulWidget {

  final _useCases;

  Register3Screen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return Register3ScreenState();
  }

}

class Register3ScreenState extends State<Register3Screen>
    with AfterLayoutMixin<Register3Screen> {

  Register3Provider register3Provider;

  @override
  void afterFirstLayout(BuildContext context) async {
    register3Provider.useCases=widget._useCases;
    register3Provider.context=context;
    register3Provider.userAdressRequest = appIntent.data;
  }

  @override
  Widget build(BuildContext context) {

    register3Provider = Provider.of<Register3Provider>(context);

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
                        AppLocalizations.of(context).txtTitleRegister3,
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
        backgroundColor: Theme.of(context).backgroundColor,
        body: ScrollWidget(
            widget: Register3Widget(
                register3Provider: register3Provider,
                useCases: widget._useCases)));
  }

}
