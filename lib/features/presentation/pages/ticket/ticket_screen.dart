import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/presentation/provider/ticket_provider.dart';
import 'package:gbjatolye/features/presentation/widgets/ticket/ticket_widgets.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/globals.dart';
import 'package:gbjatolye/utils/routes.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';

import '../../../../app.dart';

// ignore: must_be_immutable
class TicketScreen extends KFDrawerContent {

  final _useCases;

  TicketScreen(this._useCases);

  @override
  State<StatefulWidget> createState() {
    return TicketScreenState();
  }
}

class TicketScreenState extends State<TicketScreen>
    with AfterLayoutMixin<TicketScreen> {
  TicketProvider ticketProvider;

  @override
  void afterFirstLayout(BuildContext context) {
    ticketProvider.useCases = widget._useCases;

    ticketProvider.context = context;

    ticketProvider.reTicketProvider();

    ticketProvider.getTicketList(ticketProvider.currentPage);

    ticketProvider.scrollController.addListener(() {
      if (ticketProvider.scrollController.position.pixels ==
              ticketProvider.scrollController.position.maxScrollExtent &&
          ticketProvider.getAbleTicket())
        ticketProvider.getTicketList(ticketProvider.currentPage);
    });
  }

  onBackPressed(cxt) {
    Navigator.of(cxt).pushNamedAndRemoveUntil(
        AppRoutes.drawermain, (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    currentScaffoldState = GlobalKeys.scaffoldKeyNotifications;
  }

  @override
  Widget build(BuildContext context) {
    ticketProvider = Provider.of<TicketProvider>(context);

    return new WillPopScope(
        child: Scaffold(
            key: GlobalKeys.scaffoldKeyTickets,
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
                                AppLocalizations.of(context)
                                    .txtTitleRequestAndRepair,
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
            body: TicketsWidget(
              ticketProvider: ticketProvider,
              useCases: widget._useCases,
            )),
        onWillPop: () {
          return onBackPressed(context);
        });
  }
}
