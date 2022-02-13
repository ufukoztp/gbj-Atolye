import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/pages/others/support_screen.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/enums.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../../../../app.dart';
class SupportScreenPhoto extends KFDrawerContent {

  final mywishlistinteractor;
  final SupportTipe supportTipe;

  SupportScreenPhoto({
    this.mywishlistinteractor,
    this.supportTipe,
  });

  @override
  State<StatefulWidget> createState() {
    return SupportScreenPhotoState();
  }

}


class SupportScreenPhotoState extends State<SupportScreenPhoto> with AfterLayoutMixin<SupportScreenPhoto>{

  onBackPressed(cxt) {
    Navigator.of(cxt).pushNamedAndRemoveUntil(
        AppRoutes.drawermain, (Route<dynamic> route) => false);
  }

  var _focusTitle = new FocusNode();
  var _focusContent = new FocusNode();
  var _messageTitleController = TextEditingController();
  var _messageContentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _messageTitleController=  TextEditingController();
    print(widget.supportTipe);
    if(widget.supportTipe==SupportTipe.PhotoSupport){
      _messageTitleController.text="Fotoğraf çekimi";
    }



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.white[50],
            actions: <Widget>[
              Expanded(
                child: Container(
                  width: 300,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap:(){
                          widget.onMenuPressed();
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Padding(
                          child: Image.asset(
                            'images/ic_back.png',
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                          ),
                          padding: EdgeInsets.only(
                              right: 15.0, left: 15.0, top: 15.0, bottom: 15.0),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 50.0),
                          child: Text(
                              AppLocalizations.of(context).txtTitleSupport,
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: new TextFormField(
                      focusNode: _focusTitle,
                      controller: _messageTitleController,
                      maxLength: 60,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: AppTheme.azureRadiance[50]
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: AppTheme.azureRadiance[50])),
                          counterStyle: Theme.of(context).textTheme.headline3,
                          hintText:
                          AppLocalizations.of(context).txtLblSupportSubject,
                          hintStyle: Theme.of(context).textTheme.headline4),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline4,
                      autofocus: true,
                    ),
                    margin: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    child: new TextFormField(
                      focusNode: _focusContent,
                      controller: _messageContentController,
                      maxLength: 2000,
                      maxLines: 15,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: AppTheme.azureRadiance[50])),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                  color: AppTheme.azureRadiance[50])),
                          counterStyle: Theme.of(context).textTheme.headline3,
                          hintText:
                          AppLocalizations.of(context).txtLblSupportDesc,
                          hintStyle: Theme.of(context).textTheme.headline4),
                      style: Theme.of(context).textTheme.headline4,
                      autofocus: true,
                    ),
                    margin: EdgeInsets.only(top: 40, bottom: 20),
                  )
                ]),
          ),
          bottomNavigationBar: GestureDetector(
            child: BottomAppBar(
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[],
                      gradient: LinearGradient(colors: <Color>[
                        AppTheme.aqua[50],
                        AppTheme.azureRadiance[50],
                      ])
                  ),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            height: 50,
                            child: Center(
                                child: Text(AppLocalizations.of(context).txtBtnSend,
                                    style: Theme.of(context).textTheme.button,
                                    textAlign: TextAlign.center)),
                          ))
                    ],
                  )),
            ),
            onTap: () async {

              if (_messageTitleController.text.length == 0) {
                appSnackbar(context,
                    AppLocalizations.of(context).txtErEmptySubject);
                FocusScope.of(context).requestFocus(_focusTitle);
                return;
              }

              if (_messageContentController.text.length == 0) {
                appSnackbar(context,
                    AppLocalizations.of(context).txtErEmptyFeedBack);
                FocusScope.of(context).requestFocus(_focusContent);
                return;
              }

              final Email email = Email(
                body: _messageContentController.text,
                subject: _messageTitleController.text,
                recipients: ['contact@gbj.ist'],
                //cc: ['gbjapps@grandbazaarjewelers.com'],
              );

              try {
                await FlutterEmailSender.send(email);
              } catch (ex) {
                appSnackbar(context, ex.toString());
              }

            },
          ),
        ),
        onWillPop: () {
          return onBackPressed(context);
        });
  }

  @override
  void afterFirstLayout(BuildContext context) {


  }
}
