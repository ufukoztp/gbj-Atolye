import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app.dart';


class InformationsScreen extends StatefulWidget {

  final appinteractor;

  InformationsScreen(this.appinteractor);

  @override
  State<StatefulWidget> createState() {
    return InformationsScreenState(appinteractor);
  }

}

class InformationsScreenState extends State<InformationsScreen>
    with AfterLayoutMixin<InformationsScreen> {

  var cxt;

  final appinteractor;

  InformationsScreenState(this.appinteractor);

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {

    this.cxt = context;

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
                        padding: EdgeInsets.only(left: 15, top:15,bottom:15,right: 15),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 50.0),
                          child:Text(
                              AppLocalizations.of(context).txtTitleTermOfCond,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center),
                        )),

                  ],
                ),
              ),
            ),

          ],
        ),
//        appBar: AppBar(
//          backgroundColor: AppTheme.darkTangerine[50],
//          actions: <Widget>[
//            Expanded(
//              child: Row(
//                children: <Widget>[
//                  Expanded(
//                    child: Align(
//                      alignment: Alignment.center,
//                      child: Text(
//                        AppLocalizations.of(context).txtTitleTermOfCond,
//                        textAlign: TextAlign.center,
//                        style: Theme.of(context).textTheme.title,
//                      ),
//                    ),
//                  ),
//                  GestureDetector(
//                    child: Visibility(
//                        visible: true,
//                        child: Container(
//                            padding: EdgeInsets.all(15),
//                            child: Image.asset(
//                              'images/ic_close.png',
//                              fit: BoxFit.contain,
//                            ))),
//                    onTap: () {},
//                  )
//                ],
//              ),
//            )
//          ],
//        ),
        backgroundColor: Theme.of(cxt).backgroundColor,
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0, bottom: 20.0),
                      child: new Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtTitleTerm1,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtLblTerms,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtTitleTerm2,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtLblTerms1,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtTitleTerm3,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtLblTerms2,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtTitleTerm4,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtLblTerms3,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtTitleTerm5,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtLblTerms4,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtTitleTerm6,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                AppLocalizations.of(cxt).txtLblTerms5,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          ],
                        ),
                      )),
                ),
              );
            },
            itemCount: 1,
          ),
        ));

  }
}
