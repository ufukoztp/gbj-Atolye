import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/provider/notifications_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/notification/notifications_widget.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/globals.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';

import '../../../../app.dart';

// ignore: must_be_immutable
class NotificationsScreen extends KFDrawerContent {

  final _useCases;

  NotificationsScreen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return NotificationsScreenState();
  }

}

class NotificationsScreenState extends State<NotificationsScreen>
    with AfterLayoutMixin<NotificationsScreen> {

  NotificationsProvider notificationsProvider;

  @override
  void afterFirstLayout(BuildContext context) {
    notificationsProvider.useCases = widget._useCases;

    notificationsProvider.getNotificationList(notificationsProvider.currentPage);

    notificationsProvider.scrollController.addListener(() {
      if (notificationsProvider.scrollController.position.pixels ==
              notificationsProvider.scrollController.position.maxScrollExtent &&
          notificationsProvider.getableNotification())
        notificationsProvider
            .getNotificationList(notificationsProvider.currentPage);
    });

  }

  @override
  void initState() {
    super.initState();
    currentScaffoldState = GlobalKeys.scaffoldKeyNotifications;
  }

  @override
  Widget build(BuildContext context) {

    notificationsProvider = Provider.of<NotificationsProvider>(context);

    notificationsProvider.context = context;

    return Scaffold(
        key: GlobalKeys.scaffoldKeyNotifications,
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
                        Navigator.of(context).pop();
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

                    ///Title Text
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 50.0),
                        child: Text(
                            AppLocalizations.of(context).txtTitleNotifications,
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
        body: NotificationsWidget(
          notificationsProvider: notificationsProvider,
          useCases: widget._useCases,
        ));

  }
}
