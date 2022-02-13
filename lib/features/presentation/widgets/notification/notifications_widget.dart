import 'package:gbjatolye/features/domain/entities/notification/setnotification.dart';
import 'package:gbjatolye/features/presentation/provider/notifications_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../app.dart';

class NotificationsWidget extends StatelessWidget {

  final NotificationsProvider notificationsProvider;

  final useCases;

  NotificationsWidget(
      {Key key, @required this.notificationsProvider, @required this.useCases})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
        controller: notificationsProvider.scrollController,
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        itemBuilder: (context, position) {

          if (position == notificationsProvider.notifications.length &&
              notificationsProvider.getableNotification())
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: CupertinoActivityIndicator(),
            );
          else if (position == notificationsProvider.notifications.length &&
              !notificationsProvider.getableNotification()) return null;

          var date = DateTime.parse(
              notificationsProvider.notifications[position].date);

          var formattedDate = date.day.toString() +
              " " +
              getMonth(context,date.month) +
              " " +
              date.year.toString();

          return Padding(
            padding:
                EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
            child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                    child: notificationsProvider
                            .notifications[position].image.isNotEmpty
                        ?
                    Stack(
                      children: [
                        notificationsProvider
                            .notifications[position].hasread!=true ? Align(
                          alignment: Alignment.topRight,
                          child: ClipOval(
                            child: Container(
                              color: AppTheme.darkRed[50],
                              height: 15.0, // height of the button
                              width: 15.0, // width of the button
                            ),
                          ),
                        ):Container(),
                        ListTile(
                              onTap: () {
                                notificationsProvider
                                    .notifications[position].hasread=true;
                                print(notificationsProvider
                                    .notifications[position].id);

                                SetNotification notfIdList=SetNotification();
                                var list=notfIdList.notfList;

                                List<notificationId> notfList=List<notificationId>();

                                notfList.add(notificationId(id:notificationsProvider
                                    .notifications[position].id));

                                notfIdList.notfList=notfList;

                                print(notfIdList.notfList[0].id);

                                notificationsProvider.setNotificationRead(notfIdList).then((value) {

                                  notificationsProvider.route(notificationsProvider.notifications[position].route,position);

                                });


                              },
                              contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 15.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0,
                                            color: AppTheme.grey[50]))),
                                child: CachedNetworkImage(
                                    imageUrl: notificationsProvider
                                        .notifications[position].image +
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
                                  Visibility(
                                    visible: notificationsProvider
                                                .notifications[position].type ==
                                            NotificationTypes.NOTFLIKE_TYPE ||
                                        notificationsProvider
                                                .notifications[position].type ==
                                            NotificationTypes.NOTFLIKEDETAIL_TYPE,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 5.0),
                                      child: Icon(
                                        Icons.favorite,
                                        color: AppTheme.darkRed[50],
                                        size: 20.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        notificationsProvider
                                            .notifications[position].body,
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
                                    Visibility(
                                      visible: notificationsProvider
                                              .notifications[position].type ==
                                          NotificationTypes.NOTFLIKEDETAIL_TYPE,
                                      child: Text(
                                          AppLocalizations.of(context)
                                              .txtLblQuiklyDetail,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'GothamBold',
                                              color: AppTheme.red[50])),
                                    ),
                                    Text(formattedDate,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontFamily: 'GothamBook',
                                            color: AppTheme.grey[50]))
                                  ],
                                ),
                              ),
                              trailing: Image.asset(
                                'images/ic_right_button.png',
                                width: 25,
                                height: 25,
                                fit: BoxFit.contain,
                              ))],
                    )
                        :
                    Stack(
                      children:[
                        notificationsProvider
                            .notifications[position].hasread!=true ? Align(
                          alignment: Alignment.topRight,
                          child: ClipOval(
                            child: Container(
                              color: AppTheme.darkRed[50],
                              height: 15.0, // height of the button
                              width: 15.0, // width of the button
                            ),
                          ),
                        ):Container(),

                        ListTile(
                              onTap: () {
                                notificationsProvider
                                    .notifications[position].hasread=true;
                                print(notificationsProvider
                                    .notifications[position].id);

                                SetNotification notfIdList=SetNotification();
                                var list=notfIdList.notfList;

                                List<notificationId> notfList=List<notificationId>();

                                notfList.add(notificationId(id:notificationsProvider
                                    .notifications[position].id));

                                notfIdList.notfList=notfList;

                                print(notfIdList.notfList[0].id);

                                notificationsProvider.setNotificationRead(notfIdList).then((value) {

                                  notificationsProvider.route(notificationsProvider.notifications[position].route,position);

                                });


                              },
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              title: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                        notificationsProvider
                                            .notifications[position].body
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
                            )],
                    ))),
          );

        },
        itemCount: notificationsProvider.notifications.length + 1,
      ),
    );
  }
}
