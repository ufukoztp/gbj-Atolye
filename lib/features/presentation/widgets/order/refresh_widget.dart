import 'package:flutter/material.dart';
import 'package:gbjatolye/utils/theme.dart';

class RefreshWidget extends StatefulWidget {
  final Widget child;
  final Future Function() onRefresh;

  const RefreshWidget({Key key, this.onRefresh, this.child}) : super(key: key);

  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return buildAndroidList();
  }

  Widget buildAndroidList(){
    return RefreshIndicator(child: widget.child, onRefresh: widget.onRefresh,color: AppTheme.aqua[50],);
  }
}
