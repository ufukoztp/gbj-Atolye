import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class DownloadContentWidget extends StatelessWidget {

  Widget widget;

  DownloadContentWidget({Key key, @required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SpinKitDualRing(
        color: AppTheme.aqua[50],
        size: 40,
        lineWidth: 2.0,
        duration: Duration(milliseconds: 500),
      ),
      Container(
        padding: EdgeInsets.only(top: 10.0),
        child: Text(
          AppLocalizations.of(context).txtLblDownloading,
          style: Theme.of(context).textTheme.headline4,
        ),
      )
    ]);
  }
}
