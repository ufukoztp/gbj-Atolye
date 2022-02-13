import 'package:gbjatolye/features/presentation/provider/ticket_provider.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../app.dart';

class TicketsWidget extends StatelessWidget {
  final TicketProvider ticketProvider;

  final useCases;

  TicketsWidget(
      {Key key, @required this.ticketProvider, @required this.useCases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
        controller: ticketProvider.scrollController,
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        itemCount: ticketProvider.tickets.length + 1,
        itemBuilder: (context, position) {
          if (position == ticketProvider.tickets.length &&
              ticketProvider.getAbleTicket())
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: CupertinoActivityIndicator(),
            );
          else if (position == ticketProvider.tickets.length &&
              !ticketProvider.getAbleTicket()) return null;

          var date = DateTime.parse(ticketProvider.tickets[position].createdate);

          var formattedDate = date.day.toString() +
              " " +
              getMonth(context, date.month) +
              " " +
              date.year.toString();

          return Expanded(
            child: Padding(
              padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
              child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                      child: ticketProvider.tickets[position].image.isNotEmpty
                          ? Expanded(
                            child: ListTile(
                            onTap: () {},
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 15.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0,
                                          color: AppTheme.grey[50]))),
                              child: CachedNetworkImage(
                                  imageUrl:
                                  ticketProvider.tickets[position].image +
                                      "1.jpg",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        width: 55.0,
                                        height: 55.0,
                                        decoration: BoxDecoration(
                                          borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                                ),
                              ),
                            title: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                      ticketProvider
                                          .tickets[position].ticketdetail,
                                      style:
                                      Theme.of(context).textTheme.headline4),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(formattedDate,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: 'GothamBook',
                                          color: AppTheme.grey[50]))
                                ],
                              ),
                            )),
                          )
                          : ListTile(
                        onTap: () {},
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        title: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                  ticketProvider
                                      .tickets[position].ticketdetail
                                      .toString(),
                                  style:
                                  Theme.of(context).textTheme.headline4),
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(formattedDate,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'GothamBook',
                                      color: AppTheme.grey[50]))
                            ],
                          ),
                        ),
                      ))),
            ),
          );
        },
      ),
    );
  }

}
