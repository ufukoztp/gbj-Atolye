import 'package:after_layout/after_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gbjatolye/features/data/datasources/remote_data_source.dart';
import 'package:gbjatolye/features/domain/usecases/usecases.dart';
import 'package:gbjatolye/features/presentation/provider/settings_provider.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/atolyeexpansiontile.dart';
import 'package:gbjatolye/utils/statics.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsWidget extends StatefulWidget {

  final SettingsProvider settingsProvider;
  final UseCases useCase;

  SettingsWidget({@required this.settingsProvider, @required this.useCase});

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();

}

class _SettingsWidgetState extends State<SettingsWidget> with SingleTickerProviderStateMixin,AfterLayoutMixin<SettingsWidget>{
GlobalKey<AppExpansionTileState> _expansionkey=GlobalKey<AppExpansionTileState>();
FirebaseMessaging _firebaseMessaging;
RemoteDataSourceImp _dataSourceImp;
String token;


@override
void afterFirstLayout(BuildContext context) async{
  // TODO: implement afterFirstLayout

    _firebaseMessaging=FirebaseMessaging();
  _dataSourceImp=RemoteDataSourceImp();

  await _firebaseMessaging.getToken().then((value)async {
    token=value;


  });
}


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: Text(
              AppLocalizations.of(context).txtLblSettingDesc,
              style: TextStyle(
                  color: AppTheme.grey[50],
                  fontFamily: 'MontserratSemiBold',
                  fontSize: 13),
              textAlign: TextAlign.center),
          margin: EdgeInsets.only(left: 15, right: 15, top: 20),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 5, top: 15),
            child: Column(
              children: <Widget>[
                /*
                MergeSemantics(
                  child: ListTile(
                    title: Text(
                      AppLocalizations.of(context).txtSwitchOrderNotf,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        AppLocalizations.of(context).txtSwitchOrderNotfDesc,
                        style: TextStyle(
                            color: AppTheme.grey[50],
                            fontFamily: 'MontserratSemiBold',
                            fontSize: 12.0)),
                    trailing: CupertinoSwitch(
                      activeColor: AppTheme.aqua[50],
                      value: widget.settingsProvider.productOrderStatus,
                      onChanged: (bool value) async {
                        await widget.settingsProvider.changeOrderNotificationStatus(!widget.settingsProvider.productOrderStatus);
                      },
                    ),
                    onTap: () async {
                      await widget.settingsProvider.changeOrderNotificationStatus(!widget.settingsProvider.productOrderStatus);
                    },
                  ),
                ),
                MergeSemantics(
                  child: ListTile(
                    title: Text(
                      AppLocalizations.of(context).txtSwitchProductAddNotf,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        AppLocalizations.of(context).txtSwitchProductAddNotfDesc,
                        style: TextStyle(
                            color: AppTheme.grey[50],
                            fontFamily: 'MontserratSemiBold',
                            fontSize: 12.0)),
                    trailing: CupertinoSwitch(
                      activeColor: AppTheme.aqua[50],
                      value: widget.settingsProvider.productAddedStatus,
                      onChanged: (bool value) async {
                        await widget.settingsProvider.changeProductAddedNotificationStatus(!widget.settingsProvider.productAddedStatus);
                      },
                    ),
                    onTap: () async {
                      await widget.settingsProvider.changeProductAddedNotificationStatus(!widget.settingsProvider.productAddedStatus);
                    },
                  ),
                ),
                MergeSemantics(
                  child: ListTile(
                    title: Text(
                      AppLocalizations.of(context).txtSwitchProductLikeNotf,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        AppLocalizations.of(context).txtSwitchProductLikeNotfDesc,
                        style: TextStyle(
                            color: AppTheme.grey[50],
                            fontFamily: 'MontserratSemiBold',
                            fontSize: 12.0)),
                    trailing: CupertinoSwitch(
                      activeColor: AppTheme.aqua[50],
                      value: widget.settingsProvider.productLikeStatus,
                      onChanged: (bool value) async {
                        await widget.settingsProvider.changeProductLikeNotificationStatus(!widget.settingsProvider.productLikeStatus);
                      },
                    ),
                    onTap: () async {
                      await widget.settingsProvider.changeProductLikeNotificationStatus(!widget.settingsProvider.productLikeStatus);
                    },
                  ),
                ),
                MergeSemantics(
                  child: ListTile(
                    title: Text(
                      AppLocalizations.of(context).txtSwitchInfoNotf,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        AppLocalizations.of(context).txtSwitchInfoNotfDesc,
                        style: TextStyle(
                            color: AppTheme.grey[50],
                            fontFamily: 'MontserratSemiBold',
                            fontSize: 12.0)),
                    trailing: CupertinoSwitch(
                      activeColor: AppTheme.aqua[50],
                      value: widget.settingsProvider.customStatus,
                      onChanged: (bool value) async {
                        await widget.settingsProvider.changeCustomNotificationStatus(!widget.settingsProvider.customStatus);
                      },
                    ),
                    onTap: () async {
                      await widget.settingsProvider.changeCustomNotificationStatus(!widget.settingsProvider.customStatus);
                    },
                  ),
                ),

                 */
                MergeSemantics(
                  child: ListTile(
                    title: Text(
                      "Bildirimlere izin ver",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        "Ürünlerinizle alakalı bildirimleri bildirir.Bu alanı kapatırsanız ürün takibiniz zorlaşabilir!",
                        style: TextStyle(
                            color: AppTheme.grey[50],
                            fontFamily: 'MontserratSemiBold',
                            fontSize: 12.0)),
                    trailing: CupertinoSwitch(
                      activeColor: AppTheme.aqua[50],
                      value: widget.settingsProvider.allNotificationsStatus,
                      onChanged: (bool value) async {


                       if(value==false){
                         await widget.settingsProvider.unRegisterDevice(token).then((value) => print("bitti"));
                         widget.settingsProvider.allNotificationsStatus=value;
                       }

                        if(value==true){
                          await  widget.settingsProvider.registerDevice(token).then((value) => print("bitti"));
                          widget.settingsProvider.allNotificationsStatus=value;
                        }


                      },
                    ),
                    onTap: () async {
                //      await widget.settingsProvider.changeOrderNotificationStatus(!widget.settingsProvider.allNotificationsStatus);
                      if(widget.settingsProvider.allNotificationsStatus==false){
                       }

                    },
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.all(14.0),
                  child: Column(



                    children: [
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).txtSwitchOrderNotf,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                            color: widget.settingsProvider.allNotificationsStatus==false?Colors.grey:AppTheme.bigStone[50]
                          ),
                        ),
                        subtitle: Text(
                            AppLocalizations.of(context).txtSwitchOrderNotfDesc,
                            style: TextStyle(
                                color: AppTheme.grey[50],
                                fontFamily: 'MontserratSemiBold',
                                fontSize: 12.0)),

                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).txtSwitchProductAddNotf,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: widget.settingsProvider.allNotificationsStatus==false?Colors.grey:AppTheme.bigStone[50]
                          ),
                        ),
                        subtitle: Text(
                            AppLocalizations.of(context).txtSwitchProductAddNotfDesc,
                            style: TextStyle(
                                color: AppTheme.grey[50],
                                fontFamily: 'MontserratSemiBold',
                                fontSize: 12.0)),
                        onTap: () async {
                         // await widget.settingsProvider.changeProductAddedNotificationStatus(!widget.settingsProvider.productAddedStatus);
                        },
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).txtSwitchProductLikeNotf,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: widget.settingsProvider.allNotificationsStatus==false?Colors.grey:AppTheme.bigStone[50]
                          ),
                        ),
                        subtitle: Text(
                            AppLocalizations.of(context).txtSwitchProductLikeNotfDesc,
                            style: TextStyle(
                                color: AppTheme.grey[50],
                                fontFamily: 'MontserratSemiBold',
                                fontSize: 12.0)),
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).txtSwitchInfoNotf,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: widget.settingsProvider.allNotificationsStatus==false?Colors.grey:AppTheme.bigStone[50]
                          ),
                        ),
                        subtitle: Text(
                            AppLocalizations.of(context).txtSwitchInfoNotfDesc,
                            style: TextStyle(
                                color: AppTheme.grey[50],
                                fontFamily: 'MontserratSemiBold',
                                fontSize: 12.0)),

                      ),
                    ],

                  ),
                )

              ],
            ),
          ),
        )
      ],
    );
  }


}
