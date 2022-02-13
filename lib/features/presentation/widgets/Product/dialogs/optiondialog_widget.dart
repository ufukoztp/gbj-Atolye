import 'package:after_layout/after_layout.dart';
import 'package:gbjatolye/features/domain/entities/product/productOld.dart';
import 'package:gbjatolye/utils/applocalization.dart';
import 'package:gbjatolye/utils/theme.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> asyncOptionDialog(
    {BuildContext context, List<SizeGroup> sizelist}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        backgroundColor: AppTheme.white[50],
        title: Column(
          children: <Widget>[
            Text(AppLocalizations.of(context).txtPopupChooseOptionsTitle,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center),
            Container(
              padding: EdgeInsets.only(top: 15.0, right: 10.0, left: 10.0),
              child: Text(
                  AppLocalizations.of(context).txtPopupChooseOptionsDescription,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        contentPadding:
            EdgeInsets.only(top: 20.0, bottom: 0.0, right: 0.0, left: 0.0),
        content: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          Container(
              width: 300,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: ExpandableTheme(
                    data: const ExpandableThemeData(
                      iconColor: Colors.blue,
                      useInkWell: false,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: getList(sizelist),
                    ),
                  ),
                ),
              )),
          InkWell(
            child: Container(
              height: 50,
              decoration: new BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    AppTheme.aqua[50],
                    AppTheme.azureRadiance[50],
                  ]),
                  borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(50.0),
                    bottomRight: const Radius.circular(50.0),
                  )),
              child: Center(
                child: Text(AppLocalizations.of(context).txtBtnSave,
                    style: Theme.of(context).textTheme.button,
                    textAlign: TextAlign.center),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop(true);
            },
          ),
        ]),
      );
    },
  );
}

List<Widget> getList(List<SizeGroup> sizelist) {
  List<Widget> widgets = List<Widget>();

  for (int i = 0; i < sizelist.length; i++)
    widgets.add(_ExpandableHeaderList(sizeGroup: sizelist[i],sizeListCount: sizelist.length,));

  return widgets;
}

class _ExpandableHeaderList extends StatefulWidget {

  final SizeGroup sizeGroup;
  final int sizeListCount;

  const _ExpandableHeaderList({Key key, this.sizeGroup,this.sizeListCount}) : super(key: key);

  @override
  _ExpandableHeaderListState createState() => _ExpandableHeaderListState();
}

class _ExpandableHeaderListState extends State<_ExpandableHeaderList>
    with SingleTickerProviderStateMixin ,  AfterLayoutMixin<_ExpandableHeaderList>{

  ExpandableController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new ExpandableController(initialExpanded: widget.sizeListCount>1?false:true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {

  }



  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 10.0, bottom: 15.0),
      child: Column(
        children: <Widget>[
          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse:  false,
            child: ExpandablePanel(
              controller:_controller,
              theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: false,
                  iconColor: Color(0xff1b2d48)),
              header: Container(
                child: Text(widget.sizeGroup.sizetitlename.toUpperCase(),
                    style: Theme.of(context).textTheme.headline6),
              ),
              expanded: Column(
                children: <Widget>[
                  for (int i = 0; i < widget.sizeGroup.sizes.length; i++)
                    _content(i)
                ],
              ),
              builder: (_, collapsed, expanded) {
                return Expandable(
                  collapsed: collapsed,
                  expanded: expanded,
                  theme: const ExpandableThemeData(crossFadePoint: 0),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  Widget _content(i) {
    return CheckboxListTile(
        dense: false,
        title: Text(
          widget.sizeGroup.sizes[i].name.toString(),
          style: Theme.of(context).textTheme.headline4,
        ),
        value: widget.sizeGroup.sizes[i].selected,
        selected: widget.sizeGroup.sizes[i].selected,
        activeColor: AppTheme.azureRadiance[50],
        onChanged: (bool value) {
          setState(() {
            widget.sizeGroup.sizes[i].selected =
                !widget.sizeGroup.sizes[i].selected;
          });
        });
  }



}

/*
Future<bool> asyncOptionDialog({BuildContext context, List<SizeGroup> sizelist}) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {

      return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          backgroundColor: AppTheme.white[50],
          title: Column(
            children: <Widget>[
              Text(
                  AppLocalizations.of(context).txtPopupChooseOptionsTitle,
                  style: Theme.of(context).textTheme.title,
                  textAlign: TextAlign.center),
              Container(
                padding: EdgeInsets.only(top: 15.0,right: 10.0,left: 10.0),
                child: Text(
                    AppLocalizations.of(context).txtPopupChooseOptionsDescription,
                    style: Theme.of(context).textTheme.display1,
                    textAlign: TextAlign.center),
              ),
            ],
          ),
          contentPadding: EdgeInsets.only(top: 20.0, bottom: 0.0, right: 0.0, left: 0.0),
          content: Container(
            width: 300,
            child:Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 50.0),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(),
                        child: DefaultStickyHeaderController(
                          child: CustomScrollView(
                            shrinkWrap: true,
                            slivers: getList(sizelist),
                            reverse: false,
                          ),
                        )),
                  ),
                  InkWell(
                      child: Container(
                        height: 50,
                        decoration: new BoxDecoration(
                            gradient: LinearGradient(colors: <Color>[
                              AppTheme.aqua[50],
                              AppTheme.azureRadiance[50],
                            ]),
                            borderRadius: new BorderRadius.only(
                              bottomLeft: const Radius.circular(50.0),
                              bottomRight: const Radius.circular(50.0),
                            )),
                        child: Center(
                          child: Text(AppLocalizations.of(context).txtBtnSave,
                              style: Theme.of(context).textTheme.button,
                              textAlign: TextAlign.center),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                    ),

                ]),
          ));
    },
  );
}

List<Widget> getList(List<SizeGroup> sizelist) {
  List<Widget> widgets = List<Widget>();

  for (int i = 0; i < sizelist.length; i++)
    widgets.add(_StickyHeaderList(sizeGroup: sizelist[i]));

  return widgets;
}

class _StickyHeaderList extends StatefulWidget {

  final SizeGroup sizeGroup;

  const _StickyHeaderList({Key key, this.sizeGroup}) : super(key: key);

  @override
  _StickyHeaderListState createState() => _StickyHeaderListState();

}

class _StickyHeaderListState extends State<_StickyHeaderList>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: _header(),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => _content(i),
          childCount: widget.sizeGroup.sizes.length,
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Card(
          margin: EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0),
          color: AppTheme.riverBed[50],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child:  Text(
                widget.sizeGroup.sizetitlename.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.button,
              ),

          )),
    );
  }

  Widget _content(i) {
    return CheckboxListTile(
        title: Text(
          widget.sizeGroup.sizes[i].name.toString(),
          style: Theme.of(context).textTheme.display1,
        ),
        value: widget.sizeGroup.sizes[i].selected,
        selected: widget.sizeGroup.sizes[i].selected,
        activeColor: AppTheme.azureRadiance[50],
        onChanged: (bool value) {
          setState(() {
            widget.sizeGroup.sizes[i].selected = !widget.sizeGroup.sizes[i].selected;
          });
        });
  }

}
*/
