import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/provider/register1_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/Account/register1_widget.dart';
import 'package:gbjatolye/features/presentation/widgets/scroll_widget.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/globals.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Register1Screen extends StatefulWidget {

  final UseCases _useCases;

  Register1Screen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return Register1ScreenState();
  }

}

class Register1ScreenState extends State<Register1Screen>
    with AfterLayoutMixin<Register1Screen> {


  Register1Provider register1Provider;


  @override
  void afterFirstLayout(BuildContext context) async {

    register1Provider.useCases=widget._useCases;

    register1Provider.context=context;
    register1Provider.getCurrencyList();
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    register1Provider = Provider.of<Register1Provider>(context);

    return Scaffold(
        key:GlobalKeys.scaffoldKeyRegister,
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
                        padding: EdgeInsets.only(left: 15,top: 15.0,bottom: 15.0, right: 15),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 50.0),
                          child:Text(
                              AppLocalizations.of(context).txtTitleRegister1,
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
        body: ScrollWidget(widget: Register1Widget(register1Provider: register1Provider, useCases: widget._useCases)),

   );

  }

}
