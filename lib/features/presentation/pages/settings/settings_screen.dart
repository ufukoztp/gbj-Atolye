import 'package:after_layout/after_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gbjatolye/features/data/datasources/remote_data_source.dart';
import 'package:gbjatolye/features/presentation/provider/settings_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/settings/settings_widget.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/globals.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';

import '../../../../app.dart';

// ignore: must_be_immutable
class SettingsScreen extends KFDrawerContent {

  final _useCases;

  SettingsScreen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState();
  }

}

class SettingsScreenState extends State<SettingsScreen>
    with AfterLayoutMixin<SettingsScreen>, WidgetsBindingObserver {
  SettingsProvider settingsProvider;
  @override
  void afterFirstLayout(BuildContext context) async {
    settingsProvider.useCases = widget._useCases;
    settingsProvider.context = context;
    await settingsProvider.reSettingsProvider();
    await settingsProvider.getAllNotificationStatus();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state) {
      case AppLifecycleState.resumed:
     //   settingsProvider.checkPermission();
        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentScaffoldState = GlobalKeys.scaffoldKeySettings;
    WidgetsBinding.instance.addObserver(this);

  }



  @override
  Widget build(BuildContext context) {

    settingsProvider = Provider.of<SettingsProvider>(context);

    return  Scaffold(
            key: GlobalKeys.scaffoldKeySettings,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppTheme.white[50],
              actions: <Widget>[
                Expanded(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            widget.onMenuPressed();
                          },
                          child: Padding(
                            child: Image.asset(
                              'images/ic_back.png',
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            padding: EdgeInsets.only(
                                right: 15.0,
                                left: 15.0,
                                top: 15.0,
                                bottom: 15.0),
                          ),
                        ),

                        ///Title Text
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 50.0),
                            child: Text(
                                AppLocalizations.of(context).txtTitleSettings,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6,
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: SettingsWidget(
              settingsProvider: settingsProvider,
              useCase: widget._useCases,
            ));
  }
}
