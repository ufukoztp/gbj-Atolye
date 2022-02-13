import 'package:flutter/material.dart';

import '../../../app.dart';

// ignore: must_be_immutable
class ScrollWidget extends StatelessWidget {

  Widget widget;

  ScrollWidget(
      {Key key, @required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.builder(
        itemBuilder: (context, position) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 30.0),
                    child: widget
                )
            ),
          );
        },
        itemCount: 1,
      ),
    );
  }
}
