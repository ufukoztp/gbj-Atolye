import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/provider/forgotpassword1_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Account/forgotpassword1_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/scroll_widget.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword1Screen extends StatefulWidget {

  final _useCases;

  ForgotPassword1Screen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return ForgotPassword1ScreenState();
  }

}

class ForgotPassword1ScreenState extends State<ForgotPassword1Screen>
    with AfterLayoutMixin<ForgotPassword1Screen> {


  ForgotPassword1Provider _forgotPassword1Provider;

  @override
  void afterFirstLayout(BuildContext context) {
    _forgotPassword1Provider.useCases=widget._useCases;
    _forgotPassword1Provider.context=context;
  }

  @override
  Widget build(BuildContext context) {

    _forgotPassword1Provider = Provider.of<ForgotPassword1Provider>(context);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppTheme.white[50],
          actions: <Widget>[
            Expanded(
              child: Container(
                width: 300,
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        child: Image.asset(
                          'images/ic_back.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                        padding: EdgeInsets.only(left: 15.0,top: 15.0,bottom: 15.0, right: 15),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(right: 50.0),
                      child: Text(
                          AppLocalizations.of(context).txtTitleForgetPassword1,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.center),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ScrollWidget(widget: ForgotPassword1Widget(forgotPassword1Provider: _forgotPassword1Provider,useCases: widget._useCases)));
  }

}
